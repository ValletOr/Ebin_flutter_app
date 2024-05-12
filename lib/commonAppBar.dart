import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'models/CardModel.dart';
import 'profile.dart';
import 'settings.dart';

class CommonAppBar extends StatefulWidget implements PreferredSizeWidget {
  final List<CardModel> cards;
  final List<CardModel> foundCards;

  const CommonAppBar({Key? key, required this.cards, required this.foundCards}) : super(key: key);

  @override
  State<CommonAppBar> createState() => CommonAppBarState();
  //Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
  Size get preferredSize => const Size.fromHeight(100);

}

class CommonAppBarState extends State<CommonAppBar> {
  final TextEditingController _searchController = TextEditingController();
  @override
  initState() {
    widget.foundCards = widget.cards;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    String searchString = "";
    void _runFilter(String enteredKeyword) {
      List<CardModel> results = [];
      if (enteredKeyword.isEmpty) {
        results = cards;
      } else {
        results = cards
            .where((card) =>
            card.Name.toLowerCase().contains(enteredKeyword.toLowerCase()))
            .toList();
      }

      setState(() {
        _foundCards = results;
      });
    }
    return AppBar(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      bottom: const TabBar(
        tabs: [
          Tab(text: "Приложения"),
          Tab(text: "Тестирование"),
          Tab(text: "Установленные"),
        ],
        labelPadding: EdgeInsets.only(right: 1, top: 1),
      ),
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                onChanged: (String value) async {
                  searchString = value.toLowerCase();
                  _runFilter(searchString);
                },
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Profile(),
                ),
              );
            case PopupItem.settingsItem:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsPage(),
                ),
              );
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
