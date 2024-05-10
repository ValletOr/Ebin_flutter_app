// import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:installed_apps/installed_apps.dart';
// import 'package:installed_apps/app_info.dart';

// import 'android_package_manager/android_package_manager.dart';
// import 'android_package_manager/enums.dart';
import 'login.dart';
import 'enmarket.dart';
import 'package:enplus_market/models/CardModel.dart';


void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  List<CardModel> cards = [
    CardModel(
      id: '1',
      Status: 'UnInstalled',
      Name: 'En+ Binding: App For Best Сybersportsmens',
      Description: 'Description for App 1',
      Developer: 'Developer 1',
      MinIos: 'iOS 10',
      MinAndroid: 'Android 8',
      IconFile: 'assets/img/log.png',
      ImagesFiles: ['image1_app_1.png', 'image2_app_1.png'],
      Version: '1.0',
      ApkFile: 'app1.apk',
      TestFlight: 'TestFlight link for App 1',
      Companies: 'Company 1',
    ),
    CardModel(
      id: '2',
      Status: 'Installed',
      Name: 'App 2',
      Description: 'Description for App 2',
      Developer: 'Developer 2',
      MinIos: 'iOS 11',
      MinAndroid: 'Android 9',
      IconFile: 'assets/img/1.jpg',
      ImagesFiles: ['image1_app_2.png', 'image2_app_2.png'],
      Version: '2.0',
      ApkFile: 'app2.apk',
      TestFlight: 'TestFlight link for App 2',
      Companies: 'Company 2',
    ),
    CardModel(
      id: '3',
      Status: 'Type 3',
      Name: 'Business Plan 3',
      Description: 'Description 3',
      Developer: 'Author 3',
      MinIos: 'pdf_link_3',
      MinAndroid: 'photo_link_3',
      IconFile: 'check_3',
      ImagesFiles: ['sad','sadsad'],
      Version: 'amount_3',
      ApkFile: 'link_3',
      TestFlight: 'Address 3',
      Companies: 'Number 3',
    ),
  ];

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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => EnMarket(cards: cards),
        '/login': (context) => PhoneAuthPage(),
      },
      theme: ThemeData(
          colorScheme: Theme.of(context).colorScheme.copyWith(
            primary: Color(0xFFFD9330),
          )
      ),
    );
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
  }

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
}

// onPressed: () {
// Navigator.of(context).pushNamed("/login");
// },