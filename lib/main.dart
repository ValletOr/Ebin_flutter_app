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
      type: 'Type 1',
      name: 'Business Plan 1',
      description: 'Description 1',
      author: 'Author 1',
      pdf: 'pdf_link_1',
      photo: 'photo_link_1',
      check: 'check_1',
      time: 'time_1',
      amount: 'amount_1',
      link: 'link_1',
      address: 'Address 1',
      number: 'Number 1',
    ),
    CardModel(
      id: '2',
      type: 'Type 2',
      name: 'Business Plan 2',
      description: 'Description 2',
      author: 'Author 2',
      pdf: 'pdf_link_2',
      photo: 'photo_link_2',
      check: 'check_2',
      time: 'time_2',
      amount: 'amount_2',
      link: 'link_2',
      address: 'Address 2',
      number: 'Number 2',
    ),
    CardModel(
      id: '3',
      type: 'Type 3',
      name: 'Business Plan 3',
      description: 'Description 3',
      author: 'Author 3',
      pdf: 'pdf_link_3',
      photo: 'photo_link_3',
      check: 'check_3',
      time: 'time_3',
      amount: 'amount_3',
      link: 'link_3',
      address: 'Address 3',
      number: 'Number 3',
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