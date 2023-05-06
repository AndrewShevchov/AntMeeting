import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:stream/screens/account_screen.dart';
import 'package:stream/screens/feed_screen.dart';
import 'package:stream/screens/go_live_screen.dart';
import 'package:stream/screens/login_screen.dart';
import 'package:stream/screens/onboarding_screen.dart';
import 'package:stream/screens/task_screen.dart';
import 'package:stream/utils/colors.dart';
import 'package:stream/widgets/theme_sevices.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _page = 0;
  List<Widget> pages = [
    const FeedScreen(),
    const GoLiveScreen(),
    const TaskScreen(),
  ];

  onPageChange(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBar,
        title: Row(
          children: [
            IconButton(
              onPressed: () {
                ThemeService().switchTheme();
              },
              icon: Icon(
                Icons.nightlight_round,
                color: (user == null) ? Colors.white : Colors.white,
              ),
            ),
            const SizedBox(
                width: 10), // Добавляем отступ между иконкой и текстом
            const Text(
              'AntMeeting',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              if ((user == null)) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const OnboardingScreen()),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AccountScreen()),
                );
              }
            },
            icon: Icon(
              Icons.person,
              color: (user == null) ? Colors.white : Colors.white,
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedFontSize: 12,
        onTap: onPageChange,
        currentIndex: _page,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.broadcast_on_home,
            ),
            label: 'Домашняя',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_rounded,
            ),
            label: 'Встреча',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.copy,
            ),
            label: 'Планы',
          ),
        ],
      ),
      body: pages[_page],
    );
  }
}
