import 'package:flutter/material.dart';
import 'package:hino_pak/screens/add_complain_screen/add_complain_screen.dart';
import 'package:hino_pak/widgets/app_bar.dart';

import 'components/status_card.dart';

class ComplainScreen extends StatelessWidget {
  static String routeName = './Complains';

  const ComplainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(text: 'Complains'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                StatusCard(
                  complaintType: 'Breaks',
                  complain_status: 'Completed',
                ),
                StatusCard(
                  complaintType: 'Breaks',
                  complain_status: 'Pending',
                ),
                StatusCard(
                  complaintType: 'Breaks',
                  complain_status: 'Rejected',
                ),
                StatusCard(
                  complaintType: 'Breaks',
                  complain_status: 'Completed',
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed(AddComplainScreen.routeName);
        },
      ),
    );
  }
}
