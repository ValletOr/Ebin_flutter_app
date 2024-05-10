import 'package:enplus_market/models/CardModel.dart';
import 'package:flutter/material.dart';
import 'appCard.dart';
class EnMarket extends StatefulWidget {
  final List<CardModel> cards;
  const EnMarket({Key? key, required this.cards}) : super(key: key);

  @override
  State<EnMarket> createState() => _EnMarketState();

}

class _EnMarketState extends State<EnMarket> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool showIcon = true;
    final List<CardModel> cards = [
      CardModel(
        id: '1',
        Status: 'Type 1',
        Name: 'Business Plan 1',
        Description: 'Description 1',
        Developer: 'Author 1',
        MinIos: 'pdf_link_1',
        MinAndroid: 'https://1.bp.blogspot.com/-oWFpNj6K5H0/XOOyphxpllI/AAAAAAAAAW8/jJX1Ncd4HpMB8dL5tXybq1T4SmKvI8U-gCLcBGAs/s1600/sudah%2Bkonk%2Bfirebase.PNG',
        IconFile: 'check_1',
        ImagesFiles: ['sad','sadsad'],
        Version: 'amount_1',
        ApkFile: 'link_1',
        TestFlight: 'Address 1',
        Companies: 'Number 1',
      ),
      CardModel(
        id: '2',
        Status: 'Type 2',
        Name: 'Business Plan 2',
        Description: 'Description 2',
        Developer: 'Author 2',
        MinIos: 'pdf_link_2',
        MinAndroid: 'https://u-tune.ru/wp-content/uploads/6/d/8/6d866d819a429ddecb5ede75ba9edde7.jpeg',
        IconFile: 'check_2',
        ImagesFiles: ['sad','sadsad'],
        Version: 'amount_2',
        ApkFile: 'link_2',
        TestFlight: 'Address 2',
        Companies: 'Number 2',
      ),
      CardModel(
        id: '3',
        Status: 'Type 3',
        Name: 'Business Plan 3',
        Description: 'Description 3',
        Developer: 'Author 3',
        MinIos: 'pdf_link_3',
        MinAndroid: 'photo_link_3',
        IconFile: 'check_3',
        ImagesFiles: ['sad','sadsad'],
        Version: 'amount_3',
        ApkFile: 'link_3',
        TestFlight: 'Address 3',
        Companies: 'Number 3',
      ),
    ];
    bool a = false;
    return DefaultTabController(
        length: cards.length,
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

                    itemCount: cards.length,
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
                                 Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        card.Name.isNotEmpty ? card.Name:'Название отсутствует',
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
                                    showIcon ? Icons.check_circle_outline : null,
                                    color: Color(0xFFFD9330),

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
