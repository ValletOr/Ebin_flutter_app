import 'package:enplus_market/models/AppModel.dart';
import 'package:enplus_market/models/UpdatesModel.dart';
import 'package:enplus_market/services/apiGET_Apps.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'appCard.dart';
import 'commonAppBar.dart';
import 'package:enplus_market/components/AppCheckbox.dart';

class EnMarket extends StatefulWidget {

  //final List<UpdatesModel> Updates;

  EnMarket({Key? key}) : super(key: key);
  //const EnMarket({Key? key, required this.cards, required this.Updates}) : super(key: key);

  @override
  State<EnMarket> createState() => _EnMarketState();
}

class _EnMarketState extends State<EnMarket> {

  List<CardModel> cards = [];

  List<bool> selectedStates = [];

  @override
  void initState() {
    super.initState();
    GetApps();
  }

  void GetApps() async{
    ApiGET_Apps instance = ApiGET_Apps();
    await instance.perform();
    setState(() {
      cards = instance.apps;
      selectedStates = List<bool>.filled(cards.length, false);
    });
  }

  void updateSelectedState(int index, bool value) {
    setState(() {
      selectedStates[index] = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool showIcon = true;
    bool anySelected = selectedStates.any((element) => element);
    return DefaultTabController(
        length: 3, //Не меняйте, это количество табов в AppBar, оно фиксированное
        child: Scaffold(
          appBar: CommonAppBar(),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(1.0, 1.0, 1.0, 1.0),
            child: Column(
              children: [
                if (anySelected) ...[
                  _buildSelectedItemsInfo(),
                  SizedBox(height: 10),
                ],
                Expanded(
                  child: ListView.builder(
                    itemCount: cards.length,
                    itemBuilder: (context, index) {
                      final card = cards[index];
                      //final Updates = widget.Updates[index];
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
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        Text(
                                            card.Name.isNotEmpty
                                                ? card.Name
                                                : 'Название отсутствует',
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

                                // Checkbox(
                                //   value: isChecked,
                                //   onChanged: (bool? newValue) {
                                //     setState(() {
                                //       this.isChecked = newValue!;
                                //     });
                                //   },
                                // ),

                                AppCheckbox(value: selectedStates[index],
                                  onChanged: (value) {
                                    setState(() {
                                      updateSelectedState(index, value!);
                                    });
                                  },)

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
  Widget _buildSelectedItemsInfo() {
    int selectedCount = selectedStates.where((element) => element).length;
    int selectedSize = 0; //TODO: Написать логику подсчета МБ
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [

              Text(
                'Выбрано($selectedCount) • $selectedSize',
                style: TextStyle(fontSize: 24),
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                padding: EdgeInsets.only(top: 5, left: 25),
                onPressed: () {
                  setState(() {
                    selectedStates = List<bool>.filled(cards.length, false);
                  });
                },
                icon: Icon(Icons.clear , size: 30,),
              ),
              SizedBox(width: 16),
              IconButton(
                padding: EdgeInsets.only(top: 5),
                onPressed: () {
                  //TODO: Написать логику установки нескольких приложений.
                },
                icon: Icon(Icons.download , size: 30, ),
              ),
            ],
          ),
        ],
      ),
    );
  }

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
