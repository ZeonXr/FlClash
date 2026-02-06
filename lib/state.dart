import 'dart:async';
import 'dart:convert';
<<<<<<< HEAD
import 'dart:io';

import 'package:animations/animations.dart';
import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
=======
import 'dart:ffi' as ffi;

import 'package:animations/animations.dart';
>>>>>>> 672eaccd35dcd84f7a0492638adc779a3fd97735
import 'package:dynamic_color/dynamic_color.dart';
import 'package:fl_clash/common/theme.dart';
import 'package:fl_clash/core/core.dart';
import 'package:fl_clash/plugins/service.dart';
import 'package:fl_clash/providers/app.dart';
import 'package:fl_clash/providers/config.dart';
import 'package:fl_clash/providers/database.dart';
import 'package:fl_clash/widgets/dialog.dart';
import 'package:fl_clash/widgets/list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:isar_community/isar.dart';
import 'package:material_color_utilities/palettes/core_palette.dart';
import 'package:package_info_plus/package_info_plus.dart';
<<<<<<< HEAD
import 'package:url_launcher/url_launcher.dart';

import 'common/common.dart';
import 'controller.dart';
import 'handler.dart';
=======
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:url_launcher/url_launcher.dart';

import 'common/common.dart';
import 'database/database.dart';
import 'l10n/l10n.dart';
>>>>>>> 672eaccd35dcd84f7a0492638adc779a3fd97735
import 'models/models.dart';

typedef UpdateTasks = List<FutureOr Function()>;

class GlobalState {
  static GlobalState? _instance;
  final navigatorKey = GlobalKey<NavigatorState>();
  Timer? timer;
<<<<<<< HEAD
  late final Isar isar;
  late Config config;
  late AppState appState;
  late RunningState runningState;
=======
>>>>>>> 672eaccd35dcd84f7a0492638adc779a3fd97735
  bool isPre = true;
  late final String coreSHA256;
  late final PackageInfo packageInfo;
  Function? updateCurrentDelayDebounce;
  late Measure measure;
  late CommonTheme theme;
  late Color accentColor;
  bool needInitStatus = true;
  CorePalette? corePalette;
  DateTime? startTime;
  UpdateTasks tasks = [];
<<<<<<< HEAD
  AppController? _appController;
  bool isInit = false;
  bool isUserDisconnected = false;
=======
>>>>>>> 672eaccd35dcd84f7a0492638adc779a3fd97735
  SetupState? lastSetupState;
  VpnState? lastVpnState;

  bool get isStart => startTime != null && startTime!.isBeforeNow;

  GlobalState._internal();

  factory GlobalState() {
    _instance ??= GlobalState._internal();
    return _instance!;
  }

<<<<<<< HEAD
  String get ua => config.patchClashConfig.globalUa ?? packageInfo.ua;

  List<Profile> get profiles {
    return runningState.profiles;
  }

  Profile? get currentProfile {
    final profileId = config.currentProfileId;
    return runningState.profiles.getProfile(profileId);
  }

  List<Script> get scripts {
    return runningState.scripts;
  }

  List<Rule> get rules {
    return runningState.rules;
  }

  SetupParams get setupParams {
    return appHandler.getSetupParams(
      selectedMap: currentProfile?.selectedMap ?? {},
      testUrl: config.appSettingProps.testUrl,
    );
  }

  VpnOptions get vpnOptions {
    return appHandler.getVpnOptions(
      stack: config.patchClashConfig.tun.stack.name,
      enable: config.vpnProps.enable,
      systemProxy: config.vpnProps.systemProxy,
      port: config.patchClashConfig.mixedPort,
      ipv6: config.vpnProps.ipv6,
      dnsHijacking: config.vpnProps.dnsHijacking,
      accessControlProps: config.vpnProps.accessControlProps,
      allowBypass: config.vpnProps.allowBypass,
      bypassDomain: config.networkProps.bypassDomain,
    );
  }

  SharedState get sharedState {
    return appHandler.getSharedState(
      currentProfileName: currentProfile?.label ?? '',
      onlyStatisticsProxy: config.appSettingProps.onlyStatisticsProxy,
      stopText: appLocalizations.stop,
      crashlytics: config.appSettingProps.crashlytics,
      stopTip: appLocalizations.stopVpn,
      startTip: appLocalizations.startVpn,
      setupParams: setupParams,
      vpnOptions: vpnOptions,
    );
  }

  Future<void> initApp(int version) async {
=======
  Future<ProviderContainer> init(int version) async {
>>>>>>> 672eaccd35dcd84f7a0492638adc779a3fd97735
    coreSHA256 = const String.fromEnvironment('CORE_SHA256');
    isPre = const String.fromEnvironment('APP_ENV') != 'stable';
    await _initDynamicColor();
<<<<<<< HEAD
    await init();
    await window?.init(version, config.windowProps);
=======
    return await _initData(version);
>>>>>>> 672eaccd35dcd84f7a0492638adc779a3fd97735
  }

  Future<void> _initDynamicColor() async {
    try {
      corePalette = await DynamicColorPlugin.getCorePalette();
      accentColor =
          await DynamicColorPlugin.getAccentColor() ??
          Color(defaultPrimaryColor);
    } catch (_) {}
  }

<<<<<<< HEAD
  Future<void> shakingStore() async {
    final profileIds = runningState.profiles.map((item) => item.id).toList();
    final scriptIds = runningState.scripts.map((item) => item.id).toList();

    final pathsToDelete = await shakingProfileTask(VM2(profileIds, scriptIds));
    if (pathsToDelete.isNotEmpty) {
      final deleteFutures = pathsToDelete.map((path) async {
        try {
          final res = await coreController.deleteFile(path);
          if (res.isNotEmpty) {
            throw res;
          }
        } catch (e) {
          rethrow;
        }
      });

      await Future.wait(deleteFutures);
    }
  }

  Future<void> init() async {
    packageInfo = await PackageInfo.fromPlatform();
    isar = await openIsar();
    final configMap = await preferences.getConfigMap();
    final migrationData = await migration.migrationIfNeeded(configMap);
    config = migrationData.configMap != null
        ? Config.fromJson(migrationData.configMap!)
        : Config(themeProps: defaultThemeProps);
    await isar.writeTxn(() async {
      await isar.profileCollections.putAll(
        migrationData.profiles.mapIndexed((index, profile) {
          return ProfileCollection.fromProfile(profile, index);
        }).toList(),
      );
      await isar.scriptCollections.putAll(
        migrationData.scripts.map(ScriptCollection.fromScript).toList(),
      );
      await isar.ruleCollections.putAll(
        migrationData.rules.mapIndexed((index, rule) {
          return RuleCollection.fromRule(rule, index);
        }).toList(),
      );
    });
    final results = await Future.wait([
      isar.profileCollections.where().sortByOrder().findAll(),
      isar.scriptCollections.where().findAll(),
      isar.ruleCollections.where().sortByOrder().findAll(),
    ]);
    final profileCollection = results[0] as List<ProfileCollection>;
    final scriptCollection = results[1] as List<ScriptCollection>;
    final ruleCollections = results[2] as List<RuleCollection>;
    final profiles = profileCollection.map((item) => item.toProfile());
    final scripts = scriptCollection.map((item) => item.toScript());
    final rules = ruleCollections.map((item) => item.toRule());
    runningState = RunningState(
      profiles: profiles.toList(),
      rules: rules.toList(),
      scripts: scripts.toList(),
    );
=======
  Future<ProviderContainer> _initData(int version) async {
    final appState = AppState(
      brightness: WidgetsBinding.instance.platformDispatcher.platformBrightness,
      version: version,
      viewSize: Size.zero,
      requests: FixedList(maxLength),
      logs: FixedList(maxLength),
      traffics: FixedList(30),
      totalTraffic: Traffic(),
      systemUiOverlayStyle: const SystemUiOverlayStyle(),
    );
    final appStateOverrides = buildAppStateOverrides(appState);
    packageInfo = await PackageInfo.fromPlatform();
    final configMap = await preferences.getConfigMap();
    final config = await migration.migrationIfNeeded(
      configMap,
      sync: (data) async {
        final newConfigMap = data.configMap;
        final config = Config.realFromJson(newConfigMap);
        await Future.wait([
          database.restore(data.profiles, data.scripts, data.rules, data.links),
          preferences.saveConfig(config),
        ]);
        return config;
      },
    );
    final configOverrides = buildConfigOverrides(config);
    final container = ProviderContainer(
      overrides: [...appStateOverrides, ...configOverrides],
    );
    final profiles = await database.profilesDao.all().get();
    container.read(profilesProvider.notifier).setAndReorder(profiles);
>>>>>>> 672eaccd35dcd84f7a0492638adc779a3fd97735
    await AppLocalizations.load(
      utils.getLocaleForString(config.appSettingProps.locale) ??
          WidgetsBinding.instance.platformDispatcher.locale,
    );
    await window?.init(version, config.windowProps);
    return container;
  }

<<<<<<< HEAD
  Future<Isar> openIsar({String? directory, String? name}) async {
    return await Isar.open(
      [ProfileCollectionSchema, ScriptCollectionSchema, RuleCollectionSchema],
      directory: directory ?? await appPath.homeDirPath,
      name: name ?? 'db',
    );
  }

=======
>>>>>>> 672eaccd35dcd84f7a0492638adc779a3fd97735
  Future<void> startUpdateTasks([UpdateTasks? tasks]) async {
    if (timer != null && timer!.isActive == true) return;
    if (tasks != null) {
      this.tasks = tasks;
    }
    if (this.tasks.isEmpty) {
      return;
    }
    await executorUpdateTask();
    timer = Timer(const Duration(seconds: 1), () async {
      startUpdateTasks();
    });
  }

  Future<void> executorUpdateTask() async {
    for (final task in tasks) {
      await task();
    }
    timer = null;
  }

  void stopUpdateTasks() {
    if (timer == null || timer?.isActive == false) return;
    timer?.cancel();
    timer = null;
  }

  Future<void> handleStart([UpdateTasks? tasks]) async {
    startTime ??= DateTime.now();
    await coreController.startListener();
    await service?.start();
    startUpdateTasks(tasks);
  }

  Future updateStartTime() async {
    startTime = await service?.getRunTime();
  }

  Future<void> savePreferences() async {
    commonPrint.log('save preferences');
    await preferences.saveConfig(config);
  }

  Future handleStop() async {
    startTime = null;
    await coreController.stopListener();
    await service?.stop();
    stopUpdateTasks();
  }

  SetupState getSetupState(int? profileId) {
    final profile = profiles.getProfile(profileId);
    return appHandler.getSetupState(
      profileId: profileId,
      rules: rules,
      scripts: scripts,
      overrideDns: config.overrideDns,
      dns: config.patchClashConfig.dns,
      overwrite: profile?.overwrite,
      profileLastUpdateDate: profile?.lastUpdateDate,
    );
  }

  Future<bool?> showMessage({
    required InlineSpan message,
    BuildContext? context,
    String? title,
    String? confirmText,
    String? cancelText,
    bool cancelable = true,
    bool? dismissible,
  }) async {
    return await showCommonDialog<bool>(
      context: context,
      dismissible: dismissible,
      child: Builder(
        builder: (context) {
          return CommonDialog(
            title: title ?? appLocalizations.tip,
            actions: [
              if (cancelable)
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text(cancelText ?? appLocalizations.cancel),
                ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: Text(confirmText ?? appLocalizations.confirm),
              ),
            ],
            child: Container(
              width: 300,
              constraints: const BoxConstraints(maxHeight: 200),
              child: SingleChildScrollView(
                child: SelectableText.rich(
                  TextSpan(
                    style: Theme.of(context).textTheme.labelLarge,
                    children: [message],
                  ),
                  style: const TextStyle(overflow: TextOverflow.visible),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<bool?> showAllUpdatingMessagesDialog(
    List<UpdatingMessage> messages,
  ) async {
    return await showCommonDialog<bool>(
      child: Builder(
        builder: (context) {
          return CommonDialog(
            padding: EdgeInsets.zero,
            title: appLocalizations.tip,
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: Text(appLocalizations.confirm),
              ),
            ],
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 4),
              constraints: const BoxConstraints(maxHeight: 200),
              child: ListView.separated(
                itemBuilder: (_, index) {
                  final message = messages[index];
                  return ListItem(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    title: Text(message.label),
                    subtitle: Text(message.message),
                  );
                },
                itemCount: messages.length,
                separatorBuilder: (_, _) => Divider(height: 0),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<T?> showCommonDialog<T>({
    required Widget child,
    BuildContext? context,
    bool? dismissible,
    bool filter = true,
  }) async {
    return await showModal<T>(
      useRootNavigator: false,
      context: context ?? globalState.navigatorKey.currentContext!,
      configuration: FadeScaleTransitionConfiguration(
        barrierColor: Colors.black38,
        barrierDismissible: dismissible ?? true,
      ),
      builder: (_) => child,
      filter: filter ? commonFilter : null,
    );
  }

  void showNotifier(String text, {MessageActionState? actionState}) {
    if (text.isEmpty) {
      return;
    }
    navigatorKey.currentContext?.showNotifier(text, actionState: actionState);
  }

  Future<void> openUrl(String url) async {
    final res = await showMessage(
      message: TextSpan(text: url),
      title: appLocalizations.externalLink,
      confirmText: appLocalizations.go,
    );
    if (res != true) {
      return;
    }
    launchUrl(Uri.parse(url));
  }

<<<<<<< HEAD
  Future<Map> getProfileMap(int profileId) async {
    var res = {};
    try {
      final setupState = getSetupState(profileId);
      res = await makeRealProfile(
        setupState: setupState,
        patchConfig: config.patchClashConfig,
      );
    } catch (e) {
      globalState.showNotifier(e.toString());
    }
    return res;
  }

  String getSelectedProxyName(String groupName) {
    final group = appState.groups.getGroup(groupName);
    final proxyName = currentProfile?.selectedMap[groupName];
    return group?.getCurrentSelectedName(proxyName ?? '') ?? '';
  }

  Future<void> createProfile(
    SetupState setupState,
    ClashConfig patchConfig,
  ) async {
    final config = await makeRealProfile(
      setupState: setupState,
      patchConfig: patchConfig,
    );
    final configFilePath = await appPath.configFilePath;
    final res = await encodeYamlTask(config);
    final file = File(configFilePath);
    if (!await file.exists()) {
      await file.create(recursive: true);
    }
    await file.writeAsString(res);
  }

  Future<void> saveSharedFile() async {
    if (!system.isAndroid) {
      return;
    }
    final sharedFilePath = await appPath.sharedFilePath;
    final file = File(sharedFilePath);
    if (!await file.exists()) {
      await file.create(recursive: true);
    }
    await file.writeAsString(json.encode(sharedState));
  }

  Future<String> setupProfile({
    required SetupState setupState,
    required ClashConfig patchConfig,
    VoidCallback? preloadInvoke,
  }) async {
    saveSharedFile();
    await createProfile(setupState, patchConfig);
    return await coreController.setupConfig(
      setupState: setupState,
      preloadInvoke: preloadInvoke,
      params: setupParams,
    );
  }

  Future<String> backup() async {
    final configMap = config.toJson();
    configMap['version'] = await preferences.getVersion();
    final List<String> backupFileNames = [];
    final scriptIds = globalState.runningState.scripts.map(
      (item) => item.fileName,
    );
    final profileIds = globalState.runningState.profiles.map(
      (item) => item.fileName,
    );
    backupFileNames.addAll(scriptIds);
    backupFileNames.addAll(profileIds);
    return await backupTask(config.toJson(), backupFileNames);
  }

  Future<Map<String, dynamic>> makeRealProfile({
    required SetupState setupState,
    required ClashConfig patchConfig,
  }) async {
    final defaultUA = packageInfo.ua;
    final appendSystemDns = config.networkProps.appendSystemDns;
    final routeMode = config.networkProps.routeMode;
    final overrideDns = globalState.config.overrideDns;
    return appHandler.makeRealProfile(
      scripts: scripts,
      setupState: setupState,
      patchConfig: patchConfig,
      defaultUA: defaultUA,
      appendSystemDns: appendSystemDns,
      routeMode: routeMode,
      overrideDns: overrideDns,
    );
=======
  Future<Map<String, dynamic>> handleEvaluate(
    String scriptContent,
    Map<String, dynamic> config,
  ) async {
    if (config['proxy-providers'] == null) {
      config['proxy-providers'] = {};
    }
    final configJs = json.encode(config);
    final runtime = getJavascriptRuntime();
    final res = await runtime.evaluateAsync('''
      $scriptContent
      main($configJs)
    ''');
    if (res.isError) {
      throw res.stringResult;
    }
    final value = switch (res.rawResult is ffi.Pointer) {
      true => runtime.convertValue<Map<String, dynamic>>(res),
      false => Map<String, dynamic>.from(res.rawResult),
    };
    return value ?? config;
>>>>>>> 672eaccd35dcd84f7a0492638adc779a3fd97735
  }
}

final globalState = GlobalState();
