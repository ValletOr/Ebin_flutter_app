import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Profile extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          bottom: const TabBar(
            // labelColor: Color(0xFFFD9330),
            // unselectedLabelColor: Color(0xFF212529),
            // indicatorColor: Color(0xFFFD9330) ,
            tabs: [
              Tab(text: "Приложения"),
              Tab(text: "Тестирование"),
              Tab(text: "Установленные"),
            ],
            labelPadding: EdgeInsets.only(right: 1, top: 1),
          ),
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Поиск приложения',
                      contentPadding: const EdgeInsets.all(5.0),
                      prefixIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () => _searchController.clear(),
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {
                          // Perform the search here
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(48.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 5),
                Expanded(
                  flex: 0,
                  child: IconButton(
                      onPressed: () => {},
                      icon: const Icon(
                        Icons.account_circle,
                        size: 48,
                      ),
                      style: IconButton.styleFrom(
                          padding: const EdgeInsets.only(left: 12.0))),
                ),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Text('profile')
            ],
          ),
        ),
      ),
    );
  }
}