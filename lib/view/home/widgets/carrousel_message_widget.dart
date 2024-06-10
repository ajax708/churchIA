import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CarrouselMessage extends StatelessWidget {
  final List<String> listTitle;
  final List<String> listDescription;

  const CarrouselMessage({
    Key? key, // Añadimos el parámetro key
    required this.listTitle,
    required this.listDescription,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: [1, 2, 3].map((i) {
        return SizedBox(
          width: 300,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 60, left: 12, right: 12),
              child: Column(
                children: [
                  Text(
                    listTitle[i - 1],
                    style: const TextStyle(
                      fontSize: 28,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      listDescription[i - 1],
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
      options: CarouselOptions(height: 350),
    );
  }
}
