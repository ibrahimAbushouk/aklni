import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  SharedPrefHelper._();

  static SharedPreferences? _prefs;
  static bool _initialized = false;

  /// تهيئة مبكرة للـ SharedPreferences (يُستدعى في main.dart)
  static Future<void> init() async {
    try {
      if (!_initialized) {
        _prefs = await SharedPreferences.getInstance();
        _initialized = true;
        debugPrint('SharedPrefHelper: تم التهيئة بنجاح');
      }
    } catch (e) {
      debugPrint('SharedPrefHelper Init Error: $e');
      rethrow;
    }
  }

  /// الحصول على instance (يتطلب استدعاء init() أولاً)
  static SharedPreferences get instance {
    if (_prefs == null || !_initialized) {
      throw StateError(
          'SharedPrefHelper غير مهيء. يرجى استدعاء init() في main.dart أولاً');
    }
    return _prefs!;
  }

  /// الحصول على instance مع التهيئة التلقائية (للاستخدام القديم)
  static Future<SharedPreferences> getInstance() async {
    if (_prefs == null) {
      await init();
    }
    return _prefs!;
  }

  /// حفظ بيانات مع معالجة الأخطاء
  static Future<void> setData(String key, dynamic value) async {
    try {
      final prefs = await getInstance();
      debugPrint("SharedPrefHelper: setData → key: $key | value: $value");

      if (value is String) {
        await prefs.setString(key, value);
      } else if (value is int) {
        await prefs.setInt(key, value);
      } else if (value is bool) {
        await prefs.setBool(key, value);
      } else if (value is double) {
        await prefs.setDouble(key, value);
      } else if (value is List<String>) {
        await prefs.setStringList(key, value);
      } else {
        throw ArgumentError(
            'نوع البيانات غير مدعوم في SharedPreferences: ${value.runtimeType}');
      }
    } catch (e) {
      debugPrint('SharedPrefHelper setData Error: $e');
      rethrow;
    }
  }

  /// قراءة بيانات مع نوع محدد ومعالجة محسنة للأخطاء
  static Future<T?> getData<T>(String key) async {
    try {
      final prefs = await getInstance();
      debugPrint('SharedPrefHelper: getData<$T> → key: $key');

      final value = prefs.get(key);
      if (value == null) return null;

      // معالجة الأنواع المختلفة
      if (T == String && value is String) return value as T;
      if (T == int && value is int) return value as T;
      if (T == bool && value is bool) return value as T;
      if (T == double && value is double) return value as T;

      if (value is List<String> && T == List<String>) {
        return value as T;
      }

      // في حالة عدم تطابق النوع
      debugPrint(
          'SharedPrefHelper: نوع البيانات غير متطابق. متوقع: $T، موجود: ${value.runtimeType}');
      return null;
    } catch (e) {
      debugPrint('SharedPrefHelper getData Error: $e');
      return null;
    }
  }

  /// الحصول على قيمة مع قيمة افتراضية
  static Future<T> getDataWithDefault<T>(String key, T defaultValue) async {
    try {
      final value = await getData<T>(key);
      return value ?? defaultValue;
    } catch (e) {
      debugPrint('SharedPrefHelper getDataWithDefault Error: $e');
      return defaultValue;
    }
  }

  /// دوال مختصرة محسنة
  static Future<String?> getString(String key) async {
    try {
      return instance.getString(key);
    } catch (e) {
      return (await getInstance()).getString(key);
    }
  }

  static Future<String> getStringWithDefault(String key,
      [String defaultValue = '']) async {
    return await getDataWithDefault<String>(key, defaultValue);
  }

  static Future<bool?> getBool(String key) async {
    try {
      return instance.getBool(key);
    } catch (e) {
      return (await getInstance()).getBool(key);
    }
  }

  static Future<bool> getBoolWithDefault(String key,
      [bool defaultValue = false]) async {
    return await getDataWithDefault<bool>(key, defaultValue);
  }

  // باقي الدوال...
  static Future<bool> containsKey(String key) async {
    try {
      return (await getInstance()).containsKey(key);
    } catch (e) {
      debugPrint('SharedPrefHelper containsKey Error: $e');
      return false;
    }
  }

  static Future<bool> removeData(String key) async {
    try {
      debugPrint('SharedPrefHelper: removeData → key: $key');
      final result = await (await getInstance()).remove(key);
      debugPrint('SharedPrefHelper: تم حذف $key بنجاح: $result');
      return result;
    } catch (e) {
      debugPrint('SharedPrefHelper removeData Error: $e');
      return false;
    }
  }

  static Future<bool> clearAllData() async {
    try {
      debugPrint('SharedPrefHelper: بدء مسح جميع البيانات');
      final result = await (await getInstance()).clear();
      debugPrint('SharedPrefHelper: تم مسح جميع البيانات بنجاح: $result');
      return result;
    } catch (e) {
      debugPrint('SharedPrefHelper clearAllData Error: $e');
      return false;
    }
  }

  /// فحص حالة التهيئة
  static bool get isInitialized => _initialized && _prefs != null;

  /// إعادة تهيئة (في حالات نادرة)
  static Future<void> reinitialize() async {
    _initialized = false;
    _prefs = null;
    await init();
  }
}