import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:fen_timer/pages/login.dart';
// import 'package:fen_timer/pages/main_screen.dart';
import 'package:fen_timer/pages/account_screen.dart';
// import 'package:fen_timer/pages/setting_screen.dart';
import 'package:fen_timer/pages/clock/clock_page.dart';
import 'package:fen_timer/pages/stopwatch/stop_watch_page.dart';
import 'package:flutter/cupertino.dart';

class Home extends StatefulWidget {
  final User user;
  final GoogleSignIn googleSignIn;

  const Home({Key? key, required this.user, required this.googleSignIn})
      : super(key: key);
  // const Home({Key? key}): super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentMenuIndex = 0;

  void onMenuItemSelected(int index) {
    setState(() {
      currentMenuIndex = index;
    });
  }

  Future<void> _handleSignOut(BuildContext context) async {
    // sign out from Firebase Authentication
    await FirebaseAuth.instance.signOut();
    // sign out from Google Sign-In
    // await widget.googleSignIn.signOut();
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return const Login();
    }), (r) {
      return false;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> screen = [
      // SizedBox(
      //   width: double.infinity,
      //   child: MainScreen(user: widget.user,googleSignIn:widget.googleSignIn),
      // ),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        child: const ClockPage(),

      ),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        child: const StopWatchPage(),

      ),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        child: AccountScreen(user: widget.user,googleSignIn:widget.googleSignIn),
        // child: const SettingScreen(),
      ),
    ];
    
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Welcome ${widget.user.displayName ?? ''}'),
      // ),
      body: screen.elementAt(currentMenuIndex),
      // body: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[
      //       if (widget.user.photoURL != null)
      //         CircleAvatar(
      //           radius: 50.0,
      //           backgroundImage: NetworkImage(widget.user.photoURL!),
      //         ),
      //       SizedBox(height: 8.0),
      //       Text(
      //         'Name: ${widget.user.displayName ?? ''}',
      //         style: TextStyle(fontSize: 18.0),
      //       ),
      //       SizedBox(height: 8.0),
      //       Text(
      //         'Email: ${widget.user.email}',
      //         style: TextStyle(fontSize: 18.0),
      //       ),
      //       SizedBox(height: 24.0),
      //       ElevatedButton(
      //         onPressed: () => _handleSignOut(context),
      //         child: Text('Sign Out'),
      //       ),
      //     ],
      //   ),
      // ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentMenuIndex,
        onTap: onMenuItemSelected,
        selectedItemColor: Colors.blue,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.clock),
            label: 'ເວລາ',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.stopwatch),
            label: 'ຈັບເວລາ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'ບັນຊີ',
          )
        ],
      ),
    );
  }
}
