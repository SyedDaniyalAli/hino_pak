import 'package:flutter/material.dart';
import 'package:hino_pak/screens/login_screen/login_screen.dart';

import '../../widgets/app_bar.dart';

class Complaint extends StatefulWidget {
  static String routeName = './Complaints';

  const Complaint({Key? key}) : super(key: key);

  @override
  State<Complaint> createState() => _RegistrationState();
}

class _RegistrationState extends State<Complaint> {
  String dropdownValue = 'Sindh';
  final _formKey = GlobalKey<FormState>();
  bool changeButton = false;

  moveToHome(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        changeButton = true;
      });
      Navigator.pushNamed(context, LoginPage.routeName);
      setState(() {
        changeButton = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: customAppBar(text: 'Complain'),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Select your region'),
                            Container(
                              child: DropdownButton<String>(
                                value: dropdownValue,
                                icon: const Icon(Icons.arrow_downward),
                                elevation: 16,
                                style: TextStyle(
                                    color: Theme.of(context).primaryColorDark),
                                underline: Container(
                                  height: 2,
                                  color: Theme.of(context).primaryColor,
                                ),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropdownValue = newValue!;
                                  });
                                },
                                items: <String>[
                                  'Sindh',
                                  'Punjab',
                                  'Balochistan',
                                  'Kpk',
                                  'NWFP'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Select your Complain type'),
                            Container(
                              child: DropdownButton<String>(
                                value: dropdownValue,
                                icon: const Icon(Icons.arrow_downward),
                                elevation: 16,
                                style: TextStyle(
                                    color: Theme.of(context).primaryColorDark),
                                underline: Container(
                                  height: 2,
                                  color: Theme.of(context).primaryColor,
                                ),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropdownValue = newValue!;
                                  });
                                },
                                items: <String>[
                                  'Sindh',
                                  'Punjab',
                                  'Balochistan',
                                  'Kpk',
                                  'NWFP'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                        TextFormField(
                          maxLength: 500,
                          maxLines: 6,
                          minLines: 5,
                          decoration: const InputDecoration(
                            hintText: "Describe your Complain",
                            labelText: "Complain",
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Description cannot be empty";
                            } else if (value.length < 12) {
                              return 'Description length shoulb be atleast 12';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 50,
                          width: 120,
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(16)),
                          child: MaterialButton(
                              child: const Text(
                                'Complain',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {}),
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
