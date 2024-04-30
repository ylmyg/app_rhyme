// This file is automatically generated, so please do not edit it.
// Generated by `flutter_rust_bridge`@ 2.0.0-dev.32.

// ignore_for_file: invalid_use_of_internal_member, unused_import, unnecessary_import

import '../frb_generated.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';

class Config {
  final bool userAgreement;
  final String? externApiPath;

  const Config({
    required this.userAgreement,
    this.externApiPath,
  });

  static Future<Config> load({dynamic hint}) =>
      RustLib.instance.api.configLoad(hint: hint);

  Future<void> save({dynamic hint}) =>
      RustLib.instance.api.configSave(that: this, hint: hint);

  @override
  int get hashCode => userAgreement.hashCode ^ externApiPath.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Config &&
          runtimeType == other.runtimeType &&
          userAgreement == other.userAgreement &&
          externApiPath == other.externApiPath;
}