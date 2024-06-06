import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const ACCESS_TOKEN_KEY = 'ACCESS_TOKEN';
const REFRESH_TOKEN_KEY = 'REFRESH_TOKEN';

// localhost
const emulateorIp = '10.0.2.2:3000';
const simulatorIp = '127.0.0.1:3000';

// ios인지 android인지에 따라 다르게 실행
final ip = Platform.isAndroid == true ? emulateorIp : simulatorIp;

// 로그인 저장소
const storage = FlutterSecureStorage();
