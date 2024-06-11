import 'package:flutter/material.dart';

import 'package:relevans_app/utils/custom_icons.dart';

class MoreActivitiesView extends StatefulWidget {
  const MoreActivitiesView({super.key});

  @override
  State<MoreActivitiesView> createState() => _MoreActivitiesViewState();
}

class _MoreActivitiesViewState extends State<MoreActivitiesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Church AI",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 3, 63, 193),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50)),
        ),
        elevation: 10,
        actions: <Widget>[
          IconButton(onPressed: () {}, icon: const Icon(CustomIcons.music))
        ],
      ),
      body: Column(),
    );
  }
}
