import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'feature/home/presentation/view/home_view.dart';
import 'feature/likes/presentation/view/likes_view.dart';
import 'feature/notification/presentation/view/notification_view.dart';
import 'feature/profile/presentation/view/profile_view.dart';
import 'feature/search/presentation/view/search_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FINAL',
      theme: ThemeData(useMaterial3: true),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final RxInt currentIndex = 0.obs;

    final pages = [
      const HomePage(),
      const SearchPage(),
      const LikesPage(),
      const NotificationsPage(),
      ProfilePage(),
    ];

    return Obx(
      () => Scaffold(
        body: pages[currentIndex.value],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex.value,
          onTap: (index) => currentIndex.value = index,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.blueAccent,
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
            BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Likes'),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: 'Notifications',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}
