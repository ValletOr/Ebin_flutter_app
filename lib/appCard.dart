import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:enplus_market/models/CardModel.dart';
import 'package:enplus_market/ImageDetailScreen.dart';
import 'commonAppBar.dart';

class appCard extends StatelessWidget {
  final CardModel card;
  final TextEditingController _searchController = TextEditingController();

  appCard({required this.card});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: CommonAppBar(),
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
                    style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFFFD9330),
                        fontFamily: 'SegoeUI'),
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
                    style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'SegoeUI'),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3),
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
                  style: TextStyle(fontSize: 16, fontFamily: 'SegoeUI'),
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
                  style: TextStyle(fontSize: 16, fontFamily: 'SegoeUI'),
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
          Expanded(
            child: ElevatedButton(
              onPressed: () {},
              child: Text(
                'Открыть',
                style: TextStyle(fontSize: 20, color: Colors.black, fontFamily: 'SegoeUI'),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                side: BorderSide(width: 1.0, color: Color(0xFFFD9330), style: BorderStyle.solid),
                elevation: 5.0,
              ),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              onPressed: () {},
              child: Text(
                'Удалить',
                style: TextStyle(fontSize: 20, color: Colors.white, fontFamily: 'SegoeUI'),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFD9330),
              ),
            ),
          ),
        ],
      )
          : card.Status == 'UnInstalled'
          ? ElevatedButton(
        onPressed: () {},
        child: Text(
          'Установить',
          style: TextStyle(fontSize: 20, color: Colors.black, fontFamily: 'SegoeUI'),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          side: BorderSide(width: 1.0, color: Color(0xFFFD9330), style: BorderStyle.solid),
          elevation: 5.0,
        ),
      )
          : Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {},
              child: Text(
                'Обновить',
                style: TextStyle(fontSize: 20, color: Colors.black, fontFamily: 'SegoeUI'),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                side: BorderSide(width: 1.0, color: Color(0xFFFD9330), style: BorderStyle.solid),
                elevation: 5.0,
              ),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              onPressed: () {},
              child: Text(
                'Удалить',
                style: TextStyle(fontSize: 20, color: Colors.white, fontFamily: 'SegoeUI'),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFD9330),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageGallery() {
    return Container(
      height: 200,
      child: PageView.builder(
        itemCount: (card.ImagesFiles.length / 2).ceil(),
        itemBuilder: (context, pageIndex) {
          final startIndex = pageIndex * 2;
          final endIndex = startIndex + 2;
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: endIndex <= card.ImagesFiles.length ? 1 : 0,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  SizedBox(width: 8),
                  for (int i = startIndex; i < endIndex; i++)
                    if (i < card.ImagesFiles.length)
                      InkWell(
                        onTap: () {
                          _showImageDetail(context, card.ImagesFiles[i]);
                        },
                        child: Padding(
                          padding: EdgeInsets.only(right: 8),
                          child: Image.asset(
                            card.ImagesFiles[i],
                            height: 200,
                            width: 180,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                ],
              );
            },
          );
        },
      ),
    );
  }
  void _showImageDetail(BuildContext context, String imageUrl) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ImageDetailScreen(imageUrl: imageUrl),
      ),
    );
  }

  Widget _buildLinksSection() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'О приложении',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: Icon(Icons.arrow_forward),
                onPressed: () {
                  // Действие при нажатии на кнопку перехода к детальному описанию
                },
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            card.Description,
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'SegoeUI'),
              overflow: TextOverflow.ellipsis,
              maxLines: 3
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Обновления',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: Icon(Icons.arrow_forward),
                onPressed: () {

                },
              ),
            ],
          ),
          SizedBox(height: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Последняя версия: ${card.Version}',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              Text(
                'Дата обновления: [дата обновления]',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Краткое описание последнего обновления',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
]
    )
    );
  }

}
