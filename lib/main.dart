import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/services.dart';
import 'package:switch_platform/switch/presentation/switch_list_page.dart';

Future<void> main() async {
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.white,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const Scaffold(body: _Checker()),
      ),
    );
  }
}

class _Checker extends StatefulWidget {
  const _Checker();

  @override
  State<_Checker> createState() => _CheckerState();
}

class _CheckerState extends State<_Checker> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // ここで初期化処理やチェックを行います
      // 例: ログイン状態の確認、ネットワーク接続の確認、アプリのアップデート確認など
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const _Page(),
        // ここに必要な場合、ダイアログやローディングインディケータを表示します
      ],
    );
  }
}

class _Page extends StatefulWidget {
  const _Page();

  @override
  State<_Page> createState() => _PageState();
}

class _PageState extends State<_Page> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // ここで必要な初期化処理やリスナーの設定を行います
    });
  }

  @override
  Widget build(BuildContext context) {
    // ここで状態に基づいて表示するページを決定します
    // 今回は常にSwitchListPageを表示します
    return const SwitchListPage();
  }
}