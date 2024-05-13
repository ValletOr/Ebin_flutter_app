import 'package:flutter/material.dart';
import 'package:enplus_market/models/UpdatesModel.dart';
import 'package:enplus_market/models/CardModel.dart';

class UpdatesApp extends StatelessWidget {
  final UpdatesModel updates;
  final CardModel card;
  UpdatesApp({required this.updates, required this.card});

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
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(card.Name, style: TextStyle(fontSize: 12)),
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
              updates.version,
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 8),
            Text(
              'Обновления ${updates.date}',
              style: TextStyle(fontSize: 14, color: Colors.black45),
            ),
            const SizedBox(height: 8),
            Text(
              updates.description, //TODO:Сделать точечки (разделение по Enter'ам)
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
