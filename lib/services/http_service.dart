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
      var jsonResponse = convert.jsonDecode(res.body) as Map<String, dynamic>;
      var msg = jsonResponse['message'];
      print('http msg: $msg');
      if (msg == 'Logged In') {
        //Navigate to next screen~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        Navigator.pushNamedAndRemoveUntil(
          context,
          ComplainScreen.routeName,
          (route) => false,
        );
      }
    } else {
      // print("no done");
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
  // print("res: ${res.body}");
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
  // print("res: ${res.body}");
}
