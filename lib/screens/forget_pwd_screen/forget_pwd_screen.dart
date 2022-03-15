import 'package:flutter/material.dart';


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
      forgetPassword(email: '$email', context: context);
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
                        height: 28,
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
