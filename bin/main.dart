import 'dart:ffi';
import 'dart:io';

import 'package:tarantool_storage/storage/defaults.dart';
import 'package:tarantool_storage/storage/script.dart';
import 'package:tarantool_storage/storage/storage.dart';

Future<void> main(List<String> args) async {
  final storage = await Storage()
    ..boot(StorageBootstrapScript(StorageDefaults.storage()), StorageDefaults.loop());
  Pointer<NativeFunction<void Function()>> sampleFuction = storage.loadModuleByName("dart-tarantool-sample").library.lookup("sample");
  await storage.executor().executeNative(sampleFuction.cast());
  storage.shutdown();
  exit(0);
}
