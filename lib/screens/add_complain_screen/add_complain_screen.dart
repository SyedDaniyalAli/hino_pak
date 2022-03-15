import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';



import '../../services/http_service.dart';
import '../../widgets/app_bar.dart';

class AddComplainScreen extends StatefulWidget {
  static String routeName = './addComplains';

  const AddComplainScreen({Key? key}) : super(key: key);

  @override
  State<AddComplainScreen> createState() => _RegistrationState();
}

class _RegistrationState extends State<AddComplainScreen> {
  String _selected_region = '';
  String _selected_complain_type = '';
  String _complain_desc = '';

  List<String> _complain_type_list = <String>[''];

  List<String> _regions_list = <String>[''];

  final _formKey = GlobalKey<FormState>();
  bool changeButton = false;

  _trySubmit(BuildContext context) async {

    if (_selected_region == '') {
      EasyLoading.showToast("Select region");
      return;
    }
    if (_selected_complain_type == '') {
      EasyLoading.showToast("Select complain type");
      return;
    }

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      setState(() {
        changeButton = true;
      });
      try {
        showProgress();
        sendComplain(
          region: _selected_region,
          complainType: _selected_complain_type,
          complainDescription: _complain_desc,
          context: context,
        ).then(
          (value) => EasyLoading.dismiss(),
        );
      } catch (e) {
        print("Error: " + e.toString());
        EasyLoading.dismiss();
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    showProgress();

    getRegions(context)
        .then((value) => value.forEach((element) {
              setState(() {
                _regions_list.add(element.toString());
              });
            }))
        .then((value) => EasyLoading.dismiss());

    getComplainType(context)
        .then((value) => value.forEach((element) {
              setState(() {
                _complain_type_list.add(element.toString());
              });
            }))
        .then((value) => EasyLoading.dismiss());
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: customAppBar(text: 'Complain'),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 32.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Select your region'),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        width: double.infinity,
                        child: DropdownButton<String>(
                          value: _selected_region,
                          icon: const Icon(Icons.arrow_downward),
                          dropdownColor: Colors.white,
                          elevation: 2,
                          isExpanded: true,
                          style: TextStyle(
                              color: Theme.of(context).primaryColorDark),
                          underline: Container(
                            height: 2,
                            color: Theme.of(context).primaryColor,
                          ),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selected_region = newValue!;
                            });
                          },
                          items: _regions_list
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(
                        height: 28,
                      ),
                      const Text('Select your Complain type'),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        width: double.infinity,
                        child: DropdownButton<String>(
                          value: _selected_complain_type,
                          icon: const Icon(Icons.arrow_downward),
                          dropdownColor: Colors.white,
                          elevation: 2,
                          style: TextStyle(
                              color: Theme.of(context).primaryColorDark),
                          isExpanded: true,
                          underline: Container(
                            height: 2,
                            color: Theme.of(context).primaryColor,
                          ),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selected_complain_type = newValue!;
                            });
                          },
                          items: _complain_type_list
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        maxLength: 500,
                        maxLines: 6,
                        textAlign: TextAlign.center,
                        minLines: 5,
                        decoration: const InputDecoration(
                          hintText: "Describe your Complain",
                          labelText: "Complain Description",
                          alignLabelWithHint: true,
                        ),
                        onSaved: (value) {
                          _complain_desc = value!;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Description cannot be empty";
                          } else if (value.length < 12) {
                            return 'Description length should be at least 12';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
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
                              'Complain',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              _trySubmit(context);
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

  void showProgress() {
    EasyLoading.show(
      status: 'Loading...',
      indicator: CircularProgressIndicator(),
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.black,
    );
  }
}
