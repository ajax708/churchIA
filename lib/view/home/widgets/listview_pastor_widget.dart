import 'package:flutter/material.dart';

class ListViewPastor extends StatelessWidget {
  const ListViewPastor({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) => Padding(
        padding: const EdgeInsets.only(left: 12),
        child: SizedBox(
          width: 150,
          child: Card(
            color: Colors.white,
            elevation: 10,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            child: Card(
              color: Colors.amber,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              child: Stack(
                children: [
                  Positioned(
                      top: 145,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 40, right: 20),
                        child: Text(
                          'Pastor $index',
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
