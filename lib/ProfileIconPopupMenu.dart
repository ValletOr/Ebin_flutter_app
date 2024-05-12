import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'profile.dart';
import 'settings.dart';

enum PopupItem { titleItem, profileItem, settingsItem }

class ProfileIconPopupMenu extends StatefulWidget {

  final appBarInstance;

  const ProfileIconPopupMenu({super.key, required this.appBarInstance});

  @override
  State<ProfileIconPopupMenu> createState() => _ProfileIconPopupMenuState();
}

class _ProfileIconPopupMenuState extends State<ProfileIconPopupMenu> {
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
                  builder: (context) => Profile(appBarInstance: widget.appBarInstance),
                ),
              );
            case PopupItem.settingsItem:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsPage(appBarInstance: widget.appBarInstance),
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