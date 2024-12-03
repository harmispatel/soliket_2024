import 'dart:convert';
import 'package:firebase_remote_config/firebase_remote_config.dart';

import 'app_down_model.dart';

class RemoteGlobalModel {
  AppDownMaster? appDownMaster;

  RemoteGlobalModel({
    this.appDownMaster,
  });

  RemoteGlobalModel.fromJson(Map<String, RemoteConfigValue> json) {
    appDownMaster =
        AppDownMaster.fromJson(jsonDecode(json['app_maintenance']?.asString() ?? ""));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['app_maintenance'] = appDownMaster;

    return data;
  }
}
