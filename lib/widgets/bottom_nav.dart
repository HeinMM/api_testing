import 'package:api_testing/screen/home.dart';
import 'package:api_testing/screen/setting_screen.dart';
import 'package:api_testing/screen/upload_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _currentIndex = 0;
  Widget _body = Home();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items:  [
          BottomNavigationBarItem(icon:const Icon(Icons.home), label: 'home'.tr),
          BottomNavigationBarItem(icon:const Icon(Icons.add), label: 'upload'.tr),
          BottomNavigationBarItem(icon:const Icon(Icons.settings), label: 'setting'.tr),
        ],
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
            if (index == 0) {
              _body = Home();
            }
            if (index == 1) {
              _body = const UploadScreen();
            }
            if (index == 2) {
              _body = const Setting();
            }
          });
        },
      ),
    );
  }
}
