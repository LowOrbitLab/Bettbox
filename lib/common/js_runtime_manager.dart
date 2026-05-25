import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:isolate';

import 'package:flutter_js/flutter_js.dart';
import 'package:synchronized/synchronized.dart';

class JavaScriptRuntimeManager {
  static Future<Map<String, dynamic>> evaluate({
    required Map<String, dynamic> config,
    required String script,
  }) async {
    final isQuickJsWithLeak = Platform.isWindows || Platform.isAndroid || Platform.isLinux;

    if (isQuickJsWithLeak) {
      return await Isolate.run(() async {
        final runtime = getJavascriptRuntime();
        try {
          return await _evaluateInRuntime(runtime, config, script);
        } finally {
          runtime.dispose();
        }
      });
    } else {
      return await execute((runtime) async {
        return await _evaluateInRuntime(runtime, config, script);
      });
    }
  }

  static Future<Map<String, dynamic>> _evaluateInRuntime(
    JavascriptRuntime runtime,
    Map<String, dynamic> config,
    String script,
  ) async {
    final configJs = json.encode(config);
    final scriptJs = json.encode(script);
    final res = await runtime.evaluateAsync('''
      (() => {
        const __bettboxConfig = $configJs;
        const __bettboxScript = $scriptJs;
        const __bettboxMain = new Function(
          __bettboxScript + '\\nreturn typeof main === "function" ? main : null;',
        )();
        if (typeof __bettboxMain !== 'function') {
          throw new Error('Script must define main(config)');
        }
        return __bettboxMain(__bettboxConfig);
      })()
    ''').timeout(const Duration(seconds: 10));

    if (res.isError) {
      throw res.stringResult;
    }

    final rawResult = res.rawResult;
    if (rawResult is Pointer) {
      return runtime.convertValue<Map<String, dynamic>>(res) ?? config;
    } else if (rawResult is Map) {
      return Map<String, dynamic>.from(rawResult);
    } else {
      return config;
    }
  }

  static JavascriptRuntime? _instance;
  static final Lock _lock = Lock();
  static int _activeCount = 0;
  static bool _isDisposing = false;
  static Timer? _disposeTimer;
  static const Duration _disposeDelay = Duration(seconds: 10);

  static Future<T> execute<T>(
    Future<T> Function(JavascriptRuntime runtime) task,
  ) async {
    final runtime = await _acquire();
    try {
      return await task(runtime).timeout(const Duration(seconds: 10));
    } catch (e) {
      if (e is TimeoutException) {
        await _forceDispose();
      }
      rethrow;
    } finally {
      await _release();
    }
  }

  static Future<void> _forceDispose() async {
    await _lock.synchronized(() async {
      if (_instance != null) {
        _isDisposing = true;
        try {
          _instance!.dispose();
        } catch (_) {}
        _instance = null;
        _isDisposing = false;
      }
    });
  }

  static Future<JavascriptRuntime> _acquire() async {
    return _lock.synchronized(() async {
      while (_isDisposing) {
        await Future.delayed(const Duration(milliseconds: 10));
      }
      _disposeTimer?.cancel();
      _disposeTimer = null;
      _activeCount++;
      _instance ??= getJavascriptRuntime();
      return _instance!;
    });
  }

  static Future<void> _release() async {
    await _lock.synchronized(() async {
      _activeCount--;
      if (_activeCount <= 0 && _instance != null) {
        _disposeTimer?.cancel();
        _disposeTimer = Timer(_disposeDelay, () {
          dispose();
        });
      }
    });
  }

  static Future<void> dispose() async {
    return _lock.synchronized(() async {
      if (_activeCount > 0) return;
      if (_instance != null) {
        _isDisposing = true;
        try {
          _instance!.dispose();
        } catch (_) {}
        _instance = null;
        _isDisposing = false;
      }
    });
  }
}
