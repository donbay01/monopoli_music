import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigService {
  static var config = FirebaseRemoteConfig.instance;

  static Future<bool> activate() => config.fetchAndActivate();
}
