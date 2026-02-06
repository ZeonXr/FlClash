import 'dart:convert';
import 'dart:io';

import 'package:archive/archive_io.dart';
<<<<<<< HEAD
import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:isar_community/isar.dart';
=======
import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/database/database.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/models/models.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
>>>>>>> 672eaccd35dcd84f7a0492638adc779a3fd97735
import 'package:path/path.dart';

Future<T> decodeJSONTask<T>(String data) async {
  return await compute<String, T>(_decodeJSON, data);
}

Future<T> _decodeJSON<T>(String content) async {
  return json.decode(content);
}

Future<String> encodeJSONTask<T>(T data) async {
  return await compute<T, String>(_encodeJSON, data);
}

Future<String> _encodeJSON<T>(T content) async {
  return json.encode(content);
}

Future<String> encodeYamlTask<T>(T data) async {
  return await compute<T, String>(_encodeYaml, data);
}

Future<String> _encodeYaml<T>(T content) async {
  return yaml.encode(content);
}

Future<List<Group>> toGroupsTask(ComputeGroupsState data) async {
  return await compute<ComputeGroupsState, List<Group>>(_toGroupsTask, data);
}

Future<List<Group>> _toGroupsTask(ComputeGroupsState state) async {
<<<<<<< HEAD
  final proxies = state.proxies;
=======
  final proxiesData = state.proxiesData;
  final all = proxiesData.all;
>>>>>>> 672eaccd35dcd84f7a0492638adc779a3fd97735
  final sortType = state.sortType;
  final delayMap = state.delayMap;
  final selectedMap = state.selectedMap;
  final defaultTestUrl = state.defaultTestUrl;
<<<<<<< HEAD
  if (proxies.isEmpty) return [];
  final groupNames = [
    UsedProxy.GLOBAL.name,
    ...(proxies[UsedProxy.GLOBAL.name]['all'] as List).where((e) {
      final proxy = proxies[e] ?? {};
      return GroupTypeExtension.valueList.contains(proxy['type']);
    }),
  ];
  final groupsRaw = groupNames.map((groupName) {
    final group = proxies[groupName];
    group['all'] = ((group['all'] ?? []) as List)
        .map((name) => proxies[name])
        .where((proxy) => proxy != null)
        .toList();
    return group;
  }).toList();
=======
  final proxies = proxiesData.proxies;
  if (proxies.isEmpty) return [];
  final groupsRaw = all
      .where((name) {
        final proxy = proxies[name] ?? {};
        return GroupTypeExtension.valueList.contains(proxy['type']);
      })
      .map((groupName) {
        final group = proxies[groupName];
        group['all'] = ((group['all'] ?? []) as List)
            .map((name) => proxies[name])
            .where((proxy) => proxy != null)
            .toList();
        return group;
      })
      .toList();
>>>>>>> 672eaccd35dcd84f7a0492638adc779a3fd97735
  final groups = groupsRaw.map((e) => Group.fromJson(e)).toList();
  return computeSort(
    groups: groups,
    sortType: sortType,
    delayMap: delayMap,
    selectedMap: selectedMap,
    defaultTestUrl: defaultTestUrl,
  );
}

Future<Map<String, dynamic>> makeRealProfileTask(
  MakeRealProfileState data,
) async {
  return await compute<MakeRealProfileState, Map<String, dynamic>>(
    _makeRealProfileTask,
    data,
  );
}

Future<Map<String, dynamic>> _makeRealProfileTask(
  MakeRealProfileState data,
) async {
  final rawConfig = Map.from(data.rawConfig);
  final realPatchConfig = data.realPatchConfig;
  final profilesPath = data.profilesPath;
  final profileId = data.profileId;
  final overrideDns = data.overrideDns;
  final addedRules = data.addedRules;
  final appendSystemDns = data.appendSystemDns;
  final defaultUA = data.defaultUA;
  String getProvidersFilePathInner(String type, String url) {
    return join(
      profilesPath,
      'providers',
      profileId.toString(),
      type,
      url.toMd5(),
    );
  }

  rawConfig['external-controller'] = realPatchConfig.externalController.value;
  rawConfig['external-ui'] = '';
  rawConfig['interface-name'] = '';
  rawConfig['external-ui-url'] = '';
  rawConfig['tcp-concurrent'] = realPatchConfig.tcpConcurrent;
  rawConfig['unified-delay'] = realPatchConfig.unifiedDelay;
  rawConfig['ipv6'] = realPatchConfig.ipv6;
  rawConfig['log-level'] = realPatchConfig.logLevel.name;
  rawConfig['port'] = 0;
  rawConfig['socks-port'] = 0;
  rawConfig['keep-alive-interval'] = realPatchConfig.keepAliveInterval;
  rawConfig['mixed-port'] = realPatchConfig.mixedPort;
  rawConfig['port'] = realPatchConfig.port;
  rawConfig['socks-port'] = realPatchConfig.socksPort;
  rawConfig['redir-port'] = realPatchConfig.redirPort;
  rawConfig['tproxy-port'] = realPatchConfig.tproxyPort;
  rawConfig['find-process-mode'] = realPatchConfig.findProcessMode.name;
  rawConfig['allow-lan'] = realPatchConfig.allowLan;
  rawConfig['mode'] = realPatchConfig.mode.name;
  if (rawConfig['tun'] == null) {
    rawConfig['tun'] = {};
  }
  rawConfig['tun']['enable'] = realPatchConfig.tun.enable;
  rawConfig['tun']['device'] = realPatchConfig.tun.device;
  rawConfig['tun']['dns-hijack'] = realPatchConfig.tun.dnsHijack;
  rawConfig['tun']['stack'] = realPatchConfig.tun.stack.name;
  rawConfig['tun']['route-address'] = realPatchConfig.tun.routeAddress;
  rawConfig['tun']['auto-route'] = realPatchConfig.tun.autoRoute;
  rawConfig['geodata-loader'] = realPatchConfig.geodataLoader.name;
  if (rawConfig['sniffer']?['sniff'] != null) {
    for (final value in (rawConfig['sniffer']?['sniff'] as Map).values) {
      if (value['ports'] != null && value['ports'] is List) {
        value['ports'] =
            value['ports']?.map((item) => item.toString()).toList() ?? [];
      }
    }
  }
  if (rawConfig['profile'] == null) {
    rawConfig['profile'] = {};
  }
  if (rawConfig['proxy-providers'] != null) {
    final proxyProviders = rawConfig['proxy-providers'] as Map;
    for (final key in proxyProviders.keys) {
      final proxyProvider = proxyProviders[key];
      if (proxyProvider['type'] != 'http') {
        continue;
      }
      if (proxyProvider['url'] != null) {
        proxyProvider['path'] = getProvidersFilePathInner(
          'proxies',
          proxyProvider['url'],
        );
      }
    }
  }
  if (rawConfig['rule-providers'] != null) {
    final ruleProviders = rawConfig['rule-providers'] as Map;
    for (final key in ruleProviders.keys) {
      final ruleProvider = ruleProviders[key];
      if (ruleProvider['type'] != 'http') {
        continue;
      }
      if (ruleProvider['url'] != null) {
        ruleProvider['path'] = getProvidersFilePathInner(
          'rules',
          ruleProvider['url'],
        );
      }
    }
  }
  rawConfig['profile']['store-selected'] = false;
  rawConfig['geox-url'] = realPatchConfig.geoXUrl.toJson();
  rawConfig['global-ua'] = realPatchConfig.globalUa ?? defaultUA;
  if (rawConfig['hosts'] == null) {
    rawConfig['hosts'] = {};
  }
  for (final host in realPatchConfig.hosts.entries) {
    rawConfig['hosts'][host.key] = host.value.splitByMultipleSeparators;
  }
  if (rawConfig['dns'] == null) {
    rawConfig['dns'] = {};
  }
  final isEnableDns = rawConfig['dns']['enable'] == true;
  final systemDns = 'system://';
  if (overrideDns || !isEnableDns) {
    final dns = switch (!isEnableDns) {
      true => realPatchConfig.dns.copyWith(
        nameserver: [...realPatchConfig.dns.nameserver, systemDns],
      ),
      false => realPatchConfig.dns,
    };
    rawConfig['dns'] = dns.toJson();
    rawConfig['dns']['nameserver-policy'] = {};
    for (final entry in dns.nameserverPolicy.entries) {
      rawConfig['dns']['nameserver-policy'][entry.key] =
          entry.value.splitByMultipleSeparators;
    }
  }
  if (appendSystemDns) {
    final List<String> nameserver = List<String>.from(
      rawConfig['dns']['nameserver'] ?? [],
    );
    if (!nameserver.contains(systemDns)) {
      rawConfig['dns']['nameserver'] = [...nameserver, systemDns];
    }
  }
  List<String> rules = [];
  if (rawConfig['rules'] != null) {
    rules = List<String>.from(rawConfig['rules']);
  }
  rawConfig.remove('rules');
  if (addedRules.isNotEmpty) {
    final parsedNewRules = addedRules
        .map((item) => ParsedRule.parseString(item.value))
        .toList();
    final hasMatchPlaceholder = parsedNewRules.any(
      (item) => item.ruleTarget?.toUpperCase() == 'MATCH',
    );
    String? replacementTarget;

    if (hasMatchPlaceholder) {
      for (int i = rules.length - 1; i >= 0; i--) {
        final parsed = ParsedRule.parseString(rules[i]);
        if (parsed.ruleAction == RuleAction.MATCH) {
          final target = parsed.ruleTarget;
          if (target != null && target.isNotEmpty) {
            replacementTarget = target;
            break;
          }
        }
      }
    }
    final List<String> finalAddedRules;

    if (replacementTarget?.isNotEmpty == true) {
      finalAddedRules = [];
      for (int i = 0; i < parsedNewRules.length; i++) {
        final parsed = parsedNewRules[i];
        if (parsed.ruleTarget?.toUpperCase() == 'MATCH') {
          finalAddedRules.add(
            parsed.copyWith(ruleTarget: replacementTarget).value,
          );
        } else {
          finalAddedRules.add(addedRules[i].value);
        }
      }
    } else {
      finalAddedRules = addedRules.map((e) => e.value).toList();
    }
    rules = [...finalAddedRules, ...rules];
  }
  rawConfig['rules'] = rules;
  return Map<String, dynamic>.from(rawConfig);
}

<<<<<<< HEAD
Future<List<String>> shakingProfileTask(VM2<List<int>, List<int>> data) async {
  return await compute<
    VM3<List<int>, List<int>, RootIsolateToken>,
=======
Future<List<String>> shakingProfileTask(
  VM2<Iterable<int>, Iterable<int>> data,
) async {
  return await compute<
    VM3<Iterable<int>, Iterable<int>, RootIsolateToken>,
>>>>>>> 672eaccd35dcd84f7a0492638adc779a3fd97735
    List<String>
  >(_shakingProfileTask, VM3(data.a, data.b, RootIsolateToken.instance!));
}

Future<List<String>> _shakingProfileTask(
<<<<<<< HEAD
  VM3<List<int>, List<int>, RootIsolateToken> data,
=======
  VM3<Iterable<int>, Iterable<int>, RootIsolateToken> data,
>>>>>>> 672eaccd35dcd84f7a0492638adc779a3fd97735
) async {
  final profileIds = data.a;
  final scriptIds = data.b;
  final token = data.c;
  BackgroundIsolateBinaryMessenger.ensureInitialized(token);
  final profilesDir = Directory(await appPath.profilesPath);
  final scriptsDir = Directory(await appPath.scriptsDirPath);
  final providersDir = Directory(await appPath.getProvidersRootPath());
  final List<String> targets = [];
  void scanDirectory(
    Directory dir,
<<<<<<< HEAD
    List<int> baseNames, {
=======
    Iterable<int> baseNames, {
>>>>>>> 672eaccd35dcd84f7a0492638adc779a3fd97735
    bool skipProvidersFolder = false,
  }) {
    if (!dir.existsSync()) return;
    final entities = dir.listSync(recursive: false, followLinks: false);

    for (final entity in entities) {
      if (entity is File) {
        final id = basenameWithoutExtension(entity.path);
        if (!baseNames.contains(int.tryParse(id))) {
          targets.add(entity.path);
        }
      } else if (skipProvidersFolder && entity is Directory) {
        if (basename(entity.path) == 'providers') {
          continue;
        }
      }
    }
  }

  scanDirectory(profilesDir, profileIds, skipProvidersFolder: true);
  scanDirectory(providersDir, profileIds);
  scanDirectory(scriptsDir, scriptIds);
  return targets;
}

Future<String> encodeLogsTask(List<Log> data) async {
  return await compute<List<Log>, String>(_encodeLogsTask, data);
}

Future<String> _encodeLogsTask(List<Log> data) async {
  final logsRaw = data.map((item) => item.toString());
  final logsRawString = logsRaw.join('\n');
  return logsRawString;
}

Future<MigrationData> oldToNowTask(Map<String, Object?> data) async {
  final homeDir = await appPath.homeDirPath;
  return await compute<
    VM3<Map<String, Object?>, String, String>,
    MigrationData
  >(_oldToNowTask, VM3(data, homeDir, homeDir));
}

Future<MigrationData> _oldToNowTask(
  VM3<Map<String, Object?>, String, String> data,
) async {
  final configMap = data.a;
  final sourcePath = data.b;
  final targetPath = data.c;
<<<<<<< HEAD
  String getScriptPath(String root, String fileName) {
    return join(root, 'scripts', '$fileName.js');
  }

  String getProfilePath(String root, String fileName) {
    return join(root, 'profiles', '$fileName.yaml');
  }
=======
>>>>>>> 672eaccd35dcd84f7a0492638adc779a3fd97735

  final accessControlMap = configMap['accessControl'];
  final isAccessControl = configMap['isAccessControl'];
  if (accessControlMap != null) {
    (accessControlMap as Map)['enable'] = isAccessControl;
    if (configMap['vpnProps'] != null) {
      final vpnPropsRaw = configMap['vpnProps'] as Map;
      vpnPropsRaw['accessControl'] = accessControlMap;
    }
  }
  if (configMap['vpnProps'] != null) {
    final vpnPropsRaw = configMap['vpnProps'] as Map;
    vpnPropsRaw['accessControlProps'] = vpnPropsRaw['accessControl'];
  }
  configMap['davProps'] = configMap['dav'];
<<<<<<< HEAD
  configMap['appSettingProps'] = configMap['appSetting'];
  configMap['proxiesStyleProps'] = configMap['proxiesStyle'];
  configMap['proxiesStyleProps'] = configMap['proxiesStyle'];
=======
  final appSettingProps = configMap['appSetting'] as Map? ?? {};
  appSettingProps['restoreStrategy'] = appSettingProps['recoveryStrategy'];
  configMap['appSettingProps'] = appSettingProps;
  configMap['proxiesStyleProps'] = configMap['proxiesStyle'];
  configMap['proxiesStyleProps'] = configMap['proxiesStyle'];
  // final overwriteMap = configMap['overwrite'] as Map? ?? {};
  // configMap['overwriteType'] = overwriteMap['type'];
  // configMap['scriptId'] = overwriteMap['scriptOverwrite'];
>>>>>>> 672eaccd35dcd84f7a0492638adc779a3fd97735
  List rawScripts = configMap['scripts'] as List<dynamic>? ?? [];
  if (rawScripts.isEmpty) {
    final scriptPropsJson = configMap['scriptProps'] as Map<String, dynamic>?;
    if (scriptPropsJson != null) {
      rawScripts = scriptPropsJson['scripts'] as List<dynamic>? ?? [];
    }
  }
  final Map<String, int> idMap = {};
  final List<Script> scripts = [];
  for (final rawScript in rawScripts) {
    final id = rawScript['id'] as String?;
    final content = rawScript['content'] as String?;
    final label = rawScript['label'] as String?;
    if (id == null || content == null || label == null) {
      continue;
    }
    final newId = idMap.updateCacheValue(rawScript['id'], () => snowflake.id);
<<<<<<< HEAD
    final path = getScriptPath(targetPath, newId.toString());
    final file = File(path);
    if (!await file.exists()) {
      await file.create(recursive: true);
      await file.writeAsString(content);
      scripts.add(
        Script(id: newId, label: label, lastUpdateTime: DateTime.now()),
      );
    }
  }
  List rawRules = configMap['rules'] as List<dynamic>? ?? [];
  final List<Rule> rules = [];
  for (final rawRule in rawRules) {
    rawRule['id'] = idMap.updateCacheValue(rawRule['id'], () => snowflake.id);
    rules.add(Rule.fromJson(rawRule));
=======
    final path = _getScriptPath(targetPath, newId.toString());
    final file = File(path);
    await file.safeWriteAsString(content);
    scripts.add(
      Script(id: newId, label: label, lastUpdateTime: DateTime.now()),
    );
  }
  List rawRules = configMap['rules'] as List<dynamic>? ?? [];
  final List<Rule> rules = [];
  final List<ProfileRuleLink> links = [];
  for (final rawRule in rawRules) {
    final id = idMap.updateCacheValue(rawRule['id'], () => snowflake.id);
    rawRule['id'] = id;
    rules.add(Rule.fromJson(rawRule));
    links.add(ProfileRuleLink(ruleId: id));
>>>>>>> 672eaccd35dcd84f7a0492638adc779a3fd97735
  }
  List rawProfiles = configMap['profiles'] as List<dynamic>? ?? [];
  final List<Profile> profiles = [];
  for (final rawProfile in rawProfiles) {
    final rawId = rawProfile['id'] as String?;
    if (rawId == null) {
      continue;
    }
<<<<<<< HEAD
    final id = idMap.updateCacheValue(rawId, () => snowflake.id);
    rawProfile['id'] = id;
=======
    final profileId = idMap.updateCacheValue(rawId, () => snowflake.id);
    rawProfile['id'] = profileId;
>>>>>>> 672eaccd35dcd84f7a0492638adc779a3fd97735
    final overwrite = rawProfile['overwrite'] as Map?;
    if (overwrite != null) {
      final standardOverwrite = overwrite['standardOverwrite'] as Map?;
      if (standardOverwrite != null) {
        final addedRules = standardOverwrite['addedRules'] as List? ?? [];
        for (final addRule in addedRules) {
<<<<<<< HEAD
          addRule['id'] = idMap.updateCacheValue(
            addRule['id'],
            () => snowflake.id,
=======
          final id = idMap.updateCacheValue(addRule['id'], () => snowflake.id);
          addRule['id'] = id;
          rules.add(Rule.fromJson(addRule));
          links.add(
            ProfileRuleLink(
              profileId: profileId,
              ruleId: id,
              scene: RuleScene.added,
            ),
>>>>>>> 672eaccd35dcd84f7a0492638adc779a3fd97735
          );
        }
        final disabledRuleIds = standardOverwrite['disabledRuleIds'] as List?;
        if (disabledRuleIds != null) {
<<<<<<< HEAD
          final List newDisabledRuleIds = [];
          for (final disabledRuleId in disabledRuleIds) {
            final newDisabledRuleId = idMap[disabledRuleId];
            if (newDisabledRuleId != null) {
              newDisabledRuleIds.add(newDisabledRuleId);
            }
          }
          standardOverwrite['disabledRuleIds'] = newDisabledRuleIds;
=======
          for (final disabledRuleId in disabledRuleIds) {
            final newDisabledRuleId = idMap[disabledRuleId];
            if (newDisabledRuleId != null) {
              links.add(
                ProfileRuleLink(
                  profileId: profileId,
                  ruleId: newDisabledRuleId,
                  scene: RuleScene.disabled,
                ),
              );
            }
          }
>>>>>>> 672eaccd35dcd84f7a0492638adc779a3fd97735
        }
      }
      final scriptOverwrite = overwrite['scriptOverwrite'] as Map?;
      if (scriptOverwrite != null) {
        final scriptId = scriptOverwrite['scriptId'] as String?;
<<<<<<< HEAD
        scriptOverwrite['scriptId'] = scriptId != null ? idMap[scriptId] : null;
      }
    }

    final sourceFile = File(getProfilePath(sourcePath, rawId));
    final targetFilePath = getProfilePath(targetPath, id.toString());
    final targetFile = File(targetFilePath);
    if (!await targetFile.exists()) {
      await targetFile.create(recursive: true);
    }
    await sourceFile.safeCopy(targetFilePath);
    profiles.add(Profile.fromJson(rawProfile));
  }
  final currentProfileId = configMap['currentProfileId'] as String?;
  configMap['currentProfileId'] = currentProfileId != null
      ? idMap[currentProfileId]
      : null;

=======
        rawProfile['scriptId'] = scriptId != null ? idMap[scriptId] : null;
      }
      rawProfile['overwriteType'] = overwrite['type'];
    }

    final sourceFile = File(_getProfilePath(sourcePath, rawId));
    final targetFilePath = _getProfilePath(targetPath, profileId.toString());
    await sourceFile.safeCopy(targetFilePath);
    profiles.add(Profile.fromJson(rawProfile));
  }
  final currentProfileId = configMap['currentProfileId'];
  configMap['currentProfileId'] = currentProfileId != null
      ? idMap[currentProfileId]
      : null;
>>>>>>> 672eaccd35dcd84f7a0492638adc779a3fd97735
  return MigrationData(
    configMap: configMap,
    profiles: profiles,
    rules: rules,
    scripts: scripts,
<<<<<<< HEAD
=======
    links: links,
>>>>>>> 672eaccd35dcd84f7a0492638adc779a3fd97735
  );
}

Future<String> backupTask(
  Map<String, dynamic> configMap,
<<<<<<< HEAD
  List<String> fileNames,
) async {
  return await compute<
    VM3<Map<String, dynamic>, List<String>, RootIsolateToken>,
=======
  Iterable<String> fileNames,
) async {
  return await compute<
    VM3<Map<String, dynamic>, Iterable<String>, RootIsolateToken>,
>>>>>>> 672eaccd35dcd84f7a0492638adc779a3fd97735
    String
  >(_backupTask, VM3(configMap, fileNames, RootIsolateToken.instance!));
}

Future<String> _backupTask<T>(
<<<<<<< HEAD
  VM3<Map<String, dynamic>, List<String>, RootIsolateToken> args,
=======
  VM3<Map<String, dynamic>, Iterable<String>, RootIsolateToken> args,
>>>>>>> 672eaccd35dcd84f7a0492638adc779a3fd97735
) async {
  final configMap = args.a;
  final fileNames = args.b;
  final token = args.c;
  BackgroundIsolateBinaryMessenger.ensureInitialized(token);
<<<<<<< HEAD
  final isar = await globalState.openIsar();
=======
  final dbPath = await appPath.databasePath;
>>>>>>> 672eaccd35dcd84f7a0492638adc779a3fd97735
  final configStr = json.encode(configMap);
  final profilesDir = Directory(await appPath.profilesPath);
  final scriptsDir = Directory(await appPath.scriptsDirPath);
  final tempZipFilePath = await appPath.tempFilePath;
  final tempDBFile = File(await appPath.tempFilePath);
  final tempConfigFile = File(await appPath.tempFilePath);
<<<<<<< HEAD
  await isar.copyToFile(tempDBFile.path);
  final encoder = ZipFileEncoder();
  encoder.create(tempZipFilePath);
  await tempConfigFile.writeAsString(configStr);
  await encoder.addFile(tempDBFile, backupIsarName);
=======
  final dbFile = File(dbPath);
  if (await dbFile.exists()) {
    await dbFile.copy(tempDBFile.path);
  }
  final encoder = ZipFileEncoder();
  encoder.create(tempZipFilePath);
  await tempConfigFile.writeAsString(configStr);
  await encoder.addFile(tempDBFile, backupDatabaseName);
>>>>>>> 672eaccd35dcd84f7a0492638adc779a3fd97735
  await encoder.addFile(tempConfigFile, configJsonName);
  if (await profilesDir.exists()) {
    await encoder.addDirectory(
      profilesDir,
      filter: (file, _) {
        if (!fileNames.contains(basename(file.path))) {
          return ZipFileOperation.skip;
        }
        return ZipFileOperation.include;
      },
    );
  }
  if (await scriptsDir.exists()) {
    await encoder.addDirectory(
      scriptsDir,
      filter: (file, _) {
        if (!fileNames.contains(basename(file.path))) {
          return ZipFileOperation.skip;
        }
        return ZipFileOperation.include;
      },
    );
  }
  encoder.close();
  await tempConfigFile.safeDelete();
  await tempDBFile.safeDelete();
  return tempZipFilePath;
}

Future<MigrationData> restoreTask() async {
  return await compute<RootIsolateToken, MigrationData>(
    _restoreTask,
    RootIsolateToken.instance!,
  );
}

Future<MigrationData> _restoreTask(RootIsolateToken token) async {
  BackgroundIsolateBinaryMessenger.ensureInitialized(token);
  final backupFilePath = await appPath.backupFilePath;
  final restoreDirPath = await appPath.restoreDirPath;
  final homeDirPath = await appPath.homeDirPath;
  final zipDecoder = ZipDecoder();
  final input = InputFileStream(backupFilePath);
  final archive = zipDecoder.decodeStream(input);
  final dir = Directory(restoreDirPath);
  await dir.create(recursive: true);
  for (final file in archive.files) {
    final outPath = join(restoreDirPath, posix.normalize(file.name));
    final outputStream = OutputFileStream(outPath);
    file.writeContent(outputStream);
    await outputStream.close();
  }
  await input.close();
  final restoreConfigFile = File(join(restoreDirPath, configJsonName));
  if (!await restoreConfigFile.exists()) {
<<<<<<< HEAD
    throw '无效备份文件';
=======
    throw appLocalizations.invalidBackupFile;
>>>>>>> 672eaccd35dcd84f7a0492638adc779a3fd97735
  }
  final restoreConfigMap =
      json.decode(await restoreConfigFile.readAsString())
          as Map<String, Object?>?;
  final version = restoreConfigMap?['version'] ?? 0;
  MigrationData migrationData = MigrationData(configMap: restoreConfigMap);
  if (version == 0 && restoreConfigMap != null) {
    migrationData = await _oldToNowTask(
      VM3(restoreConfigMap, restoreDirPath, homeDirPath),
    );
    return migrationData;
  }
<<<<<<< HEAD
  final backupIsarFile = File(join(restoreDirPath, backupIsarName));
  if (!await backupIsarFile.exists()) {
    return migrationData;
  }
  final isar = await globalState.openIsar(
    directory: restoreDirPath,
    name: 'backup',
  );
  final profileCollections = await isar.profileCollections.where().findAll();
  final ruleCollections = await isar.ruleCollections.where().findAll();
  final scriptCollections = await isar.scriptCollections.where().findAll();
  migrationData = migrationData.copyWith(
    profiles: profileCollections.map((item) => item.toProfile()).toList(),
    rules: ruleCollections.map((item) => item.toRule()).toList(),
    scripts: scriptCollections.map((item) => item.toScript()).toList(),
  );
  await isar.close();
  return migrationData;
}
=======
  final backupDatabaseFile = File(join(restoreDirPath, backupDatabaseName));
  if (!await backupDatabaseFile.exists()) {
    return migrationData;
  }
  final database = Database(
    driftDatabase(
      name: 'database',
      native: DriftNativeOptions(
        databaseDirectory: () async => Directory(restoreDirPath),
      ),
    ),
  );
  final results = await Future.wait([
    database.profilesDao.all().get(),
    database.scriptsDao.all().get(),
    database.rules.all().map((item) => item.toRule()).get(),
    database.profileRuleLinks.all().map((item) => item.toLink()).get(),
  ]);
  final profiles = results[0].cast<Profile>();
  final scripts = results[1].cast<Script>();
  final profilesMigration = profiles.map(
    (item) => VM2(
      _getProfilePath(restoreDirPath, item.id.toString()),
      _getProfilePath(homeDirPath, item.id.toString()),
    ),
  );
  final scriptsMigration = scripts.map(
    (item) => VM2(
      _getScriptPath(restoreDirPath, item.id.toString()),
      _getScriptPath(homeDirPath, item.id.toString()),
    ),
  );
  await _copyWithMapList([...profilesMigration, ...scriptsMigration]);
  migrationData = migrationData.copyWith(
    profiles: profiles,
    scripts: scripts,
    rules: results[2].cast<Rule>(),
    links: results[3].cast<ProfileRuleLink>(),
  );
  await database.close();
  return migrationData;
}

Future<void> _copyWithMapList(List<VM2<String, String>> copyMapList) async {
  await Future.wait(
    copyMapList.map((item) => File(item.a).safeCopy(item.b)).toList(),
  );
}

String _getScriptPath(String root, String fileName) {
  return join(root, 'scripts', '$fileName.js');
}

String _getProfilePath(String root, String fileName) {
  return join(root, 'profiles', '$fileName.yaml');
}
>>>>>>> 672eaccd35dcd84f7a0492638adc779a3fd97735
