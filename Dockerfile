FROM dart:latest
RUN apt update && apt install -y gcc
COPY . /module
WORKDIR /module
RUN dart pub get
RUN dart run tarantool_storage:setup && dart run tarantool_storage:pack bin/main.dart && tar xf module.tar.gz && rm module.tar.gz
RUN chmod +x main.exe
ENTRYPOINT /module/main.exe