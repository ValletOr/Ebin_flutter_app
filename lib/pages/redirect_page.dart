import 'package:enplus_market/exceptions/unauthorized_exception.dart';
import 'package:enplus_market/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class Redirect extends StatefulWidget {

  @override
  State<Redirect> createState() => _RedirectState();
}

class _RedirectState extends State<Redirect> {

  void getUserAccount() async{
    try{
      await context.read<UserProvider>().getAccount();

      if (mounted){
        context.go("/main");
      }
    } on UnauthorizedException{
      if (mounted){
        context.go("/login");
      }
    }catch (e) {
      if (mounted){
        context.go("/login");
      }
    }
  }

  @override
  void initState() {
    super.initState();

    getUserAccount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitThreeBounce(
          color: Theme.of(context).primaryColor,
        ), // Simple spinner
      ),
    );
  }
}