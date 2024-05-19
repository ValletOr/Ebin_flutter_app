import 'dart:ui';

import 'package:enplus_market/providers/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:enplus_market/components/SearchDropdown.dart';
import 'package:enplus_market/models/ShortAppModel.dart';
import 'package:enplus_market/services/api_service.dart';
import 'package:enplus_market/services/enums.dart';

class CommonAppBar extends StatefulWidget implements PreferredSizeWidget {
  final TabBar? tabBar;
  final ValueChanged<List<ShortAppModel>>? onSearchChanged;
  final List<ShortAppModel>? searchResults;
  final Function(ShortAppModel)? onAppSelected;
  final VoidCallback? onSearchTapped;

  const CommonAppBar({
    super.key,
    this.tabBar,
    this.onSearchChanged,
    this.onSearchTapped,
    this.searchResults,
    this.onAppSelected,
  });

  @override
  Size get preferredSize => tabBar != null
      ? Size.fromHeight(105)
      : Size.fromHeight(AppBar().preferredSize.height);

  @override
  State<CommonAppBar> createState() => _CommonAppBarState();
}

class _CommonAppBarState extends State<CommonAppBar> {
  List<ShortAppModel> apps = [];
  List<ShortAppModel> allApps = [];
  Set<ShortAppModel> selectedApps = {};

  List<ShortAppModel> filteredApps = [];
  final TextEditingController _searchController = TextEditingController();
  OverlayEntry? _overlayEntry;

  Future<void> fetchApps(int index) async {
    final apiService = ApiService();
    final response = await apiService.getApps(index);

    if (response["objects"].isNotEmpty) {
      setState(() {
        allApps = (response["objects"] as List)
            .map((item) => ShortAppModel.fromJson(item))
            .toList();
        apps = allApps;
        filteredApps = allApps;
      });
    }
  }

  void refreshApps() {
    fetchApps(0);
  }

  void searchApps(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredApps = allApps;
      } else {
        filteredApps = allApps
            .where(
                (app) => app.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      bottom: widget.tabBar,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _searchController,
                onTap: () {
                  refreshApps();
                  _updateOverlay(context);
                },
                onChanged: (value) {
                  searchApps(value);
                  _updateOverlay(context);
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white10,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide(color: Colors.orange, width: 2.0),
                  ),
                  hintText: 'Поиск приложения',
                  contentPadding: const EdgeInsets.all(0.0),
                  prefixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _searchController.clear();
                      searchApps('');
                      _removeOverlay();
                    },
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {},
                  ),
                ),
              ),
            ),
            SizedBox(width: 5),
            Expanded(
              flex: 0,
              child: PopupMenu(),
            ),
          ],
        ),
      ),
    );
  }

  void _updateOverlay(BuildContext context) {
    _removeOverlay();
    final overlay = Overlay.of(context);
    if (overlay == null) return;

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: MediaQuery.of(context).size.width - 20,
        top: 105,
        left: 10,
        child: SearchDropdown(
          apps: filteredApps,
          onAppSelected: (apps) => onAppSelected(apps, context),
        ),
      ),
    );

    overlay.insert(_overlayEntry!);
  }

  void onAppSelected(ShortAppModel app, BuildContext context) {
    _removeOverlay();
    context.go('/main/appCard/${app.id}'); // Navigate to app card
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}

enum PopupItem { titleItem, profileItem, settingsItem }

class PopupMenu extends StatefulWidget {
  const PopupMenu({super.key});

  @override
  State<PopupMenu> createState() => _PopupMenuState();
}

class _PopupMenuState extends State<PopupMenu> {
  PopupItem? selectedItem;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<PopupItem>(
      // icon: const Icon(
      //   Icons.account_circle,
      //   size: 48,
      // ),
      icon: ClipRRect(
        borderRadius: BorderRadius.circular(24), // Image border
        child: SizedBox.fromSize(
          size: Size.fromRadius(24), // Image radius
          child: FadeInImage.assetNetwork(
            placeholder: "assets/img/placeholder.png",
            //context.read<UserProvider>().userData!
            image: "https://picsum.photos/200",
            //TODO Узнать какого хрена в апи не передаётся аватарка пользователя
            fit: BoxFit.fill,
          ),
        ),
      ),
      surfaceTintColor: Colors.white,
      // initialValue: selectedItem,
      onSelected: (PopupItem item) {
        setState(() {
          selectedItem = item;
          switch (selectedItem) {
            case PopupItem.profileItem:
              context.go("/main/profile");
            case PopupItem.settingsItem:
              context.go("/main/settings");
            default:
            //idk?
          }
        });
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<PopupItem>>[
        PopupMenuItem<PopupItem>(
          value: PopupItem.titleItem,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16), // Image border
                child: SizedBox.fromSize(
                  size: Size.fromRadius(16), // Image radius
                  child: FadeInImage.assetNetwork(
                    placeholder: "assets/img/placeholder.png",
                    //context.read<UserProvider>().userData!
                    image: "https://picsum.photos/200",
                    //TODO Узнать какого хрена в апи не передаётся аватарка пользователя
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Text(context.read<UserProvider>().userData!.name),
                    context.read<UserProvider>().userData!.middleName != null
                        ? Text(
                            context.read<UserProvider>().userData!.middleName!)
                        : const SizedBox.shrink(),
                  ],
                ),
              ),
              // Expanded(
              //   flex: 1,
              //   child: Icon(
              //     Icons.account_circle,
              //     size: 32,
              //   ),
              // ),
              // Expanded(
              //   flex: 3,
              //     child: Text('USERNAME')
              // ),
            ],
          ),
        ),
        const PopupMenuItem<PopupItem>(
            value: PopupItem.profileItem,
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.person_outline,
                  size: 12,
                ),
                Text('Профиль'),
              ],
            )),
        const PopupMenuItem<PopupItem>(
            value: PopupItem.settingsItem,
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.settings_outlined,
                  size: 12,
                ),
                Text('Настройки'),
              ],
            )),
      ],
    );
  }
}
