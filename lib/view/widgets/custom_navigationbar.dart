import 'package:flutter/material.dart';
import 'package:relevans_app/utils/custom_icons.dart';

class CustomNavigationBar extends StatelessWidget {
  final int currentPage;
  const CustomNavigationBar({super.key, required this.currentPage});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25), topRight: Radius.circular(25)),
      child: BottomNavigationBar(
          backgroundColor: Colors.black,
          elevation: 10,
          selectedItemColor: const Color.fromARGB(255, 236, 185, 55),
          unselectedItemColor: Colors.white,
          iconSize: 30,
          currentIndex: currentPage,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            switch (index) {
              case 0:
                Navigator.pushNamed(context, "/");
                break;
              case 1:
                Navigator.pushNamed(context, "/event_church");
                break;
              case 2:
                Navigator.pushNamed(context, "/alabanza");
                break;
              case 3:
                Navigator.pushNamed(context, "/");
                break;
            }
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Inicio"),
            BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today), label: "Calendario"),
            BottomNavigationBarItem(
                icon: Icon(CustomIcons.music), label: "Alabanza"),
            BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: "Más")
          ]),
    );
  }
}
