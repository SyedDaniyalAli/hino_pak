import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hino_pak/screens/add_complain_screen/add_complain_screen.dart';
import 'package:hino_pak/widgets/app_bar.dart';

import '../../services/http_service.dart';
import 'components/status_card.dart';

class ComplainScreen extends StatefulWidget {
  static String routeName = './Complains';

  const ComplainScreen({Key? key}) : super(key: key);

  @override
  State<ComplainScreen> createState() => _ComplainScreenState();
}

class _ComplainScreenState extends State<ComplainScreen> {
  List<Map<String, dynamic>> listOfComplaints = [];

  @override
  void initState() {
    super.initState();
    showProgress();
    loadData();
  }

  loadData() {
    listOfComplaints.clear();
    getComplains(context)
        .then(
          (value) => value.forEach((element) {
            setState(() {
              listOfComplaints.add(element);
            });
          }),
        )
        .then((value) => EasyLoading.dismiss());
  }

  // Show Alert Dialog
  void _showDialog(
      {required String status,
      required String complainType,
      required String responseDetail,
      required String resolutionDetail,
      required BuildContext context}) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Complaint Details"),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Status: " + status + "\n",
            ),
            Text("Complaint Type: \n" + complainType + "\n"),
            Text("First Responded On: \n" + responseDetail + "\n"),
            Text("Resolution Detail: \n" + resolutionDetail + "\n"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Okay'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        EasyLoading.showToast('Refreshing...');
        return Future.delayed(
          Duration(seconds: 1),
          () {
            loadData();
          },
        ).whenComplete(
          () => EasyLoading.showToast('Refreshed'),
        );
      },
      child: Scaffold(
        appBar: customAppBar(text: 'Complaints'),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              child: Column(
                children: [
                  ...listOfComplaints.map(
                    (e) => GestureDetector(
                      onTap: () => {
                        _showDialog(
                          context: context,
                          status: e['status'].toString(),
                          complainType: e['complain_type'].toString(),
                          responseDetail:
                              e['first_responded_on'].toString() == 'null'
                                  ? 'No Record'
                                  : e['first_responded_on'].toString(),
                          resolutionDetail:
                              e['resolutionDetails'].toString() == 'null'
                                  ? 'No Record'
                                  : e['resolutionDetails'].toString(),
                        ),
                      },
                      child: StatusCard(
                        complaintType: e['complain_type'],
                        complain_status: e['status'],
                      ),
                    ),
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
