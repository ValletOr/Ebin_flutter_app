import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:enplus_market/models/CardModel.dart';

class appCard extends StatelessWidget {
  final CardModel card;
  final TextEditingController _searchController = TextEditingController();

  appCard({required this.card});

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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Часть 1: Картинка и название приложения
              _buildTopSection(),
              Container(
                  padding: EdgeInsets.only(left: 108),
                  child: Text(
                    card.Companies ?? '',
                    style: TextStyle(fontSize: 16, color: Color(0xFFFD9330)),
                  )),

              // Часть 2: Версия приложения и размер
              _buildVersionSection(),

              // Часть 3: Кнопка "Установить"
              _buildInstallButton(),

              // Часть 4: Набор картинок
              _buildImageGallery(),

              // Часть 5: Ссылки "О приложении" и "Обновления"
              _buildLinksSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopSection() {
    return Container(
      padding: EdgeInsets.only(left: 8, right: 8, top: 8),
      child: Row(children: [
        SizedBox(
          width: 84,
          height: 84,
          child: Image.asset(
            card.IconFile,
            fit: BoxFit.contain,
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(card.Name,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2),
              ]),
        ),
      ]),
    );
  }

  Widget _buildVersionSection() {
    return Container(
      padding: EdgeInsets.only(top: 8, bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.access_time_sharp, size: 30),
                Text(
                  card.Version,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          Container(
            height: 24,
            width: 1,
            color: Colors.black,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add_circle_outline, size: 30),
                Text(
                  card.MinIos,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInstallButton() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: card.Status == 'Installed'
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Открыть'),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Удалить'),
                ),
              ],
            )
          : card.Status == 'UnInstalled'
              ? ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    'Установить',
                  ),
          style: ElevatedButton.styleFrom(
            textStyle: TextStyle(fontSize: 20),
            backgroundColor: Colors.white,

            elevation: 5.0,
          )
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Обновить'),
                    ),
                    SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Удалить'),
                    ),
                  ],
                ),
    );
  }

  Widget _buildImageGallery() {
    return Container(
      height: 200,
      child: PageView.builder(
        itemCount: card.ImagesFiles.length,
        itemBuilder: (context, index) {
          return Image.network(
            card.ImagesFiles[index],
            fit: BoxFit.cover,
          );
        },
      ),
    );
  }

  Widget _buildLinksSection() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(
            onPressed: () {
              // Действие при нажатии на ссылку "О приложении"
            },
            child: Text('О приложении'),
          ),
          TextButton(
            onPressed: () {
              // Действие при нажатии на ссылку "Обновления"
            },
            child: Text('Обновления'),
          ),
        ],
      ),
    );
  }
}
