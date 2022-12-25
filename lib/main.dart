import 'dart:io';

import 'package:tarantool_storage/tarantool_storage.dart';

Future<void> main(List<String> args) async {
  final storage = Storage()..boot(BootstrapScript(defaultStorageConfiguration()), defaultMessageLoopConfiguration());
  print(await storage.executor().space(280).length());
  storage.shutdown();
  exit(0);
}
