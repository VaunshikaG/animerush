import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HomeStorage {
  Future<void> storeHomeData(String data) async {
    const storage = FlutterSecureStorage();
    String jsonString = jsonEncode(data);
    await storage.write(key: 'homeKey', value: jsonString);
  }

  Future<String?> getHomeData() async {
    const storage = FlutterSecureStorage();
    final jsonString = await storage.read(key: 'homeKey');

    if (jsonString != null) {
      return jsonDecode(jsonString);
    }

    return jsonString;
  }
}

class ProfileStorage {
  Future<void> storeProfile(String data) async {
    const storage = FlutterSecureStorage();
    String jsonString = jsonEncode(data);
    await storage.write(key: 'profileKey', value: jsonString);
  }

  Future<String?> getProfile() async {
    const storage = FlutterSecureStorage();
    final jsonString = await storage.read(key: 'profileKey');

    if (jsonString != null) {
      return jsonDecode(jsonString);
    }

    return jsonString;
  }
}
