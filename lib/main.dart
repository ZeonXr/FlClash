import 'dart:async';
import 'dart:io';

<<<<<<< HEAD
=======
import 'package:fl_clash/pages/error.dart';
>>>>>>> 672eaccd35dcd84f7a0492638adc779a3fd97735
import 'package:fl_clash/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar_community/isar.dart';

import 'application.dart';
import 'common/common.dart';

Future<void> main() async {
<<<<<<< HEAD
  WidgetsFlutterBinding.ensureInitialized();
  await Isar.initializeIsarCore(download: true);
  final version = await system.version;
  await globalState.initApp(version);
  HttpOverrides.global = FlClashHttpOverrides();
  runApp(ProviderScope(child: const Application()));
=======
  try {
    WidgetsFlutterBinding.ensureInitialized();
    final version = await system.version;
    final container = await globalState.init(version);
    HttpOverrides.global = FlClashHttpOverrides();
    runApp(
      UncontrolledProviderScope(
        container: container,
        child: const Application(),
      ),
    );
  } catch (e, s) {
    return runApp(
      MaterialApp(
        home: InitErrorScreen(error: e, stack: s),
      ),
    );
  }
>>>>>>> 672eaccd35dcd84f7a0492638adc779a3fd97735
}
