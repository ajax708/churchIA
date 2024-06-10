import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          const UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Color.fromARGB(255, 10, 10, 10),
                Color.fromARGB(255, 255, 255, 255)
              ]),
            ),
            accountName: Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                "RELEVANS",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            accountEmail: Text(
              "",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          Transform.translate(
            offset: const Offset(0, -10),
            child: Container(height: 700, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
