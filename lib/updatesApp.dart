import 'package:flutter/material.dart';
import 'package:enplus_market/models/CardModel.dart';

class updatesApp extends StatelessWidget {
  final CardModel card;

  updatesApp({required this.card});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(children: [
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
        ]),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
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
            const Text(
              'Описание',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 8),
            Text(
              card.Description,
              style: TextStyle(fontSize: 16),
            ),
            const  SizedBox(height: 10),
            const Divider(
              color: Colors.black12,
              thickness: 1,
            ),

            const SizedBox(
              height: 10,
            ),
            const Text(
              'Информация о приложении',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 20),

            Row(
              children: [
               const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Версия'),
                      SizedBox(
                        height: 20,
                      ),
                      Text('Последнее Обновление'),
                      SizedBox(
                        height: 20,
                      ),
                      Text('Размер'),
                      SizedBox(
                        height: 20,
                      ),
                      Text('Требование OS'),
                      SizedBox(
                        height: 20,
                      ),
                      Text('Выпущено')
                    ],
                  ),
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(card.Version),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(card.ApkFile),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(card.Developer),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(card.MinAndroid),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(card.Version)
                  ],
                ))
              ],
            )
            //
            // _buildInfoRow('Версия', card.Version),
            // _buildInfoRow('Последнее Обновление', card.ApkFile),
            // _buildInfoRow('Размер', card.Version),
            // _buildInfoRow('Требование OS', card.MinAndroid),
            // _buildInfoRow('Выпущено', card.Version),
          ],
        ),
      ),
    );
  }
}
