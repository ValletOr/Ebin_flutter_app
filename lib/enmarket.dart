import 'package:flutter/material.dart';

class EnMarket extends StatefulWidget {
  const EnMarket({super.key});

  @override
  State<EnMarket> createState() => _EnMarketState();
}

class _EnMarketState extends State<EnMarket> {
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    final List<Widget> _widget = List.generate(20,
            (index) => Container(
          child: Text("Hello is $index"),
        ));
    bool a = false;
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(text: "Приложения"),
                Tab(text: "Тестирование"),
                Tab(text: "Установленные"),
              ],
            ),
            title: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 20.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Поиск приложения',
                        contentPadding: const EdgeInsets.all(10.0),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () => _searchController.clear(),
                        ),
                        prefixIcon: IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () {
                            // Perform the search here
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(46.0),
                        ),
                      ),),
                  ),
                  Expanded(
                    flex: 0,
                    child: IconButton(
                        onPressed: ()=>{},
                        icon: const Icon(Icons.account_circle, size: 48,),
                        style: IconButton.styleFrom(padding: const EdgeInsets.only(left: 24.0))),
                  ),
                ],
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(30.0, 32.0, 30.0, 0),
            child: Column(
              children: [
                Expanded(
                    child: SingleChildScrollView(
                      child: ExpansionPanelList.radio(
                        children: _widget.map(
                                (e) => ExpansionPanelRadio(
                                value: e,
                                headerBuilder: (BuildContext context, bool isExpanded)=>Row(
                                  children: [
                                    Icon(Icons.ac_unit_outlined),
                                    Text("fgfdgfgdgd"),
                                    Expanded(
                                      flex: 1,
                                      child: Checkbox(value: a, onChanged: takeSomething()),
                                    ),
                                  ],
                                ),
                                body: e
                            )).toList(),
                      ),
                    )
                ),
              ],
            ),
          ),)
    );
  }
  takeSomething() {}
}
// Scaffold(
// appBar: AppBar(
// bottom: const TabBar(
// tabs: [
// Tab(icon: Icon(Icons.directions_car)),
// Tab(icon: Icon(Icons.directions_transit)),
// Tab(icon: Icon(Icons.directions_bike)),
// ],
// ),
// title: const Text('Tabs Demo'),
// ),
// body: Padding(
// padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 20.0),
// child: Column(
// children: [
// Padding(
// padding: const EdgeInsets.only(bottom: 20.0),
// child: Row(
// children: [
// Expanded(
// child: TextField(
// controller: _searchController,
// decoration: InputDecoration(
// hintText: 'Поиск приложения',
// contentPadding: const EdgeInsets.all(10.0),
// suffixIcon: IconButton(
// icon: const Icon(Icons.clear),
// onPressed: () => _searchController.clear(),
// ),
// prefixIcon: IconButton(
// icon: const Icon(Icons.search),
// onPressed: () {
// // Perform the search here
// },
// ),
// border: OutlineInputBorder(
// borderRadius: BorderRadius.circular(46.0),
// ),
// ),),
// ),
// Expanded(
// flex: 0,
// child: IconButton(
// onPressed: ()=>{},
// icon: const Icon(Icons.account_circle, size: 48,),
// style: IconButton.styleFrom(padding: const EdgeInsets.only(left: 24.0))),
// ),
// ],
// ),
// ),
// Expanded(
// child: SingleChildScrollView(
// child: ExpansionPanelList.radio(
// children: _widget.map(
// (e) => ExpansionPanelRadio(
// value: e,
// headerBuilder: (BuildContext context, bool isExpanded)=>ListTile(
// title: Text("My title"),
// ),
// body: e
// )).toList(),
// ),
// )
// ),
// ],
// ),
// ),)
