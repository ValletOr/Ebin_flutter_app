import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import '../components/common_appbar.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: CommonAppBar(),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //====================================Page content here===========================

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: Text("Уведомления")
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        "Уведомления приложения",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Установка приложения"),
                        SettingsSwitch(),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Обновление приложения"),
                        SettingsSwitch(),
                      ],
                    ),
                    Divider(height: 30.0),
                    Container(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: Text("Общие")
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        "Тема",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text("Системная"),

                  ],
                ),

                //====================================Page content ends here===========================
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class SettingsSwitch extends StatefulWidget {
  const SettingsSwitch({super.key});

  @override
  State<SettingsSwitch> createState() => _SettingsSwitchState();
}

class _SettingsSwitchState extends State<SettingsSwitch> {
  bool light = true;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 0.6,
      child: Switch(
        value: light,
        materialTapTargetSize: MaterialTapTargetSize.values.first,
        onChanged: (bool value) {
          setState(() {
            light = value;
          });
        },
      ),
    );
  }
}