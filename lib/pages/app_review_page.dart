import 'package:enplus_market/providers/user_provider.dart';
import 'package:enplus_market/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:enplus_market/models/AppModel.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class reviewApp extends StatefulWidget {
  final AppModel app;

  reviewApp({required this.app});

  @override
  _reviewAppState createState() => _reviewAppState();
}

class _reviewAppState extends State<reviewApp> {
  int _rating = 0;
  String _comment = '';
  bool _isLoading = false;

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
      body: SingleChildScrollView(
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
                      image: "https://www.rainforest-alliance.org/wp-content/uploads/2021/06/capybara-square-1.jpg.optimal.jpg",//TODO Узнать какого хрена в апи не передаётся аватарка пользователя
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
                        nameConstructor(false, true, true),
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
                return Padding(padding: const EdgeInsets.symmetric(vertical: 15),
                  child: IconButton(
                    icon: SvgPicture.asset(
                      index < _rating ? 'assets/icons/star_filled_01.svg' : 'assets/icons/star_empty_01.svg',
                      width: 40,
                      height: 40,
                    ),
                    onPressed: () {
                      setState(() {
                        _rating = index + 1;
                      });
                    },
                  ),
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
                  minimumSize: Size(double.infinity, 48),
                  backgroundColor:  Colors.white,
                  side: BorderSide(
                    width: 1.0,
                    color: Theme.of(context).primaryColor,
                    style: BorderStyle.solid,
                  ),
                ),
               onPressed: _isLoading ? null : () { // Disable button during loading
                 setState(() {
                   _isLoading = true; // Set loading state
                 });
                 postReview(widget.app.id, _rating, _comment); // Call postReview
               },
               child: _isLoading
                   ? SpinKitThreeBounce(
                 color: Theme.of(context).primaryColor,
               )
                   : Text(
                 'Отправить',
                 style: TextStyle(color: Colors.black, fontSize: 20),
               ),
              ),

          ],
        ),
      ),
    );
  }

  Future<void> postReview(int appId, int rating, String description) async {
    final apiService = ApiService(); // Create ApiService instance
    try {
      await apiService.postReview(appId, rating, description); // Call API method
      // Handle success (e.g., show a success message)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Отзыв отправлен!", style: TextStyle(fontSize: 24)),
        ),
      );

      if (mounted && context.canPop()){
        context.pop();
      }
    } catch (e) {
      // Handle error (e.g., show an error message)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Ошибка отправки отзыва! $e", style: TextStyle(fontSize: 24)),
        ),
      );
    } finally {
      setState(() {
        _isLoading = false; // Reset loading state
      });
    }
  }

  String nameConstructor(bool lastname, bool firstname, bool middlename){
    String out = "";

    if (lastname){
      out = "$out${context.read<UserProvider>().userData!.lastName} ";
    }
    if (firstname){
      out = "$out${context.read<UserProvider>().userData!.name} ";
    }
    if (middlename){
      out = "$out${context.read<UserProvider>().userData!.middleName!} ";
    }

    return out.trim();
  }

}
