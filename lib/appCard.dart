import 'package:flutter/material.dart';
import 'package:enplus_market/models/CardModel.dart';

class appCard extends StatelessWidget {
  final CardModel card;

  appCard({required this.card});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(card.Name),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (card.MinAndroid != null && card.MinAndroid.isNotEmpty)
              Image.network(
                card.MinAndroid,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            SizedBox(height: 16.0),
            Text(
              'Описание: ${card.Description}',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Автор: ${card.Developer}',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            if (card.MinIos != null && card.MinIos.isNotEmpty)
              ElevatedButton(
                onPressed: () {
                  // _viewPDF(context, card.pdf);
                },
                child: Text('Открыть PDF'),
              ),
            SizedBox(height: 16.0),
            if (card.MinIos != null && card.MinIos.isNotEmpty)
              ElevatedButton(
                onPressed: () {
                  // _launchURL(card.pdf);
                },
                child: Text('Перейти по ссылке'),
              ),
          ],
        ),
      ),
    );
  }
}