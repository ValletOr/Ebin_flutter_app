import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'commonAppBar.dart';

class Profile extends StatelessWidget {

  final appBarInstance;

  Profile({required this.appBarInstance});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: appBarInstance,
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //====================================Page content here===========================

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 30.0),
                      child: Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(
                                "https://media.tenor.com/9ps0i3-ykcAAAAAM/shocked-shocked-guy.gif"),
                          ),
                          ),
                        ),
                    ),
                  ],
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "ФИО",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text("Фамилмя Имя Отчество"),
                    Divider(height: 30.0),
                    Text(
                      "Предприятие",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text("Наименование предприятия"),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30.0),
                      child: TextButton(
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text("Выйти"),
                            Icon(
                              Icons.close,
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                //====================================Page content ends here===========================
              ],
            ),
          ),
        ),
      ),
    );
  }
}
