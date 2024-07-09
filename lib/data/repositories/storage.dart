import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Storage {
  Storage._();
  static final instance = Storage._();

  saveToStorage(String key, String value) async {
    const storage = FlutterSecureStorage();
    return await storage.write(key: key, value: value);
  }

  getFromStorage(String key) async {
    const storage = FlutterSecureStorage();
    return await storage.read(key: key);
  }

  // Read all values
  getAllFromStorage() async {
    const storage = FlutterSecureStorage();
    return await storage.readAll();
  }

  deleteKeyOfStorage(String key) async {
    const storage = FlutterSecureStorage();
    return await storage.delete(key: key);
  }

  // Delete all
  deleteAllKeysOfStorage() async {
    const storage = FlutterSecureStorage();
    return await storage.deleteAll();
  }
}