import 'package:flutter/material.dart';

class StatusCard extends StatelessWidget {
  final String complaintType, complain_status;

  const StatusCard({
    Key? key,
    required this.complaintType,
    required this.complain_status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 12,
      child: ListTile(
        title: Text(complaintType),
        trailing: Container(
          width: 120,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(complain_status),
              SizedBox(
                width: 12,
              ),
              Container(
                height: 12,
                width: 12,
                decoration: BoxDecoration(
                  color: complain_status == "Resolved"
                      ? Colors.green
                      : complain_status == "Pending"
                          ? Colors.yellow
                          : Colors.red,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
