import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:dio/dio.dart' as d;


import '../../services/http_service.dart';
import '../../widgets/app_bar.dart';

class ForgetPasswordScreen extends StatefulWidget {
  static String routeName = './ForgetPasswordScreen';

  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {

  final _formKey = GlobalKey<FormState>();

  bool changeButton = false;
  String email = '';

  _resetPassword(BuildContext context) async {
    // _loginNow(email: 'api@hinopak.com', password: 'API@212');
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        changeButton = true;
      });
      _forgetPassword(email: '$email');
      await Future.delayed(const Duration(seconds: 4));
      setState(() {
        changeButton = false;
      });
    }
  }

  _forgetPassword({required String email}) async {
    final queryParameters = {
      'email': '$email',
    };
    try {
      final result = "";
      // await httpService.request(url: "api/method/frappe.core.doctype.user.user.reset_password", method: Method.POST, params: queryParameters);
      if (result != null) {
        if (result is d.Response) {
          print('http: $result');
            //Navigate to next screen~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Kindly check email'),
              duration: Duration(seconds: 4),
            ));
          print(result);
        }
      }
    }catch(e){
      // print('Error: '+e.toString());

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Invalid email'),
        duration: Duration(seconds: 4),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(text: 'Forget Password'),
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
                      const SizedBox(
                        height: 20,
                      ),
                      AnimatedContainer(
                        duration: Duration(seconds: 4),
                        height: 50,
                        width: changeButton ? 180 : 220,
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(16)),
                        child: MaterialButton(
                            child: Text(
                              'Reset password',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              _resetPassword(context);
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
    );
  }
}
