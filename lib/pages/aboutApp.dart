import 'package:flutter/material.dart';
import 'package:enplus_market/models/AppModel.dart';

class aboutApp extends StatelessWidget {
  final AppModel app;

  aboutApp({required this.app});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  app.name,
                  style: TextStyle(fontSize: 12),
                ),
                Text(
                  'Детали',
                  style: TextStyle(fontSize: 10),
                )
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(
              color: Colors.black12,
              thickness: 1,
              height: 0,
            ),
            Text(
              'О приложении',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 16),
            Text(
              'Описание',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 8),
            Text(
              app.description!,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Divider(
              color: Colors.black12,
              thickness: 1,
            ),
            SizedBox(height: 10),
            Text(
              'Информация о приложении',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfoRow('Версия', app.lastUpdate.version),
                      _buildInfoRow('Последнее Обновление', app.lastUpdate.date.toString()),
                      _buildInfoRow('Размер', app.size!),
                      _buildInfoRow('Требование OS', app.minAndroid!),
                      _buildInfoRow('Выпущено', app.updates![0].date.toString()),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("Чего"),
                      // _buildInfoText(app.Version),
                      // _buildInfoText(app.ApkFile),
                      // _buildInfoText(app.Developer),
                      // _buildInfoText(app.MinAndroid),
                      // _buildInfoText(app.Version),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildInfoText(String text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(text),
        SizedBox(height: 20),
      ],
    );
  }
}
