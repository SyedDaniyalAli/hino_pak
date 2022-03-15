import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hino_pak/screens/login_screen/login_screen.dart';

import '../../services/http_service.dart';
import '../../widgets/app_bar.dart';

class Registration extends StatefulWidget {
  static String routeName = './Registration';

  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final _formKey = GlobalKey<FormState>();
  bool changeButton = false;

  String email = '';
  String chassisNumber = '';
  String fullName = '';
  String phone = '';

  moveToLogin(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        changeButton = true;
      });
      try {
        showProgress();
        addUser(
          email: email,
          context: context,
          chassisNumber: chassisNumber,
          fullName: fullName,
          phone: phone,
        ).then((value) => {
              EasyLoading.dismiss(),
              Navigator.pushNamedAndRemoveUntil(
                context,
                LoginPage.routeName,
                (route) => false,
              ),
            });
      } catch (e) {
        EasyLoading.dismiss();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: customAppBar(text: 'Registration'),
        body: SingleChildScrollView(
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 32.0),
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                            hintText: "Enter email",
                            labelText: "Email",
                          ),
                          onSaved: (value) {
                            email = value!;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Email cannot be empty";
                            } else if (!value.contains('@')) {
                              return 'Please enter an valid email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15),
                        TextFormField(
                          decoration: const InputDecoration(
                            hintText: "Please enter Full Name",
                            labelText: "Full name",
                          ),
                          onSaved: (value) {
                            fullName = value!;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Full name cannot be empty";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15),

                        TextFormField(
                          decoration: const InputDecoration(
                            hintText: "Please enter phone number",
                            labelText: "Phone number",
                          ),
                          maxLength: 11,
                          keyboardType: TextInputType.number,
                          onSaved: (value) {
                            phone = value!;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Phone number cannot be empty";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15),
                        TextFormField(
                          decoration: const InputDecoration(
                            hintText: "Please enter Chassis",
                            labelText: "Chassis number",
                          ),
                          maxLength: 17,
                          keyboardType: TextInputType.number,
                          onSaved: (value) {
                            chassisNumber = value!;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Chassis number cannot be empty";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        AnimatedContainer(
                          duration: Duration(seconds: 2),
                          height: 50,
                          width: changeButton ? 120 : 220,
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(16)),
                          child: MaterialButton(
                            child: const Text(
                              'SIGN UP',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () => moveToLogin(context),
                          ),
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

  void showProgress() {
    EasyLoading.show(
      status: 'Loading...',
      indicator: CircularProgressIndicator(),
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.black,
    );
  }
}
