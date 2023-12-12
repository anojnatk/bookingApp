import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ImageSlider extends StatefulWidget {
  @override
  _ImageSliderState createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  final List<String> imgList = [
    'https://firebasestorage.googleapis.com/v0/b/datetify-ee815.appspot.com/o/barber_house_fraunhofer.jpg?alt=media&token=cc7ddd53-9ed6-472b-acb8-8cff0919e982',
'https://firebasestorage.googleapis.com/v0/b/datetify-ee815.appspot.com/o/barber-shops-quer.jpg?alt=media&token=ec6b4c34-8a1c-4fd1-aad1-559ecd76823e', 
'https://firebasestorage.googleapis.com/v0/b/datetify-ee815.appspot.com/o/large_62712790b67ac3de5d2c34f1_762d8af5f3a402529ffa93e4c446f6a3131c163934972b90b79fe4e66ee0d29c_627128b3.jpg?alt=media&token=a458c49d-17c0-47c5-9125-7cc903b18077'

  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          height: size.height * 0.35,
          width: size.width,
          child: CarouselSlider(
            carouselController: _controller,
            options: CarouselOptions(
              height: 400.0,
              enlargeCenterPage: true,
              initialPage: 0,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              },
            ),
            items: imgList.map((i) {
              return Builder(
                builder: (BuildContext context,) {
                  return Container(
                    width: MediaQuery.of(context).size.width,

                    // margin: EdgeInsets.symmetric(horizontal: 0.0),
                    // decoration: BoxDecoration(color: Colors.amber),
                    child: Image.network(imgList[1]),
                  );
                },
              );
            }).toList(),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: imgList.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: Container(
                width: 7.0,
                height: 7.0,
                margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 5.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black)
                        .withOpacity(_current == entry.key ? 0.9 : 0.4)),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
