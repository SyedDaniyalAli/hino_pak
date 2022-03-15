import 'package:flutter/material.dart';
import 'package:hino_pak/services/http_service.dart';

import '../../widgets/app_bar.dart';
import '../forget_pwd_screen/forget_pwd_screen.dart';
import '../registration_screen/registration_screen.dart';

class LoginPage extends StatefulWidget {
  static String routeName = './Login';

  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _RegistrationState();
}

class _RegistrationState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool changeButton = false;

  String email = '';
  String password = '';

  _moveToHome(BuildContext context) async {
    // loginNow(email: 'flutter@hp.com', password: 'flutter', context: context);
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        changeButton = true;
      });
      loginNow(email: '$email', password: '$password', context: context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: customAppBar(text: 'Login'),
        body: SingleChildScrollView(
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 45,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 32.0),
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                            hintText: "Please enter email",
                            labelText: "Email",
                          ),
                          onSaved: (value) {
                            email = value!;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Email can not be empty";
                            } else if (!value.contains('@')) {
                              return 'Please enter an valid email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15),
                        TextFormField(
                          maxLength: 10,
                          decoration: const InputDecoration(
                            hintText: "Please enter Password",
                            labelText: "Password",
                          ),
                          onSaved: (value) {
                            password = value!;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Password cannot be empty";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(Registration.routeName);
                              },
                              child: const Text(
                                'Create Account',
                                style: TextStyle(
                                    decoration: TextDecoration.underline),
                              ),
                            ),
                            const SizedBox(height: 15),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(ForgetPasswordScreen.routeName);
                              },
                              child: const Text(
                                'Forgot Password',
                                style: TextStyle(
                                    decoration: TextDecoration.underline),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        AnimatedContainer(
                          duration: Duration(seconds: 4),
                          height: 50,
                          width: changeButton ? 120 : 220,
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(16)),
                          child: MaterialButton(
                              child: const Text(
                                'LOGIN',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                _moveToHome(context);
                              }),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
