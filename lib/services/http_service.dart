import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

import '../screens/complain_screen/complain_screen.dart';

Map<String, String> headers = {};

//For Login ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
loginNow(
    {required String email,
    required String password,
    required BuildContext context}) async {
  final queryParameters = {
    "usr": "$email",
    "pwd": "$password",
  };

  try {
    var res = await http.post(
        Uri.parse("https://hino.thesmarterp.com/api/method/login"),
        body: json.encode(queryParameters),
        headers: {"Content-Type": "application/json"});
    updateCookie(res);
    if (res.statusCode == 200) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        ComplainScreen.routeName,
        (route) => false,
      );
      var jsonResponse = convert.jsonDecode(res.body) as Map<String, dynamic>;
      var msg = jsonResponse['message'];
      print('http msg: $msg');
      if (msg == 'Logged In') {
        //Navigate to next screen~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Invalid credentials'),
        duration: Duration(seconds: 4),
      ));
    }
  } catch (e) {
    print("error: $e");
  }
}

//Updating Cookies~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
updateCookie(http.Response response) {
  String? rawCookie = response.headers['set-cookie'];
  if (rawCookie != null) {
    int index = rawCookie.indexOf(';');
    headers['cookie'] =
        (index == -1) ? rawCookie : rawCookie.substring(0, index);
  }
}

//Getting Regions~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Future<List<dynamic>> getRegions(BuildContext context) async {
  var res = await http.get(
      Uri.parse(
        'https://hino.thesmarterp.com/api/resource/Region',
      ),
      headers: headers);

  if (res.statusCode == 200) {
    print(res.body);
    var jsonResponse = convert.jsonDecode(res.body) as Map<String, dynamic>;
    var data = jsonResponse['data'];
    print(data);
    return data.map((entry) => (entry['name'])).toList();
  } else {
    print(res.body);
    return (["can't load data"]);
  }
}

//Getting Regions~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Future<List<dynamic>> getComplainType(BuildContext context) async {
  var res = await http.get(
      Uri.parse(
        'https://hino.thesmarterp.com/api/resource/Complain Type',
      ),
      headers: headers);

  if (res.statusCode == 200) {
    print(res.body);
    var jsonResponse = convert.jsonDecode(res.body) as Map<String, dynamic>;
    var data = jsonResponse['data'];
    print(data);
    return data.map((entry) => (entry['name'])).toList();
  } else {
    print(res.body);
    return (["can't load data"]);
  }
}

//Getting Complaints~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Future<List> getComplains(BuildContext context) async {
  var res = await http.get(
      Uri.parse(
        'https://hino.thesmarterp.com/api/resource/Complaint?fields=["*"]',
      ),
      headers: headers);

  if (res.statusCode == 200) {
    print(res.body);
    var jsonResponse = convert.jsonDecode(res.body) as Map<String, dynamic>;
    var data = jsonResponse['data'];
    print(data);
    return data;
  } else {
    print(res.body);
    return (["can't load data"]);
  }
}

//Forget Password~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Future forgetPassword(
    {required String email, required BuildContext context}) async {
  final queryParameters = {
    "user": "$email",
  };

  try {
    var res = await http.post(
        Uri.parse(
            "https://hino.thesmarterp.com/api/method/frappe.core.doctype.user.user.reset_password"),
        body: json.encode(queryParameters),
        headers: {"Content-Type": "application/json"});
    // updateCookie(res);
    if (res.statusCode == 200) {
      // var jsonResponse = convert.jsonDecode(res.body) as Map<String, dynamic>;
      // var msg = jsonResponse['message'];
      // print('http msg: $msg');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Kindly check email'),
        duration: Duration(seconds: 4),
      ));
      Navigator.of(context).pop();
      print(res);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Kindly check email'),
        duration: Duration(seconds: 4),
      ));
      Navigator.of(context).pop();
      print('http msg: ${res.body}');
    }
  } catch (e) {
    print("error: $e");
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('No Internet Connection'),
      duration: Duration(seconds: 4),
    ));
    Navigator.of(context).pop();
  }
}

//Add new User~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Future addUser(
    {required String email,
    required String fullName,
    required String phone,
    required String chassisNumber,
    required BuildContext context}) async {
  final queryParameters = {
    "email": "$email",
    "full_name": "$fullName",
    "phone_no": "$phone",
    "chassis_no": "$chassisNumber",
  };

  try {
    var res = await http.post(
        Uri.parse(
            "https://hino.thesmarterp.com/api/method/complaint_management.utils.user.sign_up"),
        body: json.encode(queryParameters),
        headers: {"Content-Type": "application/json"});
    // updateCookie(res);
    if (res.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Registered Successfully'),
        duration: Duration(seconds: 4),
      ));
      print(res);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Can't able to register"),
        duration: Duration(seconds: 4),
      ));
      print('http msg: ${res.body}');
    }
  } catch (e) {
    print("error: $e");
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('No Internet Connection'),
      duration: Duration(seconds: 4),
    ));
  }
}

//Add Complains~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Future sendComplain(
    {required String region,
    required String complainType,
    required String complainDescription,
    required BuildContext context}) async {
  print('Passing values=> $region , $complainType, $complainDescription');

  final queryParameters = {
    "complain_type": "$complainType",
    "region": "$region",
    "description": "$complainDescription",
  };

  try {
    var res = await http.post(
        Uri.parse(
            "https://hino.thesmarterp.com/api/method/complaint_management.utils.complain.post_complain"),
        body: json.encode(queryParameters),
        headers: {"Content-Type": "application/json"});

    // updateCookie(res);
    if (res.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Complaint Successfully'),
        duration: Duration(seconds: 4),
      ));
      print(res);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Can't able to Complaint"),
        duration: Duration(seconds: 4),
      ));
      print('http msg: ${res.body}');
    }
  } catch (e) {
    print("error: $e");
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('No Internet Connection'),
      duration: Duration(seconds: 4),
    ));
  }
}
