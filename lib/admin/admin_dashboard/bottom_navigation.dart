import 'package:cosme/admin/admin_dashboard/dashboard.dart';
import 'package:cosme/utils/color.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetoption = <Widget>[
    AdminDashboard(),
    const Text('Catogries'),
    const Text('Item'),
    const Text('Payment'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetoption[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        elevation: 10,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
              color: AppColor.mainColor,
            ),
            activeIcon: Icon(Icons.home_filled, color: Colors.deepOrange),
            label: "Home",
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.category_outlined,
                color: AppColor.mainColor,
              ),
              activeIcon: Icon(
                Icons.category,
                color: AppColor.mainColor,
              ),
              label: "catogories"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.production_quantity_limits,
                color: AppColor.mainColor,
              ),
              activeIcon: Icon(
                Icons.production_quantity_limits,
                color: AppColor.mainColor,
              ),
              label: "product"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
                color: AppColor.mainColor,
              ),
              activeIcon: Icon(
                Icons.home_filled,
                color: AppColor.mainColor,
              ),
              label: "e"),
        ],
      ),
    );
  }
}
