import 'package:flutter/material.dart';
import 'package:enplus_market/models/CardModel.dart';

class aboutApp extends StatelessWidget {
  final CardModel card;

  aboutApp({required this.card});

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
              child: Image.asset(
                card.IconFile,
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
                  card.Name,
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
              card.Description,
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
                      _buildInfoRow('Версия', card.Version),
                      _buildInfoRow('Последнее Обновление', card.ApkFile),
                      _buildInfoRow('Размер', card.Version),
                      _buildInfoRow('Требование OS', card.MinAndroid),
                      _buildInfoRow('Выпущено', card.Version),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _buildInfoText(card.Version),
                      _buildInfoText(card.ApkFile),
                      _buildInfoText(card.Developer),
                      _buildInfoText(card.MinAndroid),
                      _buildInfoText(card.Version),
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
