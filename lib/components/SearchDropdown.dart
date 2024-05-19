import 'package:flutter/material.dart';
import 'package:enplus_market/models/ShortAppModel.dart';
import 'package:go_router/go_router.dart';

class SearchDropdown extends StatelessWidget {
  final List<ShortAppModel> apps;
  final Function(ShortAppModel) onAppSelected;


  const SearchDropdown({
    Key? key,
    required this.apps,
    required this.onAppSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(

        child: ListView.builder(
          padding: EdgeInsets.only(),
          shrinkWrap: true,
          itemCount: apps.length,
          itemBuilder: (context, index) {
            return ListTile(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
              dense: true,
              leading: ClipRRect(
                child: Image.network(apps[index].icon, width: 40, height: 40),
              ),
              title: Text(
                apps[index].name,
                style: TextStyle(fontSize: 20.0),
              ),
              subtitle: Text(
                apps[index].size,
                style: TextStyle(fontSize: 10),
              ),


                onTap: () {
                  onAppSelected(apps[index].id as ShortAppModel);
                },



            );
          },
        ),

    );
  }
}
