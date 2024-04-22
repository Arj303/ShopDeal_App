import 'package:buyrent/providers/profile_providers.dart';
import 'package:buyrent/screens/profile_pages/ProfilePage.dart';
import 'package:buyrent/screens/feed_pages/buypage.dart';
import 'package:buyrent/screens/chat_pages/chatpage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  int _currentIndex = 0;


  final List<Widget> _screens = [
    const BuyPage(),
    const ChatPage(),
    const ProfilePage(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:
      _screens[_currentIndex] ,
      bottomNavigationBar: BottomNavigationBar(

        items: const <BottomNavigationBarItem>[



          BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
          ),


          BottomNavigationBarItem(
          icon: Icon(Icons.message),
          label: 'Request',
          ),


          BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
          ),

        ],
        currentIndex: _currentIndex,
        selectedItemColor: Colors.blue,
        onTap: _onTabTapped,
      ),
    );
  }
}



