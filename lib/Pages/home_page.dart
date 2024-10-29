import 'package:flutter/material.dart';
import 'package:footware_admin/Pages/product_management_page.dart';
import 'package:footware_admin/Pages/user_management_page.dart';

import 'package:get/get.dart';

import 'order_manager_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    ProductManagementPage(), // Quản lý sản phẩm
    UserManagementPage(),    // Quản lý người dùng
    OrderManagementPage(),   // Quản lý đơn hàng
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory),
            label: 'Sản phẩm',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Người dùng',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Đơn hàng',
          ),
        ],
      ),
    );
  }

  String _getTitle(int index) {
    switch (index) {
      case 0:
        return 'Quản lý sản phẩm';
      case 1:
        return 'Quản lý người dùng';
      case 2:
        return 'Quản lý đơn hàng';
      default:
        return '';
    }
  }
}
