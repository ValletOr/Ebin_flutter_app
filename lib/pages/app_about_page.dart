import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:enplus_market/models/AppModel.dart';
import 'package:intl/intl.dart';

class aboutApp extends StatelessWidget {
  final AppModel app;

  aboutApp({required this.app});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        title: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12), // Image border
              child: SizedBox.fromSize(
                size: Size.fromRadius(21), // Image radius
                child: FadeInImage.assetNetwork(
                  placeholder: "assets/img/placeholder.png",
                  image: app.icon!,
                  fit: BoxFit.fill,
                ),
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoRow('Версия', app.lastUpdate.version),
                _buildInfoRow('Последнее Обновление', DateFormat('dd.MM.yyyy').format(app.lastUpdate.date)),
                _buildInfoRow('Размер', app.size!),
                _buildInfoRow('Требование OS', "${app.minAndroid!} и выше"),
                _buildInfoRow('Выпущено', DateFormat('dd.MM.yyyy').format(app.updates![0].date)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label),
        Text(value),
        // SizedBox(height: 20),
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
