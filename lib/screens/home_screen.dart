import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uas_43a87006190362/screens/product_screen.dart';
import 'package:uas_43a87006190362/screens/profile_screen.dart';
import 'package:uas_43a87006190362/screens/food_screen.dart';

class HomeScreen extends StatelessWidget {
  final List<Widget> screens = [
    ProductScreens(),
    FoodScreens(),
    ProfileScreen()
  ];

  var selectedIndex = 0.obs;
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Bottom Navigation',
        home: Obx(() => Scaffold(
              // appBar: AppBar(
              //   title: const Text('Bottom Navigation'),
              // ),
              body: screens[selectedIndex.value],
              bottomNavigationBar: BottomNavigationBar(
                  currentIndex: selectedIndex.value,
                  onTap: (index) {
                    selectedIndex.value = index;
                  },
                  items: const [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home), label: 'Home'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.menu_book_sharp), label: 'Food'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.person), label: 'Profile'),
                  ]),
            )));
  }
}
