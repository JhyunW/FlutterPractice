import 'dart:convert';
import 'dart:io';

import 'package:actual/common/component/custom_text_form_field.dart';
import 'package:actual/common/const/colors.dart';
import 'package:actual/common/const/data.dart';
import 'package:actual/common/layout/default_layout.dart';
import 'package:actual/common/view/root_tab.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String username = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    final dio = Dio();

    return DefaultLayout(
      child: SingleChildScrollView(
        // 키보드 드래그시 사라지는 UI적 기술
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: SafeArea(
          top: true,
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const _Title(),
                const SizedBox(height: 16.0),
                const _subTitle(),
                Image.asset('asset/img/misc/logo.png',
                    width: MediaQuery.of(context).size.width / 3 * 2),
                CustomTextFormField(
                  hintText: '이메일 입력',
                  onChanged: (String value) {
                    username = value;
                  },
                ),
                const SizedBox(height: 4.0),
                CustomTextFormField(
                  hintText: '비밀번호 입력',
                  onChanged: (String value) {
                    password = value;
                  },
                  obscureText: true,
                ),
                const SizedBox(height: 6.0),
                ElevatedButton(
                  onPressed: () async {
                    // ID : 비밀번호
                    final rawString = '$username:$password';

                    // Codec이라고 치면 dart.convert에서 지원하는 걸로 실행
                    // 스트링을 넣고 스트링으로 반환 받겠다
                    // 일단 주소를 Base64로 변환
                    // 변환을 어떤식으로 할지 선언해 준거라고 보면됨.
                    Codec<String, String> stringToBase64 = utf8.fuse(base64);

                    // 여기가 인코딩 전환하는 값
                    String token = stringToBase64.encode(rawString);

                    final resp = await dio.post(
                      'http://$ip/auth/login',
                      options: Options(
                        headers: {
                          'authorization': 'Basic $token',
                        },
                      ),
                    );

                    final refreshToken = resp.data['refreshToken'];
                    final accessToken = resp.data['accessToken'];

                    await storage.write(
                        key: REFRESH_TOKEN_KEY, value: refreshToken);
                    await storage.write(
                        key: ACCESS_TOKEN_KEY, value: accessToken);

                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const RootTab(),
                      ),
                    );
                    print(resp.data);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: PRIMARY_COLOR,
                  ),
                  child: const Text(
                    '로그인',
                  ),
                ),
                TextButton(
                  onPressed: () async {},
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                  ),
                  child: const Text(
                    '회원가입',
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      '환영합니다.',
      style: TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
    );
  }
}

class _subTitle extends StatelessWidget {
  const _subTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      // 줄바꿈은 \n
      '이메일과 비밀번호를 입력해서 로그인 해주세욤! \n프로젝트 힘드러욤!',
      style: TextStyle(
        fontSize: 16,
        color: BODY_TEXT_COLOR,
      ),
    );
  }
}
