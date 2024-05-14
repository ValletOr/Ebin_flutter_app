import 'package:flutter/material.dart';
import 'package:enplus_market/models/AppModel.dart';

class UpdatesApp extends StatelessWidget {
  final AppModel app;
  UpdatesApp({required this.app});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        title: Row(
          children: [
            SizedBox(
              width: 42,
              height: 42,
              child: Image.network(
                app.icon!,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(app.name, style: TextStyle(fontSize: 12)),
                const Text(
                  'Детали',
                  style: TextStyle(fontSize: 10),
                )
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0), //TODO:Сделать вывод обновлений циклом, а не просто одного какого-то
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(
              color: Colors.black12,
              thickness: 1,
              height: 0,
            ),
            const Text(
              'Обновления',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 16),
             Text(
              app.lastUpdate.version,
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 8),
            Text(
              'Обновления ${app.lastUpdate.date}',
              style: TextStyle(fontSize: 14, color: Colors.black45),
            ),
            const SizedBox(height: 8),
            Text(
              app.lastUpdate.description!, //TODO:Сделать точечки (разделение по Enter'ам)
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            const Divider(
              color: Colors.black12,
              thickness: 1,
            ),


          ],
        ),
      ),
    );
  }
}
