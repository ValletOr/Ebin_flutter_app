import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class CommonAppBar extends StatefulWidget implements PreferredSizeWidget {
  //final ValueChanged<int> onTabChanged;
  final TabBar? tabBar;

  //const CommonAppBar({super.key, required this.onTabChanged});
  const CommonAppBar({super.key, this.tabBar});

  @override
  //Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
  Size get preferredSize => tabBar != null ? Size.fromHeight(105) : Size.fromHeight(AppBar().preferredSize.height);

  @override
  State<CommonAppBar> createState() => _CommonAppBarState();
}

class _CommonAppBarState extends State<CommonAppBar> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      bottom: widget.tabBar,
      // TabBar(
      //
      //   onTap: (tabIndex) {
      //     widget.onTabChanged(tabIndex);
      //   },
      //   tabs: const [
      //     Tab(text: "Приложения"),
      //     Tab(text: "Тестирование"),
      //     Tab(text: "Установленные"),
      //   ],
      //   labelPadding: EdgeInsets.only(right: 1, top: 1),
      // ),
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.black12,
                  hintText: 'Поиск приложения',
                  contentPadding: const EdgeInsets.all(0.0),
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
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(48.0),
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
      icon: const Icon(
        Icons.account_circle,
        size: 48,
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
        const PopupMenuItem<PopupItem>(
          value: PopupItem.titleItem,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.account_circle,
                size: 32,
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Text('USERNAME'),
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
