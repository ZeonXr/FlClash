import 'dart:async';

<<<<<<< HEAD
import 'package:collection/collection.dart';
=======
import 'package:dio/dio.dart';
>>>>>>> 672eaccd35dcd84f7a0492638adc779a3fd97735
import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:flutter/services.dart';
import 'package:isar_community/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'generated/app.g.dart';

@riverpod
class RealTunEnable extends _$RealTunEnable with AutoDisposeNotifierMixin {
  @override
  bool build() {
    return false;
  }
}

@Riverpod(keepAlive: true)
class Logs extends _$Logs with AutoDisposeNotifierMixin {
  @override
  FixedList<Log> build() {
    return FixedList(0);
  }

  void addLog(Log value) {
    this.value = state.copyWith()..add(value);
  }
}

@Riverpod(keepAlive: true)
class Requests extends _$Requests with AutoDisposeNotifierMixin {
  @override
  FixedList<TrackerInfo> build() {
    return FixedList(0);
  }

  void addRequest(TrackerInfo value) {
    this.value = state.copyWith()..add(value);
  }
}

@Riverpod(keepAlive: true)
class Providers extends _$Providers with AutoDisposeNotifierMixin {
  @override
  List<ExternalProvider> build() {
    return [];
  }

  void setProvider(ExternalProvider? provider) {
    if (provider == null) return;
    final index = value.indexWhere((item) => item.name == provider.name);
    if (index == -1) return;
    final newState = List<ExternalProvider>.from(value)..[index] = provider;
    value = newState;
  }
}

@Riverpod(keepAlive: true)
class Packages extends _$Packages with AutoDisposeNotifierMixin {
  @override
  List<Package> build() {
    return [];
  }
}

@Riverpod(keepAlive: true)
class SystemBrightness extends _$SystemBrightness
    with AutoDisposeNotifierMixin {
  @override
  Brightness build() {
    return Brightness.dark;
  }
}

@Riverpod(keepAlive: true)
class Traffics extends _$Traffics with AutoDisposeNotifierMixin {
  @override
  FixedList<Traffic> build() {
    return FixedList(0);
  }

  void addTraffic(Traffic value) {
    this.value = state.copyWith()..add(value);
  }

  void clear() {
    value = state.copyWith()..clear();
  }
}

@Riverpod(keepAlive: true)
class TotalTraffic extends _$TotalTraffic with AutoDisposeNotifierMixin {
  @override
  Traffic build() {
    return Traffic();
  }
}

@Riverpod(keepAlive: true)
class LocalIp extends _$LocalIp with AutoDisposeNotifierMixin {
  @override
  String? build() {
    return null;
  }
}

@Riverpod(keepAlive: true)
class RunTime extends _$RunTime with AutoDisposeNotifierMixin {
  @override
  int? build() {
    return null;
  }
}

@Riverpod(keepAlive: true)
class ViewSize extends _$ViewSize with AutoDisposeNotifierMixin {
  @override
  Size build() {
    return Size.zero;
  }
}

@Riverpod(keepAlive: true)
class SideWidth extends _$SideWidth with AutoDisposeNotifierMixin {
  @override
  double build() {
    return 0;
  }
}

@Riverpod(keepAlive: true)
double viewWidth(Ref ref) {
  return ref.watch(viewSizeProvider).width;
}

@Riverpod(keepAlive: true)
ViewMode viewMode(Ref ref) {
  return utils.getViewMode(ref.watch(viewWidthProvider));
}

@Riverpod(keepAlive: true)
bool isMobileView(Ref ref) {
  return ref.watch(viewModeProvider) == ViewMode.mobile;
}

@Riverpod(keepAlive: true)
double viewHeight(Ref ref) {
  return ref.watch(viewSizeProvider).height;
}

@Riverpod(keepAlive: true)
class Init extends _$Init with AutoDisposeNotifierMixin {
  @override
  bool build() {
    return false;
  }
}

@Riverpod(keepAlive: true)
class CurrentPageLabel extends _$CurrentPageLabel
    with AutoDisposeNotifierMixin {
  @override
  PageLabel build() {
    return PageLabel.dashboard;
  }
}

@Riverpod(keepAlive: true)
class SortNum extends _$SortNum with AutoDisposeNotifierMixin {
  @override
  int build() {
    return 0;
  }

  int add() => state++;
}

@Riverpod(keepAlive: true)
class CheckIpNum extends _$CheckIpNum with AutoDisposeNotifierMixin {
  @override
  int build() {
    return 0;
  }

  int add() => state++;
}

@Riverpod(keepAlive: true)
class BackBlock extends _$BackBlock with AutoDisposeNotifierMixin {
  @override
  bool build() {
    return false;
  }
}

@Riverpod(keepAlive: true)
class Version extends _$Version with AutoDisposeNotifierMixin {
  @override
  int build() {
    return 0;
  }
}

@Riverpod(keepAlive: true)
class Groups extends _$Groups with AutoDisposeNotifierMixin {
  @override
  List<Group> build() {
    return [];
  }
}

@Riverpod(keepAlive: true)
class DelayDataSource extends _$DelayDataSource with AutoDisposeNotifierMixin {
  @override
  DelayMap build() {
    return {};
  }

  void setDelay(Delay delay) {
    if (state[delay.url]?[delay.name] != delay.value) {
      final DelayMap newDelayMap = Map.from(state);
      if (newDelayMap[delay.url] == null) {
        newDelayMap[delay.url] = {};
      }
      newDelayMap[delay.url]![delay.name] = delay.value;
      value = newDelayMap;
    }
  }
}

@Riverpod(keepAlive: true)
class SystemUiOverlayStyleState extends _$SystemUiOverlayStyleState
    with AutoDisposeNotifierMixin {
  @override
  SystemUiOverlayStyle build() {
    return SystemUiOverlayStyle();
  }
}

@Riverpod(name: 'coreStatusProvider', keepAlive: true)
class _CoreStatus extends _$CoreStatus with AutoDisposeNotifierMixin {
  @override
  CoreStatus build() {
    return CoreStatus.disconnected;
  }
}

@riverpod
class Query extends _$Query with AutoDisposeNotifierMixin {
  @override
  String build(QueryTag tag) {
    return '';
  }
}

@Riverpod(keepAlive: true)
class Loading extends _$Loading with AutoDisposeNotifierMixin {
  DateTime? _start;
  Timer? _timer;

  @override
  bool build(LoadingTag tag) {
    return false;
  }

  void start() {
    _timer?.cancel();
    _timer = null;
    _start = DateTime.now();
    value = true;
  }

  Future<void> stop() async {
    if (_start == null) {
      value = false;
      return;
    }
    final startedAt = _start!;
    final elapsed = DateTime.now().difference(_start!).inMilliseconds;
    const minDuration = 1000;
    if (elapsed >= minDuration) {
      value = false;
      return;
    }
    _timer = Timer(Duration(milliseconds: minDuration - elapsed), () {
      if (_start != startedAt) {
        return;
      }
      value = false;
    });
  }
<<<<<<< HEAD

  @override
  onUpdate(value) {
    globalState.appState = globalState.appState.copyWith(loading: value);
  }
}

@riverpod
class Version extends _$Version with AutoDisposeNotifierMixin {
  @override
  int build() {
    return globalState.appState.version;
  }

  @override
  onUpdate(value) {
    globalState.appState = globalState.appState.copyWith(version: value);
  }
}

@riverpod
class Groups extends _$Groups with AutoDisposeNotifierMixin {
  @override
  List<Group> build() {
    return globalState.appState.groups;
  }

  @override
  onUpdate(value) {
    globalState.appState = globalState.appState.copyWith(groups: value);
  }
}

@riverpod
class DelayDataSource extends _$DelayDataSource with AutoDisposeNotifierMixin {
  @override
  DelayMap build() {
    return globalState.appState.delayMap;
  }

  @override
  onUpdate(value) {
    globalState.appState = globalState.appState.copyWith(delayMap: value);
  }

  void setDelay(Delay delay) {
    if (state[delay.url]?[delay.name] != delay.value) {
      final DelayMap newDelayMap = Map.from(state);
      if (newDelayMap[delay.url] == null) {
        newDelayMap[delay.url] = {};
      }
      newDelayMap[delay.url]![delay.name] = delay.value;
      value = newDelayMap;
    }
  }
}

@riverpod
class SystemUiOverlayStyleState extends _$SystemUiOverlayStyleState
    with AutoDisposeNotifierMixin {
  @override
  SystemUiOverlayStyle build() {
    return globalState.appState.systemUiOverlayStyle;
  }

  @override
  onUpdate(value) {
    globalState.appState = globalState.appState.copyWith(
      systemUiOverlayStyle: value,
    );
  }
}

@Riverpod(name: 'coreStatusProvider')
class _CoreStatus extends _$CoreStatus with AutoDisposeNotifierMixin {
  @override
  CoreStatus build() {
    return globalState.appState.coreStatus;
  }

  @override
  onUpdate(value) {
    globalState.appState = globalState.appState.copyWith(coreStatus: value);
  }
}

@riverpod
class Query extends _$Query with AutoDisposeNotifierMixin {
  late final QueryTag _tag;

  @override
  String build(QueryTag tag) {
    _tag = tag;
    return globalState.appState.queryMap[tag] ?? '';
  }

  @override
  onUpdate(value) {
    final newMap = Map<QueryTag, String>.from(globalState.appState.queryMap)
      ..[_tag] = value;
    globalState.appState = globalState.appState.copyWith(queryMap: newMap);
  }
=======
>>>>>>> 672eaccd35dcd84f7a0492638adc779a3fd97735
}

@riverpod
class SelectedItems extends _$SelectedItems with AutoDisposeNotifierMixin {
  @override
  Set<dynamic> build(String key) {
<<<<<<< HEAD
    _key = key;
    return globalState.appState.selectedItemsMap[_key] ?? {};
  }

  @override
  onUpdate(value) {
    final newMap = globalState.appState.selectedItemsMap.copyWitUpdate(
      key,
      value,
    );
    globalState.appState = globalState.appState.copyWith(
      selectedItemsMap: newMap,
    );
=======
    return {};
>>>>>>> 672eaccd35dcd84f7a0492638adc779a3fd97735
  }
}

@riverpod
class SelectedItem extends _$SelectedItem with AutoDisposeNotifierMixin {
  @override
  dynamic build(String key) {
<<<<<<< HEAD
    _key = key;
    return globalState.appState.selectedItemMap[_key];
  }

  @override
  onUpdate(value) {
    final newMap = globalState.appState.selectedItemMap.copyWitUpdate(
      key,
      value,
    );
    globalState.appState = globalState.appState.copyWith(
      selectedItemMap: newMap,
    );
=======
    return null;
>>>>>>> 672eaccd35dcd84f7a0492638adc779a3fd97735
  }
}

@riverpod
<<<<<<< HEAD
class Profiles extends _$Profiles with AutoDisposeNotifierMixin {
  @override
  List<Profile> build() {
    return globalState.runningState.profiles;
  }

  @override
  onUpdate(value) {
    globalState.runningState = globalState.runningState.copyWith(
      profiles: value,
    );
    globalState.isar.writeTxn(() async {
      final newProfileCollections = value.mapIndexed((index, item) {
        return ProfileCollection.fromProfile(item, index);
      }).toList();
      await globalState.isar.profileCollections.setAll(
        newProfileCollections,
        getId: (item) => item.id,
        getIdsInDb: (col) => col.where().idProperty().findAll(),
      );
    });
  }

  void setProfile(Profile profile) {
    value = state.copyAndAddProfile(profile);
  }

  void updateProfile(int profileId, Profile Function(Profile profile) builder) {
    final List<Profile> profilesTemp = List.from(state);
    final index = profilesTemp.indexWhere((element) => element.id == profileId);
    if (index != -1) {
      profilesTemp[index] = builder(profilesTemp[index]);
    }
    value = profilesTemp;
  }

  void deleteProfileById(int id) {
    value = state.where((element) => element.id != id).toList();
  }
}

@riverpod
class Scripts extends _$Scripts with AutoDisposeNotifierMixin {
  @override
  List<Script> build() {
    return globalState.runningState.scripts;
  }

  @override
  onUpdate(value) {
    globalState.runningState = globalState.runningState.copyWith(
      scripts: value,
    );
    globalState.isar.writeTxn(() async {
      final newScriptCollections = value
          .map(ScriptCollection.fromScript)
          .toList();
      await globalState.isar.scriptCollections.setAll(
        newScriptCollections,
        getId: (item) => item.id,
        getIdsInDb: (col) => col.where().idProperty().findAll(),
      );
    });
  }

  void setScript(Script script) {
    final list = List<Script>.from(state);
    final index = list.indexWhere((item) => item.id == script.id);
    if (index != -1) {
      list[index] = script;
    } else {
      list.add(script);
    }
    value = list;
  }

  void del(int id) {
    final list = List<Script>.from(state);
    final index = list.indexWhere((item) => item.id == id);
    if (index != -1) {
      list.removeAt(index);
    }
    state = list;
  }

  bool isExits(String label) {
    return state.indexWhere((item) => item.label == label) != -1;
  }
}

@riverpod
class Rules extends _$Rules with AutoDisposeNotifierMixin {
  @override
  List<Rule> build() {
    return globalState.runningState.rules;
  }

  @override
  onUpdate(value) {
    globalState.runningState = globalState.runningState.copyWith(rules: value);
    globalState.isar.writeTxn(() async {
      final newRuleCollections = value.mapIndexed((index, item) {
        return RuleCollection.fromRule(item, index);
      }).toList();
      await globalState.isar.ruleCollections.setAll(
        newRuleCollections,
        getId: (item) => item.id,
        getIdsInDb: (col) => col.where().idProperty().findAll(),
      );
    });
  }
}

@riverpod
class IsUpdating extends _$IsUpdating with AutoDisposeNotifierMixin {
  late final String _name;

  @override
  bool build(String name) {
    _name = name;
    return globalState.appState.updatingMap[_name] ?? false;
  }

  @override
  onUpdate(value) {
    final newMap = globalState.appState.updatingMap.copyWitUpdate(_name, value);
    globalState.appState = globalState.appState.copyWith(updatingMap: newMap);
  }
}
=======
class IsUpdating extends _$IsUpdating with AutoDisposeNotifierMixin {
  @override
  bool build(String name) {
    return false;
  }
}

@Riverpod(keepAlive: true)
class NetworkDetection extends _$NetworkDetection
    with AutoDisposeNotifierMixin {
  bool? _preIsStart;
  CancelToken? _cancelToken;
  int _startMillisecondsEpoch = 0;

  @override
  NetworkDetectionState build() {
    return NetworkDetectionState(isLoading: true, ipInfo: null);
  }

  void startCheck() {
    debouncer.call(FunctionTag.checkIp, () {
      _checkIp();
    }, duration: commonDuration);
  }

  Future<void> _checkIp() async {
    final isInit = ref.read(initProvider);
    if (!isInit) {
      return;
    }
    final isStart = ref.read(isStartProvider);
    if (!isStart && _preIsStart == false && state.ipInfo != null) {
      return;
    }
    final millisecondsEpoch = DateTime.now().millisecondsSinceEpoch;
    _startMillisecondsEpoch = millisecondsEpoch;
    final runTime = millisecondsEpoch + 1;
    _cancelToken?.cancel();
    _cancelToken = CancelToken();
    commonPrint.log('checkIp start');
    state = state.copyWith(isLoading: true, ipInfo: null);
    _preIsStart = isStart;
    final res = await request.checkIp(cancelToken: _cancelToken);
    commonPrint.log('checkIp res: $res');
    if (res.isError && runTime > _startMillisecondsEpoch) {
      state = state.copyWith(isLoading: true, ipInfo: null);
      return;
    }
    final ipInfo = res.data;
    if (ipInfo == null) {
      return;
    }
    state = state.copyWith(isLoading: false, ipInfo: ipInfo);
  }
}

List<Override> buildAppStateOverrides(AppState appState) {
  return [
    initProvider.overrideWithBuild((_, _) => appState.isInit),
    backBlockProvider.overrideWithBuild((_, _) => appState.backBlock),
    currentPageLabelProvider.overrideWithBuild((_, _) => appState.pageLabel),
    packagesProvider.overrideWithBuild((_, _) => appState.packages),
    sortNumProvider.overrideWithBuild((_, _) => appState.sortNum),
    viewSizeProvider.overrideWithBuild((_, _) => appState.viewSize),
    sideWidthProvider.overrideWithBuild((_, _) => appState.sideWidth),
    delayDataSourceProvider.overrideWithBuild((_, _) => appState.delayMap),
    groupsProvider.overrideWithBuild((_, _) => appState.groups),
    checkIpNumProvider.overrideWithBuild((_, _) => appState.checkIpNum),
    systemBrightnessProvider.overrideWithBuild((_, _) => appState.brightness),
    runTimeProvider.overrideWithBuild((_, _) => appState.runTime),
    providersProvider.overrideWithBuild((_, _) => appState.providers),
    localIpProvider.overrideWithBuild((_, _) => appState.localIp),
    requestsProvider.overrideWithBuild((_, _) => appState.requests),
    versionProvider.overrideWithBuild((_, _) => appState.version),
    logsProvider.overrideWithBuild((_, _) => appState.logs),
    trafficsProvider.overrideWithBuild((_, _) => appState.traffics),
    totalTrafficProvider.overrideWithBuild((_, _) => appState.totalTraffic),
    realTunEnableProvider.overrideWithBuild((_, _) => appState.realTunEnable),
    systemUiOverlayStyleStateProvider.overrideWithBuild(
      (_, _) => appState.systemUiOverlayStyle,
    ),
    coreStatusProvider.overrideWithBuild((_, _) => appState.coreStatus),
  ];
}
>>>>>>> 672eaccd35dcd84f7a0492638adc779a3fd97735
