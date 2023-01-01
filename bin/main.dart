import 'dart:io';

import 'package:tarantool_storage/storage/defaults.dart';
import 'package:tarantool_storage/storage/script.dart';
import 'package:tarantool_storage/storage/storage.dart';
import 'package:tarantool_storage_sample/user.dart';

Future<void> main(List<String> args) async {
  final storage = await Storage();
  storage.boot(StorageBootstrapScript(StorageDefaults.storage())..includeStorageLuaModule(), StorageDefaults.loop());
  final user = UserSpace(storage.executor().schema());
  await user.create();
  await user.add(User(id: 1, firstname: "anton", surname: "bashirov"));
  await user.add(User(id: 2, firstname: "anton 2", surname: "bashirov 2"));
  print(await user.get(1));
  print(await user.select());
  await user.delete(2);
  print(await user.select());
  await user.add(User(id: 1, firstname: "anton", surname: "bashirov"));
  await user.add(User(id: 2, firstname: "anton 2", surname: "bashirov 2"));
  await user.add(User(id: 3, firstname: "anton 3", surname: "bashirov 3"));
  await user.stream().forEach(print);
  await storage.executor().executeLua("sample");
  await storage.executor().executeNative(storage.loadModuleByName("dart-tarantool-sample").library.lookup("sample"));
  storage.shutdown();
  exit(0);
}
