import 'package:enplus_market/models/Update.dart';
import 'package:flutter/material.dart';
import 'package:enplus_market/models/AppModel.dart';
import 'package:intl/intl.dart';

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
            ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: app.updates!.length,
                itemBuilder: (context, index) {

                  return _buildUpdateItem(app.updates![index]);
                }),
          ],
        ),
      ),
    );
  }

  Widget _buildUpdateItem(Update update) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          update.version,
          style: TextStyle(fontSize: 20),
        ),
        const SizedBox(height: 8),
        Text(
          'Обновлён ${DateFormat('dd.MM.yyyy').format(update.date)}',
          style: TextStyle(fontSize: 14, color: Colors.black45),
        ),
        const SizedBox(height: 8),
        Text(
          update.description!, //TODO:Сделать точечки (разделение по Enter'ам)
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 10),
        const Divider(
          color: Colors.black12,
          thickness: 1,
        ),
      ],
    );
  }
}
