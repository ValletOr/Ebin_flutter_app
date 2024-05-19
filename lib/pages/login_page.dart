import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'otp_page.dart';

class PhoneAuthPage extends StatefulWidget {
  const PhoneAuthPage({super.key});

  @override
  State<PhoneAuthPage> createState() => _PhoneAuthPageState();
}

class _PhoneAuthPageState extends State<PhoneAuthPage> {
  final _numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 200, bottom: 10),
            child: Text(
              "EBin Store",
              style: TextStyle(fontSize: 36),
            ),
          ),
          Text(
            "Введите свой номер телефона",
            style: TextStyle(fontSize: 16),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(40.0, 70.0, 40.0, 0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black38,
                              blurRadius: 25.0,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(9),
                          color: Colors.white),
                      height: 45,
                      child: TextField(
                        controller: _numberController,
                        keyboardType: TextInputType.phone,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: '+7(___)-___-____',
                            hintStyle: TextStyle(color: Colors.black38),
                            contentPadding: EdgeInsets.all(10.0)),
                      ),
                    ),
                    const SizedBox(height: 35),
                    GestureDetector(
                      onTap: () {
                        //print(_numberController.text);
                        context.push("/login/otp/${_numberController.text}");
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.orange, width: 3),
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.white),
                        child: const Center(
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              'Далее',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 22,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: TextButton(
                        child: Text('Нужна помощь?'),
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.orange,
                          textStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return _buildHelpBottomSheet();
                            },
                            barrierColor: Colors.transparent,
                            backgroundColor: Colors.white,
                            elevation: 0,
                            isDismissible: true,
                            enableDrag: true,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildHelpBottomSheet(){
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Помощь",
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            IconButton(
              onPressed: () {
                context.pop();
              },
              icon: const Icon(
                Icons.keyboard_arrow_down,
                size: 32,
              ),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
          child: Column(
            children: [
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Описание",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      "Lorem ipsum dolor siggrtgtrgg gtgtg t tgt gtg  tgtg tg tg tg tg tg tgtg tg rfersc  amet consectetur. Nisi pretium quam et vel imperdiet lorem. In adipiscing elit enim pellentesque id malesuada Lorem ipsum dolor siggrtgtrgg gtgtg t tgt gtg  tgtg tg tg tg tg tg tgtg tg rfersc  amet consectetur. Nisi pretium quam et vel imperdiet lorem. In adipiscing elit enim pellentesque id malesuada eleifend viverra.",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black.withOpacity(0.8),
                      ),
                      overflow: TextOverflow.clip,
                    ),
                  ),
                ],
              ),
              Divider(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Контакты",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      "Lorem ipsum dolor sit amet consectetur Nisi pretium quam Nisi pretium quam Nisi pretium quam Nisi pretium quam Nisi pretium quam . Nisi pretium quam et vel imperdiet lorem. In adipiscing elit enim pellentesque id malesuada eleifend viverra.",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black.withOpacity(0.8),
                      ),
                      overflow: TextOverflow.clip,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

}
