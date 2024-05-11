import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'commonAppBar.dart';

class Profile extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: CommonAppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Text('profile')
            ],
          ),
        ),
      ),
    );
  }
}