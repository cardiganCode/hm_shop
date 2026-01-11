import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hm_shop/viewmodels/home.dart';

class HmSlider extends StatefulWidget {
  final List<BannerItem> BannerList;
  HmSlider({Key? key, required this.BannerList}) : super(key: key);

  @override
  _HmSliderState createState() => _HmSliderState();
}

class _HmSliderState extends State<HmSlider> {
  CarouselSliderController _sliderController = CarouselSliderController();
  int _sliderIndex = 0;

  Widget _getSlider() {
    final double ScreenWidth = MediaQuery.of(context).size.width;

    return CarouselSlider(
      carouselController: _sliderController,
      items: List.generate(widget.BannerList.length, (index) {
        return Image.network(
          widget.BannerList[index].imgUrl,
          fit: BoxFit.cover,
          width: ScreenWidth,
        );
      }),
      options: CarouselOptions(
        viewportFraction: 1,
        autoPlay: true,
        height: 260,
        autoPlayInterval: Duration(seconds: 3),
        onPageChanged: (index, reason) {
          _sliderIndex = index;
          setState(() {});
        },
      ),
    );
  }

  Widget _getSearch() {
    return Positioned(
      top: 10,
      left: 0,
      right: 0,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                // ignore: deprecated_member_use
                color: Colors.white.withOpacity(0.2), // 极低的透明度
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  // ignore: deprecated_member_use
                  color: Colors.white.withOpacity(0.3),
                ), // 细边框增加精致感
              ),
              child: TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "搜索...",
                  hintStyle: TextStyle(color: Colors.white70),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _getDots() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 10,
      child: SizedBox(
        height: 20,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10,
          children: List.generate(widget.BannerList.length, (index) {
            return GestureDetector(
              onTap: () {
                _sliderController.animateToPage(
                  index,
                  curve: Curves.linearToEaseOut,
                );
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 200),
                height: 6,
                width: index == _sliderIndex ? 40 : 20,
                decoration: BoxDecoration(
                  color: index == _sliderIndex
                      ? Colors.white
                      : Color.fromARGB(150, 255, 255, 255),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [_getSlider(), _getSearch(), _getDots()]);
  }
}
