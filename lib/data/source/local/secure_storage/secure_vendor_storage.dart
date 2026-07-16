import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:new_pubup_partner/features/admin_details/model/business_resister_model.dart';


class SecureVendorStorage {
  SecureVendorStorage._private();
  static final SecureVendorStorage _instance = SecureVendorStorage._private();
  factory SecureVendorStorage() => _instance;

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  static const String _keyLoginIdentifier = 'vendor_login_identifier'; // phone or email
  static const String _keyLoginType = 'vendor_login_type'; // "phone" or "email"
  static const String _keyBusinessProfile = 'vendor_business_profile';

  // Save login (phone or email)
  Future<void> saveLogin({
    required String identifier, // +919876543210 or abc@gmail.com
    required String type,       // "phone" or "email"
  }) async {
    await _storage.write(key: _keyLoginIdentifier, value: identifier);
    await _storage.write(key: _keyLoginType, value: type);
  }

  // Get login identifier (phone/email)
  Future<String?> getLoginIdentifier() async {
    return await _storage.read(key: _keyLoginIdentifier);
  }

  // Get login type
  Future<String?> getLoginType() async {
    return await _storage.read(key: _keyLoginType);
  }

  // Save business profile
  Future<void> saveBusinessProfile(BusinessRegisterModel profile) async {
    await _storage.write(key: _keyBusinessProfile, value: jsonEncode(profile.toJson()));
  }

  // Get business profile
  Future<BusinessRegisterModel?> getBusinessProfile() async {
    final String? data = await _storage.read(key: _keyBusinessProfile);
    if (data == null) return null;
    try {
      return BusinessRegisterModel.fromJson(jsonDecode(data));
    } catch (e) {
      return null;
    }
  }

  // Logout
  Future<void> logout() async {
    await _storage.delete(key: _keyLoginIdentifier);
    await _storage.delete(key: _keyLoginType);
    // Optional: keep business profile or clear it
    // await _storage.delete(key: _keyBusinessProfile);
  }

  Future<void> clearAll() async => await _storage.deleteAll();
}