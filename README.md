# Introduction

# Prerequisites
Install [Dart](https://dart.dev/get-dart)

```
dart pub get
```

### For Debian-based

```
apt -y install gcc
```

### For Fedora-based
```
yum -y install gcc
```

# Running

```
dart run tarantool_storage:setup
```

```
dart run tarantool_storage:compile 
```

```
dart run bin/main.dart
```

# Docker

You can run sample with Docker. 

`docker build -t sample .` - build image

`docker run sample` - run container

