import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/models/college_models.dart';

class StorageService {
  static const String _repaymentKey = 'repayment_config';
  static const String _moratoriumKey = 'moratorium_config';

  Future<void> saveRepaymentConfig(RepaymentConfig config) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_repaymentKey, jsonEncode(config.toJson()));
  }

  Future<RepaymentConfig?> getRepaymentConfig() async {
    final prefs = await SharedPreferences.getInstance();
    final String? jsonStr = prefs.getString(_repaymentKey);
    if (jsonStr == null) return null;
    try {
      return RepaymentConfig.fromJson(jsonDecode(jsonStr));
    } catch (e) {
      return null;
    }
  }

  Future<void> saveMoratoriumConfig(MoratoriumConfig config) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_moratoriumKey, jsonEncode(config.toJson()));
  }

  Future<MoratoriumConfig?> getMoratoriumConfig() async {
    final prefs = await SharedPreferences.getInstance();
    final String? jsonStr = prefs.getString(_moratoriumKey);
    if (jsonStr == null) return null;
    try {
      return MoratoriumConfig.fromJson(jsonDecode(jsonStr));
    } catch (e) {
      return null;
    }
  }

  static const String _collegesKey = 'colleges_list';

  Future<void> saveColleges(List<CollegeEntity> colleges) async {
    final prefs = await SharedPreferences.getInstance();
    final List<Map<String, dynamic>> jsonList = colleges.map((c) => c.toJson()).toList();
    await prefs.setString(_collegesKey, jsonEncode(jsonList));
  }

  Future<List<CollegeEntity>> getColleges() async {
    final prefs = await SharedPreferences.getInstance();
    final String? jsonStr = prefs.getString(_collegesKey);
    if (jsonStr == null) return [];
    try {
      final List<dynamic> jsonList = jsonDecode(jsonStr);
      return jsonList.map((j) => CollegeEntity.fromJson(j)).toList();
    } catch (e) {
      return [];
    }
  }
  
  static const String _collectionsKey = 'collections_list';

  Future<void> saveCollections(List<CollectionEntity> collections) async {
    final prefs = await SharedPreferences.getInstance();
    final List<Map<String, dynamic>> jsonList = collections.map((c) => c.toJson()).toList();
    await prefs.setString(_collectionsKey, jsonEncode(jsonList));
  }

  Future<List<CollectionEntity>> getCollections() async {
    final prefs = await SharedPreferences.getInstance();
    final String? jsonStr = prefs.getString(_collectionsKey);
    if (jsonStr == null) return [];
    try {
      final List<dynamic> jsonList = jsonDecode(jsonStr);
      return jsonList.map((j) => CollectionEntity.fromJson(j)).toList();
    } catch (e) {
      return [];
    }
  }

  // Clear all data (useful for testing or reset)
  Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_repaymentKey);
    await prefs.remove(_moratoriumKey);
    await prefs.remove(_collegesKey);
    await prefs.remove(_collectionsKey);
  }
}
