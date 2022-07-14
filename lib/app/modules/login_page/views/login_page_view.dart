import 'package:char_project/app/data/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../sign_up/views/sign_up_view.dart';
import '../controllers/login_page_controller.dart';

class LoginPageView extends GetView<LoginPageController> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: SizedBox(
                width: 300,
                height: 300,
                child: Center(
                  child: Lottie.asset('assets/lottie/90397-log-in.json'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 15, bottom: 25),
                      child: Container(
                        child: (TextFormField(
                          controller: _emailcontroller,
                          decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.email_outlined,
                                color: Color.fromRGBO(3, 45, 160, 1),
                              ),
                              hintText: 'Enter your  e-mail',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              fillColor: Colors.grey,
                              focusColor: Colors.grey),
                          validator: (value) {
                            if (!RegExp(r'^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$')
                                    .hasMatch(value!) ||
                                value.length < 3) {
                              return 'please enter valid email';
                            } else {
                              return null;
                            }
                          },
                        )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15),
                      child: Container(
                        child: (TextFormField(
                          controller: _passwordcontroller,
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.password,
                                color: Color.fromRGBO(3, 45, 160, 1),
                              ),
                              hintText: 'Password',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              fillColor: Colors.grey,
                              focusColor: Colors.grey),
                        )),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () {
                              Get.to(SignUpView());
                            },
                            child: const Text('Dont have an account?'))
                      ],
                    ),
                    SizedBox(
                      height: 40,
                      width: 150,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            const Color.fromRGBO(3, 45, 160, 1),
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                          ),
                        ),
                        onPressed: () async {
                          // await _homeController.loginFunct(
                          //   email: _emailcontroller.text,
                          //   password: _passwordcontroller.text,
                          // );
                          // if (user != null) {
                          //   Get.off(DataViewView());
                          // }
                        },
                        child: const Text('Login'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        'OR',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    SignInButton(Buttons.Google, onPressed: () {
                      AuthMethods().signInWithGoogle(context);
                    })
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
