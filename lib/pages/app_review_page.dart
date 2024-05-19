import 'package:flutter/material.dart';
import 'package:enplus_market/models/AppModel.dart';

class reviewApp extends StatefulWidget {
  final AppModel app;

  reviewApp({required this.app});

  @override
  _reviewAppState createState() => _reviewAppState();
}

class _reviewAppState extends State<reviewApp> {
  int _rating = 0;
  String _comment = '';

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
                  image: widget.app.icon!,
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
                  widget.app.name,
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(24), // Image border
                  child: SizedBox.fromSize(
                    size: Size.fromRadius(24), // Image radius
                    child: FadeInImage.assetNetwork(
                      placeholder: "assets/img/placeholder.png",
                      //context.read<UserProvider>().userData!
                      image: "https://picsum.photos/200",//TODO Узнать какого хрена в апи не передаётся аватарка пользователя
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Александра Александровна',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Ваш отзыв будет опубликован для публичного просмотра всем пользователям',
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),


            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return IconButton(
                  icon: Icon(
                    size: 40,
                    index < _rating ? Icons.star : Icons.star_border,
                    color: Theme.of(context).primaryColor,
                  ),
                  onPressed: () {
                    setState(() {

                      _rating = index + 1;
                    });
                  },
                );
              }),
            ),

            SizedBox(height: 10),
            TextField(
              maxLines: 4,
              maxLength: 500,
              decoration: InputDecoration(
                hintText: 'Введите свой отзыв (максимум 500 символов)',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _comment = value;
                });
              },
            ),

            SizedBox(height: 10),
             ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 48), //TODO: hz mne kajetsa vse nepravil'no...
                  backgroundColor:  Colors.white,
                  side: BorderSide(
                    width: 1.0,
                    color: Theme.of(context).primaryColor,
                    style: BorderStyle.solid,
                  ),
                ),
                onPressed: () {
                  print('Rating: $_rating, Comment: $_comment'); //TODO:POST suda
                },
                child: Text(
                  'Отправить',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),

          ],
        ),
      ),
    );
  }
}