import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'otp_page.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class PhoneAuthPage extends StatefulWidget {
  const PhoneAuthPage({super.key});

  @override
  State<PhoneAuthPage> createState() => _PhoneAuthPageState();
}

class _PhoneAuthPageState extends State<PhoneAuthPage> {
  var maskFormatter = MaskTextInputFormatter(
      mask: '+# (###) ###-##-##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);
  final _numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 0, bottom: 0),
            child: Row(children: [
              Image(
                  width: 150,
                  height: 150,
                  image: AssetImage('assets/img/ic.png')),
            ]),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 50, bottom: 10),
            child: Text(
              "EBin Store",
              style: TextStyle(fontSize: 36),
            ),
          ),
          const Text(
            "Введите свой номер телефона",
            style: TextStyle(fontSize: 16),
          ),
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(40.0, 70.0, 40.0, 0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black38,
                              blurRadius: 25.0,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(9),
                          color: Colors.white),
                      height: 45,
                      child: TextField(
                        inputFormatters: [maskFormatter],
                        controller: _numberController,
                        keyboardType: TextInputType.phone,
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: '+7(___)-___-____',
                            hintStyle: TextStyle(color: Colors.black38),
                            contentPadding: EdgeInsets.all(10.0)),
                      ),
                    ),
                    const SizedBox(height: 35),
                    GestureDetector(
                      onTap: () {
                        if (_numberController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: Colors.white,
                              closeIconColor: Colors.black,
                              duration: Duration(seconds: 2),
                              showCloseIcon: true,
                              content: Text("Введите номер телефона",
                                  style:  TextStyle(
                                      fontSize: 18, color: Colors.black)),
                            ),
                          );
                        } else if (maskFormatter.getUnmaskedText().length !=
                            11) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: Colors.white,
                              closeIconColor: Colors.black,
                              duration: Duration(seconds: 2),
                              showCloseIcon: true,
                              content: Text("Введите правльный номер телефона",
                                  style:  TextStyle(
                                      fontSize: 18, color: Colors.black)),
                            ),
                          );
                        } else {
                          context.push(
                              "/login/otp/+${maskFormatter.getUnmaskedText()}");
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.orange, width: 3),
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
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.orange,
                          textStyle: const TextStyle(
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
                        child:   const Text('Нужна помощь?'),
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

  Widget _buildHelpBottomSheet() {
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
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
          child: Column(
            children: [
              const SizedBox(height: 15),
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
              const SizedBox(height: 10),
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
              const Divider(height: 40),
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
              const SizedBox(height: 10),
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
