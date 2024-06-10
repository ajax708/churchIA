import 'package:flutter/material.dart';
import 'package:relevans_app/utils/custom_icons.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String type;

  const CustomAppBar({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    var builder, action;

    //Las acciones reflejadas en el appbar de las diferentes vistas se reflejan aqui
    switch (type) {
      case 'home-view':
        builder = Builder(
            builder: (context) => IconButton(
                onPressed: () {

                  Scaffold.of(context).openDrawer();
                },
                icon: const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Icon(Icons.apps)),
                iconSize: 48,
                color: Colors.black));
        action = <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 20, right: 20),
            child: IconButton(
                onPressed: () {},
                icon: const Icon(CustomIcons.music),
                iconSize: 38,
                color: Colors.black),
          )
        ];
        break;
      case 'page-view':
        builder = Builder(
            builder: (context) => IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Icon(Icons.arrow_back_ios_new)),
                iconSize: 38,
                color: Colors.black));
        action = <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 20, right: 20),
            child: IconButton(
                onPressed: () {},
                icon: const Icon(CustomIcons.music),
                iconSize: 38,
                color: Colors.black),
          )
        ];
        break;
      case 'register-view':
        builder = Builder(
            builder: (context) => IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Icon(Icons.arrow_back_ios_new)),
                iconSize: 38,
                color: Colors.black));
        break;
      default:
    }

    return AppBar(
      title: const Padding(
          padding: EdgeInsets.only(top: 30),
          child: Text(
            'RELEVANS',
            style: TextStyle(
                color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
          )),
      centerTitle: true,
      toolbarHeight: 65,
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      elevation: 4,
      shadowColor: const Color.fromARGB(255, 184, 184, 184),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(55), bottomLeft: Radius.circular(55)),
      ),
      leading: builder,
      actions: action,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size(double.maxFinite, 70);
}
