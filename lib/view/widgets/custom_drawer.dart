import 'package:flutter/material.dart';
import 'package:relevans_app/bussiness/event_links.dart';

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
                "Church AI",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            accountEmail: Text(
              "lcueva@examen.com",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home, color: Colors.blue, size: 30),
            title: Text(
              'Inicio',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            leading: Icon(Icons.event, color: Colors.amber, size: 30),
            title: Text(
              'Eventos Admin',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.amber),
            ),
            onTap: () {
              EventLink eventLink = EventLink();
              eventLink.eventAdminPage(context);
            },
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
