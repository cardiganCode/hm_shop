import 'package:flutter/material.dart';
import 'package:hm_shop/pages/Cart/index.dart';
import 'package:hm_shop/pages/Category/index.dart';
import 'package:hm_shop/pages/Home/index.dart';
import 'package:hm_shop/pages/Mine/index.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // Render the navigator based on the data.
  // Normally, the app's navigator dosen't change.
  // ignore: unused_field
  final List<Map<String, String>> _tabList = [
    {
      "icon": "lib/assets/ic_public_home_normal.png", // display normally
      "active": "lib/assets/ic_public_home_active.png", // active icon
      "text": "首页",
    },
    {
      "icon": "lib/assets/ic_public_pro_normal.png", // display normally
      "active": "lib/assets/ic_public_pro_active.png", // active icon
      "text": "分类",
    },
    {
      "icon": "lib/assets/ic_public_cart_normal.png", // display normally
      "active": "lib/assets/ic_public_cart_active.png", // active icon
      "text": "购物车",
    },
    {
      "icon": "lib/assets/ic_public_my_normal.png", // display normally
      "active": "lib/assets/ic_public_my_active.png", // active icon
      "text": "我的",
    },
  ];

  int _currentIndex = 0;

  List<BottomNavigationBarItem> _getTabBarWidget() {
    return List.generate(_tabList.length, (index) {
      return BottomNavigationBarItem(
        icon: Image.asset(_tabList[index]["icon"]!, width: 30, height: 30),
        activeIcon: Image.asset(
          _tabList[index]["active"]!,
          width: 30,
          height: 30,
        ),
        label: _tabList[index]["text"],
      );
    });
  }

  List<Widget> _getChildren() {
    return [HomeView(), CategoryView(), CartView(), MineView()];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // "SafeArea can avoid safe area"
      body: SafeArea(
        child: IndexedStack(index: _currentIndex, children: _getChildren()),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: _getTabBarWidget(),
        currentIndex: _currentIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black54,
        showUnselectedLabels: true,
        onTap: (value) {
          _currentIndex = value;
          setState(() {});
        },
      ),
    );
  }
}
