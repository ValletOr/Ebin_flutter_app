import 'package:enplus_market/components/short_app_card.dart';
import 'package:enplus_market/models/AppModel.dart';
import 'package:enplus_market/models/ShortAppModel.dart';
import 'package:enplus_market/services/api_service.dart';
import 'package:enplus_market/services/enums.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:enplus_market/pages/app_card_page.dart';
import 'package:string_scanner/string_scanner.dart';
import '../components/common_appbar.dart';
import 'package:enplus_market/components/app_checkbox.dart';

class EnMarket extends StatefulWidget {
  EnMarket({
    super.key,
  });

  @override
  State<EnMarket> createState() => _EnMarketState();
}

class _EnMarketState extends State<EnMarket> with SingleTickerProviderStateMixin {

  List<ShortAppModel> apps = [];
  List<ShortAppModel> allApps = [];
  Set<ShortAppModel> selectedApps = {};

  TabController? _tabController;

  AppFetchStatus _fetchStatus = AppFetchStatus.loading;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 3, vsync: this);
    _tabController!.addListener(() {
      if (!_tabController!.indexIsChanging) {
        setState(() {
          apps.clear();
          _fetchStatus = AppFetchStatus.loading;
        });
        clearSelectedApps();
        fetchApps(_tabController!.index);
      }
    });

    fetchApps(_tabController!.index);
  }

  Future<void> fetchApps(int index) async {
    try {
      final apiService = ApiService();
      final response = await apiService.getApps(index);

      if (response["objects"].isNotEmpty) {
        setState(() {
          allApps = (response["objects"] as List)
              .map((item) => ShortAppModel.fromJson(item))
              .toList();
          apps = allApps;

          _fetchStatus = AppFetchStatus.success;
        });
      } else {
        setState(() {
          _fetchStatus = AppFetchStatus.noData;
        });
      }
    } catch (e) {
      setState(() {
        _fetchStatus = AppFetchStatus.error;
      });
    }
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

  void clearSelectedApps() {
    setState(() {
      selectedApps.clear();
    });
  }


  @override
  Widget build(BuildContext context) {
    bool anySelected = selectedApps.isNotEmpty;

    return Scaffold(
      appBar: CommonAppBar(
        tabBar: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: "Приложения"),
            Tab(text: "Тестирование"),
            Tab(text: "Установленные"),
          ],
          labelPadding: const EdgeInsets.only(right: 1, top: 1),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildTabView(0, anySelected),
          _buildTabView(1, anySelected),
          _buildTabView(2, anySelected),
        ],
      ),
    );
  }

  Widget _buildTabView(int tabIndex, bool anySelected) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(1.0, 1.0, 1.0, 1.0),
      child: Column(
        children: [
          if (anySelected) ...[
            _buildSelectedItemsInfo(tabIndex),
            const SizedBox(height: 10),
          ],
          Expanded(
            child: _buildAppList(tabIndex),
          ),
        ],
      ),
    );
  }

  Widget _buildAppList(int tabIndex) {
    switch (_fetchStatus) {
      case AppFetchStatus.loading:
        return Center(
          child: SpinKitThreeBounce(
            color: Theme.of(context).primaryColor,
          ),
        );
      case AppFetchStatus.success:
        return ListView.builder(
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
        );
      case AppFetchStatus.error:
        return const Center(
          child: Text('Произошла ошибка. Попробуйте позже.'),
        );
      case AppFetchStatus.noData:
        return const Center(
          child: Text('Приложений нет.'),
        );
      default:
        return const Center(
          child: Text('Что-то пошло не так...'),
        );
    }
  }

  double convertStringToMb(String input) {
    final scanner = StringScanner(input);
    scanner.scan(RegExp(r'\d+\.?\d*'));
    final number = double.tryParse(scanner.lastMatch!.group(0)!) ?? 0.0;
    return number;
  }

  Widget _buildSelectedItemsInfo(int tabIndex) {
    int selectedCount = selectedApps.length;
    double selectedSize =
    selectedApps.fold(0, (sum, app) => sum + convertStringToMb(app.size));
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                'Выбрано($selectedCount) • $selectedSize MB',
                style: const TextStyle(fontSize: 24),
              ),
            ],
          ),
          tabIndex != 3
              ? Row(
            children: [
              IconButton(
                padding: const EdgeInsets.only(top: 5, left: 25),
                onPressed: clearSelectedApps,
                icon: const Icon(
                  Icons.clear,
                  size: 30,
                ),
              ),
              const SizedBox(width: 16),
              IconButton(
                padding: const EdgeInsets.only(top: 5),
                onPressed: () {
                  //TODO: Написать логику установки нескольких приложений.
                },
                icon: const Icon(
                  Icons.download,
                  size: 30,
                ),
              ),
            ],
          )
              : Row(
            //TODO Переделать этот Row, это для третьего таба
            children: [
              IconButton(
                padding: const EdgeInsets.only(top: 5, left: 25),
                onPressed: clearSelectedApps,
                icon: const Icon(
                  Icons.clear,
                  size: 30,
                ),
              ),
              const SizedBox(width: 16),
              IconButton(
                padding: const EdgeInsets.only(top: 5),
                onPressed: () {},
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

