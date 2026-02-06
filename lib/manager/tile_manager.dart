import 'package:fl_clash/common/app_localizations.dart';
<<<<<<< HEAD
import 'package:fl_clash/core/controller.dart';
import 'package:fl_clash/models/app.dart';
=======
import 'package:fl_clash/controller.dart';
import 'package:fl_clash/core/controller.dart';
>>>>>>> 672eaccd35dcd84f7a0492638adc779a3fd97735
import 'package:fl_clash/plugins/app.dart';
import 'package:fl_clash/plugins/tile.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TileManager extends ConsumerStatefulWidget {
  final Widget child;

  const TileManager({super.key, required this.child});

  @override
  ConsumerState<TileManager> createState() => _TileContainerState();
}

class _TileContainerState extends ConsumerState<TileManager> with TileListener {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  bool get isStart => ref.read(isStartProvider);

  @override
  Future<void> onStart() async {
<<<<<<< HEAD
    if (globalState.appState.isStart && coreController.isCompleted) {
      return;
    }
    globalState.appController.updateStatus(true);
=======
    if (isStart && coreController.isCompleted) {
      return;
    }
    appController.updateStatus(true);
>>>>>>> 672eaccd35dcd84f7a0492638adc779a3fd97735
    app?.tip(appLocalizations.startVpn);
    super.onStart();
  }

  @override
  Future<void> onStop() async {
    if (!isStart) {
      return;
    }
<<<<<<< HEAD
    globalState.appController.updateStatus(false);
=======
    appController.updateStatus(false);
>>>>>>> 672eaccd35dcd84f7a0492638adc779a3fd97735
    app?.tip(appLocalizations.stopVpn);
    super.onStop();
  }

  @override
  void initState() {
    super.initState();
    tile?.addListener(this);
  }

  @override
  void dispose() {
    tile?.removeListener(this);
    super.dispose();
  }
}
