import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class GalleryWidget extends StatelessWidget {
  final List<String> images = [
    'assets/images/1.jpeg',
    '2.jpeg'

  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            'העבודה שלנו',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          CarouselSlider(
            options: CarouselOptions(
              height: 400,
              autoPlay: true,
              enlargeCenterPage: true,
            ),
            items: images.map((assetPath) {
              return Container(
                margin: EdgeInsets.all(5.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child: Image.asset(
                    assetPath,
                    fit: BoxFit.cover,
                    width: 1000.0,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}