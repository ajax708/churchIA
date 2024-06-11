import 'package:flutter/material.dart';
import 'package:relevans_app/utils/custom_icons.dart';
import 'package:relevans_app/bussiness/home_links.dart';

class AppbarHome extends StatelessWidget implements PreferredSizeWidget {
  const AppbarHome({Key? key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Padding(
        padding: EdgeInsets.only(top: 30),
        child: Text(
          "Church AI",
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      centerTitle: true,
      toolbarHeight: 65,
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      elevation: 4,
      shadowColor: const Color.fromARGB(255, 184, 184, 184),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(55),
          bottomLeft: Radius.circular(55),
        ),
      ),
      leading: Builder(
        builder: (context) => IconButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          icon: const Padding(
            padding: EdgeInsets.only(left: 10),
            child: Icon(Icons.apps),
          ),
          iconSize: 48,
          color: Colors.black,
        ),
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 20, right: 20),
          child: IconButton(
            onPressed: () {
              // Inicializamos homeLink antes de usarlo
              HomeLink homeLink = HomeLink();
              homeLink.alabanzaPage(context);
            },
            icon: const Icon(CustomIcons.music),
            iconSize: 38,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size(double.maxFinite, 70);
}
