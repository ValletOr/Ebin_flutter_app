import 'package:enplus_market/pages/updatesApp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:enplus_market/models/AppModel.dart';
import 'package:enplus_market/pages/ImageDetailScreen.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_carousel/infinite_carousel.dart';
import 'package:intl/intl.dart';
import 'commonAppBar.dart';
import 'package:enplus_market/pages/aboutApp.dart';
import 'package:enplus_market/pages/reviewApp.dart';
import 'package:enplus_market/services/apiGET_AppDetails.dart';

class appCard extends StatefulWidget {
  final int appId;

  appCard({required this.appId});

  @override
  State<appCard> createState() => _appCardState();
}

class _appCardState extends State<appCard> {
  final TextEditingController _searchController = TextEditingController();

  AppModel? app;

  void GetAppDetails(int appId) async {
    ApiGET_AppDetails instance = ApiGET_AppDetails(id: appId);
    await instance.perform();
    setState(() {
      app = instance.app;
    });
  }

  @override
  void initState() {
    super.initState();
    GetAppDetails(widget.appId);
  }

  @override
  Widget build(BuildContext context) {
    print(GoRouterState.of(context).uri.toString());
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: CommonAppBar(),
        body: app == null
            ? Center(
                child: SpinKitThreeBounce(
                color: Theme.of(context).primaryColor,
              ))
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Часть 1: Картинка и название приложения
                    _buildTopSection(),
                    Container(
                        padding: EdgeInsets.only(left: 109),
                        child: Text(
                          app!.developer ?? '',
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
                    _buildLinksSection(context),
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
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: SizedBox(
            width: 84,
            height: 84,
            child: Image.network(
              app!.icon!,
              fit: BoxFit.contain,
            ),
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(app!.name,
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
                  app!.lastUpdate.version,
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
                  app!.minIos!,
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
      child: app!.status == 'Installed'
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      'Открыть',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontFamily: 'SegoeUI'),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: BorderSide(
                          width: 1.0,
                          color: Color(0xFFFD9330),
                          style: BorderStyle.solid),
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
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontFamily: 'SegoeUI'),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFD9330),
                    ),
                  ),
                ),
              ],
            )
          : app!.status == 'NotInstalled'
              ? ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    'Установить',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontFamily: 'SegoeUI'),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: BorderSide(
                        width: 1.0,
                        color: Color(0xFFFD9330),
                        style: BorderStyle.solid),
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
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontFamily: 'SegoeUI'),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          side: BorderSide(
                              width: 1.0,
                              color: Color(0xFFFD9330),
                              style: BorderStyle.solid),
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
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontFamily: 'SegoeUI'),
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
      child: InfiniteCarousel.builder(
        itemCount: app!.images!.length,
        itemExtent: 120,
        center: false,
        anchor: 0.0,
        velocityFactor: 0.2,
        //onIndexChanged: (index) {},
        //controller: controller,
        axisDirection: Axis.horizontal,
        loop: false,
        itemBuilder: (context, itemIndex, realIndex) {
          return GestureDetector(
            onTap: () {
              _showImageDetail(context, app!.images![itemIndex]);
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 4),
                child: Image.network(
                  app!.images![itemIndex],
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
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

  Widget _buildLinksSection(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return aboutApp(app: app!);
                    },
                    barrierColor: Colors.white,
                    isDismissible: false,
                    isScrollControlled: true,
                    enableDrag: true,
                    useSafeArea: true,
                    showDragHandle: false,
                  );
                },
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(app!.description!,
              style: TextStyle(fontSize: 16, fontFamily: 'SegoeUI'),
              overflow: TextOverflow.ellipsis,
              maxLines: 3),
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
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return UpdatesApp(app: app!);
                    },
                    barrierColor: Colors.white,
                    isDismissible: false,
                    isScrollControlled: true,
                    enableDrag: true,
                    useSafeArea: true,
                    showDragHandle: false,
                  );
                },
              ),
            ],
          ),
          SizedBox(height: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Последняя версия: ${app!.lastUpdate.version}',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              Text(
                'Дата обновления: ${DateFormat('dd.MM.yyyy').format(app!.lastUpdate.date)}',
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
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Оставить отзыв',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: Icon(Icons.arrow_forward),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return reviewApp(app: app!);
                    },
                    barrierColor: Colors.white,
                    isDismissible: false,
                    isScrollControlled: true,
                    enableDrag: true,
                    useSafeArea: true,
                    showDragHandle: false,
                  );
                },
              ),
            ],
          ),
        ]));
  }
}
