import 'dart:convert';
import 'dart:developer';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'model/remote_global_model.dart';

class RemoteGlobalConfig {
  static RemoteGlobalModel _remoteGlobalModel = RemoteGlobalModel();

  static RemoteGlobalModel get remoteGlobalModel => _remoteGlobalModel;

  static Future<void> init() async {
    try {
      FirebaseRemoteConfig remoteConfigInstance = FirebaseRemoteConfig.instance;
      await remoteConfigInstance.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 1),
        minimumFetchInterval: Duration.zero,
      ));
      await remoteConfigInstance.setDefaults({
        "app_maintenance": jsonEncode({"appDown": false}),
      });
      await remoteConfigInstance.fetchAndActivate();
      Map<String, RemoteConfigValue> remoteGlobalConfigValue =
          remoteConfigInstance.getAll().map<String, RemoteConfigValue>(
                (key, value) => MapEntry(key, value),
              );
      _remoteGlobalModel = RemoteGlobalModel.fromJson(remoteGlobalConfigValue);
      await logRemoteConfigValues(remoteConfigInstance);
    } catch (e, st) {
      log(e.toString(), stackTrace: st);
    }
  }

  static Future<void> logRemoteConfigValues(
      FirebaseRemoteConfig remoteConfig) async {
    log("======FIREBASE REMOTE CONFIG========");
    try {
      final keys = remoteConfig.getAll().keys.toList();
      for (final key in keys) {
        final value = remoteConfig.getString(key);
        log('$key: $value\n');
      }
    } catch (e, st) {
      log('Error fetching remote config: $e', stackTrace: st);
    }
  }
}
