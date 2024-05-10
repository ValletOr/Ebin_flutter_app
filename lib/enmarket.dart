import 'package:enplus_market/models/Card.dart';
import 'package:flutter/material.dart';
import 'appCard.dart';
class EnMarket extends StatefulWidget {
  final List<Card> cards;
  const EnMarket({Key? key, required this.cards}) : super(key: key);

  @override
  State<EnMarket> createState() => _EnMarketState();

}

class _EnMarketState extends State<EnMarket> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool showIcon = true;
    final List<Widget> _widget = List.generate(
        20,
        (index) => Container(
              child: Text("Hello is $index"),
            ));
    bool a = false;
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            bottom: const TabBar(
              // labelColor: Color(0xFFFD9330),
              // unselectedLabelColor: Color(0xFF212529),
              // indicatorColor: Color(0xFFFD9330) ,
              tabs: [
                Tab(text: "Приложения"),
                Tab(text: "Тестирование"),
                Tab(text: "Установленные"),
              ],
            ),
            title: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 28.0, vertical: 20.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Поиск приложения',
                        contentPadding: const EdgeInsets.all(10.0),
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
                          borderRadius: BorderRadius.circular(46.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    flex: 0,
                    child: IconButton(
                        onPressed: () => {},
                        icon: const Icon(
                          Icons.account_circle,
                          size: 48,
                        ),
                        style: IconButton.styleFrom(
                            padding: const EdgeInsets.only(left: 24.0))),
                  ),
                ],
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(1.0, 1.0, 1.0, 1.0),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(

                    itemCount: _widget.length,
                    itemBuilder: (context, index) {
                      final card = widget.cards[index];
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => appCard(card: card),
                            ),
                          );
                        },
                        child: Card(
                          surfaceTintColor: Colors.white,
                          color: Colors.white,
                          shadowColor: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.ac_unit_outlined,
                                  size: 40,
                                ),
                                const SizedBox(width: 10),
                                const Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        'En+ Binding: App For Best Сyberdsadasdasdasdasdasdasddsdsds...',
                                        overflow: TextOverflow.ellipsis),
                                    SizedBox(height: 2),
                                    Text(
                                      '200 MB',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                )),
                                const SizedBox(width: 5),

                                   Icon(
                                    showIcon ? Icons.ac_unit_outlined : null,

                                    size: 24,
                                  ),

                                Checkbox(
                                  value: a,
                                  onChanged: takeSomething(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
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
