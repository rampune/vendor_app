import 'package:flutter/cupertino.dart';

class AdminController {
  static TextEditingController controller = TextEditingController();
  static TextEditingController emailController = TextEditingController();
  static TextEditingController businessNameController = TextEditingController();
  static TextEditingController vendorType = TextEditingController();
  static TextEditingController websiteController = TextEditingController();
  static TextEditingController addressController = TextEditingController();
  static TextEditingController pinController = TextEditingController();
  static TextEditingController phoneOrEmailController = TextEditingController();
  static TextEditingController stateController = TextEditingController();
  static TextEditingController cityController = TextEditingController();
  static TextEditingController constitutionController = TextEditingController();
  static TextEditingController foodTypeController = TextEditingController();

  // ── New: lat / lng ─────────────────────────────────────────────────────────
  static TextEditingController latitudeController = TextEditingController();
  static TextEditingController longitudeController = TextEditingController();

  // ── New: unique entry field ─────────────────────────────────────────────────
  static TextEditingController uniqueEntryController = TextEditingController();
}