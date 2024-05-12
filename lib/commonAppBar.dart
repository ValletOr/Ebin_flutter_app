import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'models/CardModel.dart';
import 'profile.dart';
import 'settings.dart';
import 'ProfileIconPopupMenu.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  List<CardModel> cards;
  List<CardModel> foundCards;


  final TextEditingController _searchController = TextEditingController();

  CommonAppBar({Key? key, required this.cards, required this.foundCards}) : super(key: key);

  // @override
  // State<CommonAppBar> createState() => CommonAppBarState();
  Size get preferredSize => const Size.fromHeight(110);

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
      foundCards = results;
      print(foundCards);
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
              child: ProfileIconPopupMenu(appBarInstance: this),
            ),
          ],
        ),
      ),
    );
  }
}

//
// class CommonAppBarState extends State<CommonAppBar> {
//   final TextEditingController _searchController = TextEditingController();
//
//   Size get preferredSize => const Size.fromHeight(110);
//
//   @override
//   initState() {
//     widget.foundCards = widget.cards;
//     super.initState();
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     String searchString = "";
//     void _runFilter(String enteredKeyword) {
//       List<CardModel> results = [];
//       if (enteredKeyword.isEmpty) {
//         results = widget.cards;
//       } else {
//         results = widget.cards
//             .where((card) =>
//             card.Name.toLowerCase().contains(enteredKeyword.toLowerCase()))
//             .toList();
//       }
//
//       setState(() {
//         widget.foundCards = results;
//       });
//     }
//     return AppBar(
//       backgroundColor: Colors.white,
//       surfaceTintColor: Colors.white,
//       bottom: const TabBar(
//         tabs: [
//           Tab(text: "Приложения"),
//           Tab(text: "Тестирование"),
//           Tab(text: "Установленные"),
//         ],
//         labelPadding: EdgeInsets.only(right: 1, top: 1),
//       ),
//       title: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 10.0),
//         child: Row(
//           children: [
//             Expanded(
//               child: TextField(
//                 onChanged: (String value) async {
//                   searchString = value.toLowerCase();
//                   _runFilter(searchString);
//                 },
//                 controller: _searchController,
//                 decoration: InputDecoration(
//                   hintText: 'Поиск приложения',
//                   contentPadding: const EdgeInsets.all(5.0),
//                   prefixIcon: IconButton(
//                     icon: const Icon(Icons.clear),
//                     onPressed: () => _searchController.clear(),
//                   ),
//                   suffixIcon: IconButton(
//                     icon: const Icon(Icons.search),
//                     onPressed: () {
// // Perform the search here
//                     },
//                   ),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(48.0),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(width: 5),
//             Expanded(
//               flex: 0,
//               child: ProfileIconPopupMenu(appBarInstance: this),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
// }
