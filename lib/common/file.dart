import 'dart:io';

extension FileExt on File {
  Future<void> safeCopy(String newPath) async {
    if (!await exists()) {
      await create(recursive: true);
      return;
    }
<<<<<<< HEAD
    await copy(newPath);
  }
=======
    final targetFile = File(newPath);
    if (!await targetFile.exists()) {
      await targetFile.create(recursive: true);
    }
    await copy(newPath);
  }

  Future<File> safeWriteAsString(String str) async {
    if (!await exists()) {
      await create(recursive: true);
    }
    return await writeAsString(str);
  }

  Future<File> safeWriteAsBytes(List<int> bytes) async {
    if (!await exists()) {
      await create(recursive: true);
    }
    return await writeAsBytes(bytes);
  }
>>>>>>> 672eaccd35dcd84f7a0492638adc779a3fd97735
}

extension FileSystemEntityExt on FileSystemEntity {
  Future<void> safeDelete({bool recursive = false}) async {
    if (!await exists()) {
      return;
    }
    await delete(recursive: recursive);
  }
}
