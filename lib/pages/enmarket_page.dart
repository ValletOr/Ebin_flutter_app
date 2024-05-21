import 'package:enplus_market/components/short_app_card.dart';
import 'package:enplus_market/models/AppModel.dart';
import 'package:enplus_market/models/ShortAppModel.dart';
import 'package:enplus_market/providers/installation_manager_provider.dart';
import 'package:enplus_market/services/api_service.dart';
import 'package:enplus_market/services/enums.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:enplus_market/pages/app_card_page.dart';
import 'package:provider/provider.dart';
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

class _EnMarketState extends State<EnMarket>
    with SingleTickerProviderStateMixin {
  List<ShortAppModel> apps = [];

  Set<ShortAppModel> selectedApps = {};

  TabController? _tabController;

  AppFetchStatus _fetchStatus = AppFetchStatus.loading;

  bool _isBottomSheetCollapsed = true;

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
          apps = (response["objects"] as List)
              .map((item) => ShortAppModel.fromJson(item))
              .toList();
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

    //print(GoRouterState.of(context).uri.toString());

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
      bottomSheet: context.watch<InstallationManagerProvider>().installationStatus !=InstallationManagerStatus.idle ? (_isBottomSheetCollapsed
          ? _buildCollapsedBottomSheet()
          : _buildFullBottomSheet()) : null,
    );
  }

  Widget _buildFullBottomSheet() {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 3,
            blurRadius: 3,
          ),
        ],
      ),
      height: 200,
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Установлено ${context.watch<InstallationManagerProvider>().installationManager.queueSizeCounter - context.watch<InstallationManagerProvider>().installationManager.getQueue().length}/${context.watch<InstallationManagerProvider>().installationManager.queueSizeCounter}",
                style: const TextStyle(
                  fontSize: 24,
                ),
              ),
              IconButton(
                  onPressed: () {
                    setState(() {
                      _isBottomSheetCollapsed = !_isBottomSheetCollapsed;
                    });
                  },
                  icon: const Icon(
                    Icons.keyboard_arrow_up,
                    size: 32,
                  ))
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        child: Text(context
                            .watch<InstallationManagerProvider>()
                            .processingApp!
                            .name)),
                    Container(
                      //TODO Я заебался, Этот прогрессбар если ему не задать чёткую ширину ломает всё нахрен. Мне надоело, я не верстальщик!
                      height: 10,
                      width: 350,
                      child: LinearProgressIndicator(
                        value: context
                            .watch<InstallationManagerProvider>()
                            .installationProgress,
                      ),
                    ),
                    Container(
                        child: Text("${(context.watch<InstallationManagerProvider>().installationProgress * 100).toInt()}/100")),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCollapsedBottomSheet() {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 3,
            blurRadius: 3,
          ),
        ],
      ),
      height: 70,
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Установлено ${context.watch<InstallationManagerProvider>().installationManager.queueSizeCounter - context.watch<InstallationManagerProvider>().installationManager.getQueue().length}/${context.watch<InstallationManagerProvider>().installationManager.queueSizeCounter}",
            style: const TextStyle(
              fontSize: 24,
            ),
          ),
          IconButton(
              onPressed: () {
                setState(() {
                  _isBottomSheetCollapsed = !_isBottomSheetCollapsed;
                });
              },
              icon: const Icon(
                Icons.keyboard_arrow_up,
                size: 32,
              ))
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
          tabIndex != 2
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
                        context
                            .read<InstallationManagerProvider>()
                            .installationManager
                            .addToQueue(selectedApps.toList());

                        clearSelectedApps();
                      },
                      icon: const Icon(
                        Icons.download,
                        size: 30,
                      ),
                    ),
                  ],
                )
              : Row(
                  //Логика третьего таба с установленными приложениями
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
                    PopupMenuInstalled(
                      selectedApps: selectedApps,
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}

class PopupMenuInstalled extends StatefulWidget {
  const PopupMenuInstalled({super.key, required this.selectedApps});

  final Set<ShortAppModel> selectedApps;

  @override
  State<PopupMenuInstalled> createState() => _PopupMenuInstalledState();
}

class _PopupMenuInstalledState extends State<PopupMenuInstalled> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: const Icon(
        Icons.list,
        size: 30,
      ),
      surfaceTintColor: Colors.white,
      onSelected: (String item) {
        //TODO Not here but also we need to show "update icon" near app with update available
        switch (item) {
          //TODO After finishing with installing, updating and other shit we need to finish this one
          case "Read":
            context.go('/main/appCard/${widget.selectedApps.first}');
          case "Open":
          // LOGIC
          case "Update":
          // LOGIC
          case "Delete":
          // LOGIC
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
            enabled: widget.selectedApps.length == 1,
            value: "Read",
            child: const Row(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.remove_red_eye_outlined,
                  size: 12,
                ),
                Text('Просмотреть'),
              ],
            )),
        PopupMenuItem<String>(
            enabled: widget.selectedApps.length == 1,
            value: "Open",
            child: const Row(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.open_in_new,
                  size: 12,
                ),
                Text('Открыть'),
              ],
            )),
        const PopupMenuItem<String>(
            value: "Update",
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.download,
                  size: 12,
                ),
                Text('Обновить'),
              ],
            )),
        const PopupMenuItem<String>(
            value: "Delete",
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.close,
                  size: 12,
                ),
                Text('Удалить'),
              ],
            )),
      ],
    );
  }
}
