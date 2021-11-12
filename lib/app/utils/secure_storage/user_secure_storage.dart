import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserSecureStorage {
  static final _storage = FlutterSecureStorage();

  static const _keyUsername = 'username';
  static const _keyPassword = 'password';
  static const _keyToggled = 'toggled';
  static const _keyPets = 'pets';
  static const _keyBirthday = 'birthday';

  static Future setUsername(String username) async =>
      await _storage.write(key: _keyUsername, value: username);

  static Future<String?> getUsername() async =>
      await _storage.read(key: _keyUsername);

  static Future setPassword(String password) async =>
      await _storage.write(key: _keyPassword, value: password);

  static Future<String?> getPassword() async =>
      await _storage.read(key: _keyPassword);

  static Future setToggled(String toggled) async =>
      await _storage.write(key: _keyToggled, value: toggled);

  static Future<String?> getToggled() async =>
      await _storage.read(key: _keyToggled);

  static Future setPets(List<String> pets) async {
    final value = json.encode(pets);

    await _storage.write(key: _keyPets, value: value);
  }

  static Future<List<String>?> getPets() async {
    final value = await _storage.read(key: _keyPets);

    return value == null ? null : List<String>.from(json.decode(value));
  }

  static Future setBirthday(DateTime dateOfBirth) async {
    final birthday = dateOfBirth.toIso8601String();

    await _storage.write(key: _keyBirthday, value: birthday);
  }

  static Future<DateTime?> getBirthday() async {
    final birthday = await _storage.read(key: _keyBirthday);

    return birthday == null ? null : DateTime.tryParse(birthday);
  }
}
