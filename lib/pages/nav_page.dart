import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wisewave/components/my_app_bar.dart';
import 'package:wisewave/components/theme/nav_bg_gradient.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/bx.dart';
import 'package:iconify_flutter/icons/bxs.dart';
import 'package:wisewave/pages/add_check_ins_page.dart';
import 'package:wisewave/pages/daily_challange.dart';
import 'package:wisewave/pages/say_thanks.dart';
import 'package:wisewave/screens/chat_screen.dart';
import 'package:wisewave/screens/check_in_screen.dart';
import 'package:wisewave/screens/home_screen.dart';
import 'package:wisewave/screens/analytics_screen.dart';
import 'package:iconify_flutter/icons/fa.dart';
import 'package:wisewave/screens/work_load_screen.dart';

class NavPage extends StatefulWidget {
  //retrive uid from auth service page
  final String uid;
  final int index;

  const NavPage({super.key, required this.uid, required this.index});

  @override
  // ignore: no_logic_in_create_state
  State<NavPage> createState() => _NavPageState(index);
}

class _NavPageState extends State<NavPage> {
  _NavPageState(this.currentPageIndex);

  int currentPageIndex;
  bool _isFabButtonToggle = false;

  String _userName = '';
  String _userProfile = '';

  void getUserData() async {
    // Retrieve user data from Firebase using the UID
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.uid)
        .get();

    // Get the user name from the snapshot
    if (snapshot.exists) {
      setState(() {
        _userName = (snapshot.data() as Map<String, dynamic>)['name'] ?? '';
        _userProfile =
            (snapshot.data() as Map<String, dynamic>)['photoUrl'] ?? '';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: myAppBar(_userName, _userProfile, currentPageIndex, context),
      body: getNavScreenBody[currentPageIndex],
      floatingActionButton: getFabButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: getBottomNavBar(),
    );
  }

  List<Widget> get getNavScreenBody {
    return <Widget>[
      // Home screen content.
      // pass current user id to the Home screen
      HomeScreen(uid: widget.uid),
      // checkIns screen content.
      // pass current user id to the CheckIn screen
      CheckInScreen(uid: widget.uid),
      // Chat screen content.
      ChatScreen(username: _userName),
      // User profile screen content.
      const AnalyticsScreen(),
    ];
  }

  Stack getFabButton() {
    return Stack(
      alignment: Alignment.center,
      children: [
        if (_isFabButtonToggle)
          GestureDetector(
            onTap: () {
              setState(() {
                _isFabButtonToggle = !_isFabButtonToggle;
              });
            },
            child: Container(
              color: const Color.fromARGB(140, 55, 55, 55),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
          ),
        if (_isFabButtonToggle)
          Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                bottom: 80.0,
                child: Container(
                  height: 260,
                  width: 230,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF39B29C),
                        Color(0xFF39B29C),
                      ],
                      stops: [0, 1],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      FilledButton(
                        style: const ButtonStyle(
                          splashFactory: NoSplash.splashFactory,
                          padding: MaterialStatePropertyAll(EdgeInsets.all(15)),
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.transparent),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Mood Check-In',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFFFFFFF),
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        onPressed: () async {
                          await Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return AddCheckInPage(uid: widget.uid);
                          }));

                          setState(() {
                            _isFabButtonToggle = !_isFabButtonToggle;
                          });
                        },
                      ),
                      FilledButton(
                        style: const ButtonStyle(
                          splashFactory: NoSplash.splashFactory,
                          padding: MaterialStatePropertyAll(EdgeInsets.all(15)),
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.transparent),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Daily Challenge',
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        onPressed: () async {
                          await Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const DailyChallange();
                          }));

                          setState(() {
                            _isFabButtonToggle = !_isFabButtonToggle;
                          });
                        },
                      ),
                      FilledButton(
                        style: const ButtonStyle(
                          splashFactory: NoSplash.splashFactory,
                          padding: MaterialStatePropertyAll(EdgeInsets.all(15)),
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.transparent),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Workload',
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        onPressed: () async {
                          await Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return WorkLoadScreen(uid: widget.uid);
                          }));

                          setState(() {
                            _isFabButtonToggle = !_isFabButtonToggle;
                          });
                        },
                      ),
                      FilledButton(
                        style: const ButtonStyle(
                          splashFactory: NoSplash.splashFactory,
                          padding: MaterialStatePropertyAll(EdgeInsets.all(15)),
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.transparent),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Say Thanks',
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        onPressed: () async {
                          await Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return SayThanksPage(uid: widget.uid);
                          }));

                          setState(() {
                            _isFabButtonToggle = !_isFabButtonToggle;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        Positioned(
          bottom: 20.0,
          child: SizedBox(
            width: 70,
            height: 70,
            child: FittedBox(
              child: FloatingActionButton(
                onPressed: () {
                  setState(() {
                    _isFabButtonToggle = !_isFabButtonToggle;
                  });
                },
                elevation: 0,
                backgroundColor: const Color(0xFF39B29C),
                child: _isFabButtonToggle
                    ? const Iconify(
                        Fa.close,
                        size: 24,
                        color: Color(0xffF2FFE9),
                      )
                    : const Iconify(
                        Fa.plus,
                        size: 24,
                        color: Color(0xffF2FFE9),
                      ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Container getBottomNavBar() {
    return Container(
      decoration: setNavBgGradient(),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        child: NavigationBar(
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          indicatorColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          selectedIndex: currentPageIndex,
          destinations: const <Widget>[
            HomeNavigator(),
            CheckInNavigator(),
            MessageNavigator(),
            AnalyticsNavigator(),
          ],
        ),
      ),
    );
  }
}

class AnalyticsNavigator extends StatelessWidget {
  const AnalyticsNavigator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const NavigationDestination(
      selectedIcon: Badge(
        alignment: Alignment(0, -7.8),
        smallSize: 19,
        backgroundColor: Color(0xFF39B29C),
        child: Iconify(
          Bxs.analyse,
          size: 30,
          color: Color(0xFF39B29C),
        ),
      ),
      icon: Iconify(
        Bx.analyse,
        size: 30,
        color: Color(0xFF472732),
      ),
      label: 'Analytics',
    );
  }
}

class MessageNavigator extends StatelessWidget {
  const MessageNavigator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 70),
      child: NavigationDestination(
        selectedIcon: Badge(
          alignment: Alignment(0, -7.8),
          smallSize: 19,
          backgroundColor: Color(0xFF39B29C),
          child: Iconify(
            Bxs.message,
            size: 30,
            color: Color(0xFF39B29C),
          ),
        ),
        icon: Iconify(
          Bx.message,
          size: 30,
          color: Color(0xFF472732),
        ),
        label: 'Chat',
      ),
    );
  }
}

class CheckInNavigator extends StatelessWidget {
  const CheckInNavigator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(right: 70),
      child: NavigationDestination(
        selectedIcon: Badge(
          alignment: Alignment(0, -7.8),
          smallSize: 19,
          backgroundColor: Color(0xFF39B29C),
          child: Iconify(
            Bxs.bookmark,
            size: 30,
            color: Color(0xFF39B29C),
          ),
        ),
        icon: Iconify(
          Bx.bookmark,
          size: 30,
          color: Color.fromARGB(255, 71, 39, 50),
        ),
        label: 'Journals',
      ),
    );
  }
}

class HomeNavigator extends StatelessWidget {
  const HomeNavigator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const NavigationDestination(
      selectedIcon: Badge(
        alignment: Alignment(0, -7.8),
        smallSize: 19,
        backgroundColor: Color(0xFF39B29C),
        child: Iconify(
          Bxs.home_alt_2,
          color: Color(0xFF39B29C),
          size: 30,
        ),
      ),
      icon: Iconify(
        Bx.home_alt_2,
        size: 30,
        color: Color(0xFF472732),
      ),
      label: 'Home',
    );
  }
}
