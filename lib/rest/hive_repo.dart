import 'dart:convert';
import 'dart:io';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

const String _baseUrl = 'baseURL';
const String _user = 'user';

class HiveRepo {
  static HiveRepo? _instance;
  static late Box _box;

  HiveRepo._(Box box) {
    _box = box;
  }

  static HiveRepo get instance => _instance!;

  static Future<void> initialize(String appName) async {
    Directory? directory;
    try {
      directory = await getApplicationDocumentsDirectory();
    } catch (e) {
      //
    }
    Hive.init(directory?.path);
    _instance ??= HiveRepo._(await Hive.openBox(
      'demoazinova-$appName',
    ));
  }

  setBaseUrl({String? baseUrl, String? refreshToken}) {
    setBaseUrlValue(baseUrl);
  }

  setUser({String? user}) {
    setUserValue(user);
  }

  Future<void> setBaseUrlValue(String? value) async =>
      _box.put(_baseUrl, value);

  Future<void> setUserValue(String? value) async =>
      _box.put(_user, value);

  String? getBaseUrl() => _box.get(_baseUrl) as String?;

  String? getUserValue() => _box.get(_user) as String?;


  Future<void> logout() async {
    await _box.delete(_user);
    await _box.delete(_baseUrl);
  }

  Future<void> storeData(String key, String data) async =>
      await _box.put(key, data);

  String? readData(key) => _box.get(key) as String?;
}
