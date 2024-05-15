import 'package:enplus_market/components/ShortAppCard.dart';
import 'package:enplus_market/models/AppModel.dart';
import 'package:enplus_market/models/ShortAppModel.dart';
import 'package:enplus_market/services/apiGET_Apps.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:enplus_market/pages/appCard.dart';
import 'commonAppBar.dart';
import 'package:enplus_market/components/AppCheckbox.dart';

class EnMarket extends StatefulWidget {
  EnMarket({Key? key}) : super(key: key);

  @override
  State<EnMarket> createState() => _EnMarketState();
}

class _EnMarketState extends State<EnMarket> {
  List<ShortAppModel> apps = [];

  Set<ShortAppModel> selectedApps = {};

  @override
  void initState() {
    super.initState();
    GetApps();
  }

  void GetApps() async {
    ApiGET_Apps instance = ApiGET_Apps();
    await instance.perform();
    setState(() {
      apps = instance.apps;
      //print(apps[5]);
    });
  }

  void updateSelectedApps(int index, bool value) {
    setState(() {
      if (value) {
        selectedApps.add(apps[index]);
      } else {
        selectedApps.remove(apps[index]);
      }
    });
  }

  void clearSelectedApps(){
    setState(() {
      selectedApps.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    bool anySelected = selectedApps.isNotEmpty;

    print(GoRouterState.of(context).uri.toString());

    return DefaultTabController(
        length: 3,
        //Не меняйте, это количество табов в AppBar, оно фиксированное
        child: Scaffold(
          appBar: CommonAppBar(),
          //TODO USE ANOTHER WAY TO DETERMINE MOMENT TO SHOW SPINNER. MAYBE FutureBuilder will be a great idea.
          body: apps.isEmpty
              ? Center(
                  child: SpinKitThreeBounce(
                  color: Theme.of(context).primaryColor,
                ))
              : Padding(
                  padding: const EdgeInsets.fromLTRB(1.0, 1.0, 1.0, 1.0),
                  child: Column(
                    children: [
                      if (anySelected) ...[
                        _buildSelectedItemsInfo(),
                        SizedBox(height: 10),
                      ],
                      Expanded(
                        child: ListView.builder(
                          itemCount: apps.length,
                          itemBuilder: (context, index) {
                            return ShortAppCard(
                              app: apps[index],
                              onCheckboxValueChanged: (value) {
                                updateSelectedApps(index, value);
                              },
                              isSelected: selectedApps.contains(apps[index]),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
        ));
  }

  Widget _buildSelectedItemsInfo() {
    int selectedCount = selectedApps.length;
    int selectedSize =
        selectedApps.fold(0, (sum, app) => sum + int.parse(app.size));
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                'Выбрано($selectedCount) • $selectedSize MB', // TODO Нужно переработать систему отображения размера файлов. Стоит рассмотреть пакеты proper_filesize, file_sizes
                style: TextStyle(fontSize: 24),
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                padding: EdgeInsets.only(top: 5, left: 25),
                onPressed: clearSelectedApps,
                icon: const Icon(
                  Icons.clear,
                  size: 30,
                ),
              ),
              const SizedBox(width: 16),
              IconButton(
                padding: EdgeInsets.only(top: 5),
                onPressed: () {
                  //TODO: Написать логику установки нескольких приложений.
                },
                icon: const Icon(
                  Icons.download,
                  size: 30,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
