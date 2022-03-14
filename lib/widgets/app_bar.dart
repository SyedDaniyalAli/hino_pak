import 'package:flutter/material.dart';

PreferredSizeWidget customAppBar({required String text}) {
  return AppBar(
      elevation: 0,
      toolbarHeight: 160,
      centerTitle: true,
      title: Column(
        children: [
          Image.asset(
            "assets/images/hino.jpeg",
            height: 40,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
  );
}