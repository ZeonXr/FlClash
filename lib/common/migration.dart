import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/models/models.dart';

class Migration {
  static Migration? _instance;
<<<<<<< HEAD
=======
  late int _oldVersion;
>>>>>>> 672eaccd35dcd84f7a0492638adc779a3fd97735

  Migration._internal();

  final currentVersion = 1;

  factory Migration() {
    _instance ??= Migration._internal();
    return _instance!;
  }

<<<<<<< HEAD
  Future<MigrationData> migrationIfNeeded(
    Map<String, Object?>? configMap,
  ) async {
    final version = await preferences.getVersion();
    MigrationData data = MigrationData(configMap: configMap);
    if (version == 0 && configMap != null) {
      data = await _oldToNow(configMap);
    }
    await preferences.setVersion(currentVersion);
    return data;
=======
  Future<Config> migrationIfNeeded(
    Map<String, Object?>? configMap, {
    required Future<Config> Function(MigrationData data) sync,
  }) async {
    _oldVersion = await preferences.getVersion();
    if (_oldVersion == currentVersion) {
      try {
        return Config.realFromJson(configMap);
      } catch (_) {
        final isV0 = configMap?['proxiesStyle'] != null;
        if (isV0) {
          _oldVersion = 0;
        } else {
          throw 'Local data is damaged. A reset is required to fix this issue.';
        }
      }
    }
    MigrationData data = MigrationData(configMap: configMap);
    if (_oldVersion == 0 && configMap != null) {
      final clashConfigMap = await preferences.getClashConfigMap();
      if (clashConfigMap != null) {
        configMap['patchClashConfig'] = clashConfigMap;
        await preferences.clearClashConfig();
      }
      data = await _oldToNow(configMap);
    }
    final res = await sync(data);
    await preferences.setVersion(currentVersion);
    return res;
>>>>>>> 672eaccd35dcd84f7a0492638adc779a3fd97735
  }

  Future<MigrationData> _oldToNow(Map<String, Object?> configMap) async {
    return await oldToNowTask(configMap);
  }
}

final migration = Migration();
