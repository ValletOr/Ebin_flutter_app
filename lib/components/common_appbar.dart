import 'dart:ui';
import 'package:enplus_market/components/CustomSearchDelegate.dart';
import 'package:enplus_market/providers/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CommonAppBar extends StatefulWidget implements PreferredSizeWidget {
  //final ValueChanged<int> onTabChanged;
  final TabBar? tabBar;

  //const CommonAppBar({super.key, required this.onTabChanged});
  const CommonAppBar({super.key, this.tabBar});

  @override
  //Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
  Size get preferredSize => tabBar != null
      ? Size.fromHeight(105)
      : Size.fromHeight(AppBar().preferredSize.height);

  @override
  State<CommonAppBar> createState() => _CommonAppBarState();
}

class _CommonAppBarState extends State<CommonAppBar> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String? pathName = GoRouterState.of(context).name;
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
        padding: const EdgeInsets.symmetric(horizontal: 0.0),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                readOnly: true,

                onTap: () {
                  showSearch(
                      context: context,
                      delegate: CustomSearchDelegate(pathName: pathName));
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.black12,
                  hintText: 'Поиск приложения',
                  contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                  suffixIcon: IconButton(
                    icon: SvgPicture.asset(
                      'assets/icons/search_01.svg',
                    ),
                    onPressed: () {
                      showSearch(
                          context: context,
                          delegate: CustomSearchDelegate(pathName: pathName));
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
            image: "https://www.rainforest-alliance.org/wp-content/uploads/2021/06/capybara-square-1.jpg.optimal.jpg",
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
                    image: "https://www.rainforest-alliance.org/wp-content/uploads/2021/06/capybara-square-1.jpg.optimal.jpg",
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
            ],
          ),
        ),
        PopupMenuItem<PopupItem>(
            value: PopupItem.profileItem,
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/icons/user_01.svg',
                  height: 14,
                  width: 14,
                ),
                const Padding(padding: EdgeInsets.only(left: 10)),
                const Text('Профиль'),
              ],
            )),
        PopupMenuItem<PopupItem>(
            value: PopupItem.settingsItem,
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/icons/settings.svg',
                  height: 14,
                  width: 14,
                ),
                const Padding(padding: EdgeInsets.only(left: 10)),
                const Text('Настройки'),
              ],
            )),
      ],
    );
  }
}
