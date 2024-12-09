// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:eam_app/pages/about/about_page.dart';
import 'package:eam_app/pages/bengkel/bengkel_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:eam_app/common/constant/colors.dart';
import 'package:eam_app/common/constant/icons.dart';
import 'package:eam_app/pages/home/home_page.dart';
import 'package:eam_app/pages/sparepart/sparepart_page.dart';

class NavigationPage extends StatefulWidget {
  final int index;
  const NavigationPage({
    super.key,
    this.index = 0,
  });

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  final PageController _pageController = PageController();
  int _pageIndex = 0;
  late List<Widget> _screens = [];
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();

  bool singleVendor = false;

  String token = '';
  @override
  void initState() {
    super.initState();
    setState(() {
      _pageIndex = widget.index;
    });
    _screens = [
      HomePage(),
      SparepartPage(),
      BengkelPage(),
      AboutPage(),
    ];
  }

  Widget body() {
    switch (_pageIndex) {
      case 0:
        return HomePage();
      case 1:
        return SparepartPage();
      case 2:
        return BengkelPage();
      case 3:
        return AboutPage();
      default:
        return HomePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text(token)),
      key: _scaffoldKey,
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Theme.of(context).textTheme.bodyLarge!.color,
        showUnselectedLabels: true,
        currentIndex: _pageIndex,
        type: BottomNavigationBarType.fixed,
        items: _getBottomWidget(singleVendor),
        onTap: (int index) {
          _setPage(index);
        },
      ),
      body: body(),
    );
  }

  void _setPage(int pageIndex) {
    setState(() {
      _pageIndex = pageIndex;
    });
  }

  BottomNavigationBarItem _barItem(String icon, String? label, int index) {
    return BottomNavigationBarItem(
      icon: Container(
        width: 50,
        height: 50,
        padding: EdgeInsets.all(10),
        child: SvgPicture.asset(
          icon,
          color: index == _pageIndex ? ColorName.green : ColorName.grey,
          height: 30,
          width: 30,
        ),
      ),
      label: label,
    );
  }

  List<BottomNavigationBarItem> _getBottomWidget(bool isSingleVendor) {
    List<BottomNavigationBarItem> list = [];
    list.add(_barItem(IconName.home, 'Beranda', 0));
    list.add(_barItem(IconName.shop, 'Produk', 1));
    list.add(_barItem(IconName.bengkel, 'Bengkel', 2));
    list.add(_barItem(IconName.user, 'User', 3));
    return list;
  }
}
