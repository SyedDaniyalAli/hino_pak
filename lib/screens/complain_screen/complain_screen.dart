import 'package:flutter/material.dart';
import 'package:hino_pak/widgets/app_bar.dart';

class ComplainScreen extends StatelessWidget {

  static String routeName = './Complains';
  const ComplainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(text: 'Complains'),
    );
  }
}
