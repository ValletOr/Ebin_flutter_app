import 'package:enplus_market/components/common_appbar.dart';
import 'package:enplus_market/pages/otp_page.dart';
import 'package:enplus_market/pages/profile_page.dart';
import 'package:enplus_market/pages/redirect_page.dart';
import 'package:enplus_market/pages/settings_page.dart';
import 'package:enplus_market/providers/user_provider.dart';
import 'package:enplus_market/providers/installation_manager_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

// import 'package:installed_apps/installed_apps.dart';
// import 'package:installed_apps/app_info.dart';
// import 'android_package_manager/android_package_manager.dart';
// import 'android_package_manager/enums.dart';
import 'pages/login_page.dart';
import 'pages/enmarket_page.dart';
import 'package:enplus_market/models/AppModel.dart';
import 'package:enplus_market/pages/app_card_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var status = await Permission.storage.status;
  if (!status.isGranted){
    await Permission.storage.request();
  }
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  MyApp({super.key});

  // Router

  final GoRouter _router = GoRouter(
    initialLocation: "/",
    routes: <RouteBase>[
      GoRoute(
          path: "/",
        builder: (context, state){
            return Redirect();
        }
      ),
      GoRoute(
          path: "/login",
          name: "login",
          builder: (context, state) {
            return PhoneAuthPage();
          },
          routes: [
            GoRoute(
                path: "otp/:phoneNumber",
                name: "otp",
                builder: (context, state) {
                  final String phoneNumber =
                      state.pathParameters['phoneNumber']!;
                  return OTPPage(
                    phoneNumber: phoneNumber,
                  );
                }),
          ]),
      ShellRoute(
        builder: (BuildContext context, GoRouterState state, Widget child) {
          return Scaffold(
            //appBar: CommonAppBar(),
            body: child,
          );
        },
        routes: [
          GoRoute(
            path: "/main",
            name: "main",
            builder: (context, state) {
              return EnMarket();
            },
            routes: [
              GoRoute(
                  path: "appCard/:appId",
                  name: "appCard",
                  builder: (context, state) {
                    final int id = int.parse(state.pathParameters['appId']!);
                    return appCard(appId: id);
                  }),
              GoRoute(
                  path: "profile",
                  name: "profile",
                  builder: (context, state) {
                    return Profile();
                  }),
              GoRoute(
                  path: "settings",
                  name: "settings",
                  builder: (context, state) {
                    return SettingsPage();
                  }),
            ],
          ),
        ],
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider(
            create: (context) => InstallationManagerProvider(),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: _router,
        theme: ThemeData(
          colorScheme: Theme.of(context).colorScheme.copyWith(
                primary: Color(0xFFFD9330),
              ),
          fontFamily: 'SegoeUI',
        ),
      ),
    );
  }
}

// static const _baseUrl = 'https://b5f0-178-184-96-174.ngrok-free.app';
// static const _defaultUrl =
//     '$_baseUrl/api/apps/download?appName=winzip-6.9.0.apk';
// final TextEditingController _textEditingController = TextEditingController();
// double _progressValue = 0.0;
// String _labelText = '';
//
// @override
// void initState() {
//   super.initState();
//   _textEditingController.text = _defaultUrl;
// }
//
// @override
// void dispose() {
//   _textEditingController.dispose();
//   super.dispose();
// }

//   return MaterialApp(
//     home: Scaffold(
//       appBar: AppBar(
//         title: const Text('Plugin example app'),
//       ),
//       body: Container(
//         alignment: Alignment.center,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Padding(
//               padding:
//               const EdgeInsets.only(top: 30, left: 16.0, right: 16),
//               child: LinearProgressIndicator(
//                 value: _progressValue,
//                 backgroundColor: Colors.grey,
//                 valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(
//                   top: 16, left: 16.0, right: 16, bottom: 16),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   Text(_labelText)
//                 ],
//               ),
//             ),
//             ElevatedButton(
//                 onPressed: () => _networkInstallApk(),
//                 child: const Text('Установить')),
//             ElevatedButton(
//                 onPressed: () => _networkUpdateApk(),
//                 child: const Text('Обновить')),
//             ElevatedButton(
//                 onPressed: () => _openApk(),
//                 child: const Text('Открыть')),
//             ElevatedButton(
//                 onPressed: () => _removeApk(),
//                 child: const Text('Удалить')),
//           ],
//         ),
//       ),
//     ),
//   );

// _openApk() async {
//   List<AppInfo> apps = await InstalledApps.getInstalledApps(true, true);
//   for (var app in apps) {
//     if (app.name!.toLowerCase().contains("winzip")) {
//       InstalledApps.startApp(app.packageName!);
//     }
//   }
// }
// _networkUpdateApk() async {
//   _progressValue = 0.0;
//
//   var appDocDir = await  getTemporaryDirectory();
//   String savePath = "${appDocDir.path}/winzip.apk";
//
//   String versionUrl = "$_baseUrl/api/apps/version";
//   var responseVersion = await Dio().get(versionUrl);
//
//   String version = responseVersion.data["message"];
//   String installedVersion = "";
//
//   List<AppInfo> apps = await InstalledApps.getInstalledApps(true, true);
//   for (var app in apps) {
//     if (app.name!.toLowerCase().contains("winzip")) {
//       installedVersion = app.versionName!;
//     }
//   }
//
//   if (version != installedVersion) {
//     String fileUrl = "$_baseUrl/api/apps/download?appName=winzip-$version.apk";
//     await Dio().download(fileUrl, savePath, onReceiveProgress: (count, total) {
//       final value = count / total;
//       if (_progressValue != value) {
//         setState(() {
//           if (_progressValue < 1.0) {
//             _progressValue = value;
//             _labelText = 'Скачивание ${(value * 100).toStringAsFixed(0)} %';
//           }
//           else {
//             _progressValue = 0.0;
//             _labelText = '';
//           }
//         });
//       }
//     });
//
//     setState(() {
//       _labelText = 'Обновление...';
//     });
//
//     PackageManagerStatus status = await AndroidPackageManager
//         .execute(PackageManagerActionType.install, savePath);
//     setState(() {
//       _labelText = status.code == 0?
//         'Обновление завершено' : 'Ошибка обновления';
//     });
//   }
// }
//
// _networkInstallApk() async {
//   _progressValue = 0.0;
//
//   var appDocDir = await getTemporaryDirectory();
//   String savePath = "${appDocDir.path}/winzip.apk";
//   String fileUrl = "$_baseUrl/api/apps/download?appName=winzip-6.9.0.apk";
//
//   await Dio().download(fileUrl, savePath, onReceiveProgress: (count, total) {
//     final value = count / total;
//     if (_progressValue != value) {
//       setState(() {
//         if (_progressValue < 1.0) {
//           _progressValue = value;
//           _labelText = 'Скачивание ${(value * 100).toStringAsFixed(0)} %';
//         }
//         else {
//           _progressValue = 0.0;
//           _labelText = '';
//         }
//       });
//     }
//   });
//
//   setState(() {
//     _labelText = 'Установка...';
//   });
//
//   PackageManagerStatus status = await AndroidPackageManager
//       .execute(PackageManagerActionType.install, savePath);
//   setState(() {
//     _labelText = status.code == 0?
//     'Установка завершена' : 'Ошибка установки';
//   });
// }
//
// _removeApk() async {
//   List<AppInfo> apps = await InstalledApps.getInstalledApps(true, true);
//   for (var app in apps) {
//     if (app.name!.toLowerCase().contains("winzip")) {
//       setState(() {
//         _labelText = 'Удаление...';
//       });
//
//       PackageManagerStatus status = await AndroidPackageManager
//           .execute(PackageManagerActionType.uninstall, app.packageName!);
//       setState(() {
//         _labelText = status.code == 0?
//         'Удаление завершено' : 'Ошибка удаления';
//       });
//     }
//   }
// }

// onPressed: () {
// Navigator.of(context).pushNamed("/login");
// },
