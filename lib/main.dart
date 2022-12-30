import 'dart:io';

import 'package:tarantool_storage/tarantool_storage.dart';

Future<void> main(List<String> args) async {
  final storage = Storage()..boot(BootstrapScript(StorageDefaults.storage()), StorageDefaults.loop());
  print(await storage.executor().schema().spaceByName("_space").then((value) => value.length()));
  storage.shutdown();
  exit(0);
}
