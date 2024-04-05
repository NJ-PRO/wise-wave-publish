import 'package:flutter/material.dart';
import 'package:wisewave/pages/login_or_singup_page.dart';

import '../components/theme/main_bg_gradient.dart';

// ignore: must_be_immutable
class SettingsScreen extends StatelessWidget {
  bool _notificationsOn = false;

  SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text(
          'Settings',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24.0,
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color.fromARGB(255, 242, 195, 178), Color(0xFFE5A8B6)],
              stops: [0, 1],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          GestureDetector(
            onTap: () async {
              Navigator.pop(context);
            },
            child: const Image(
              width: 45,
              image: AssetImage("assets/images/close-button.png"),
            ),
          ),
          const SizedBox(width: 20),
        ],
        bottom: const PreferredSize(
          preferredSize: Size(0, 10),
          child: SizedBox(height: 0),
        ),
      ),
      body: Container(
        decoration: setMainBgGradient(),
        //color: Theme.of(context).colorScheme.background,
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
          child: ListView(
            children: [
              ListTile(
                // username change
                leading: const Icon(Icons.person),
                title: const Text('Change Username'),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Change Username',
                            textAlign: TextAlign.center),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            TextField(
                              obscureText: false,
                              decoration: InputDecoration(
                                hintText: 'New Username',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            SizedBox(
                              width: 200.0,
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: const Color(0xFFE5A8B6),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                ),
                                onPressed: () {},
                                child: const Text('Change'),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
              const Divider(),
              ListTile(
                // password change
                leading: const Icon(Icons.lock),
                title: const Text('Change Password'),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Change Password',
                            textAlign: TextAlign.center),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            TextField(
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: 'Current Password',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            TextField(
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: 'New Password',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            TextField(
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: 'Confirm New Password',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            SizedBox(
                              width: 200.0, // Specify the width here
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: const Color(0xFFE5A8B6),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                ),
                                onPressed: () {},
                                child: const Text('Change'),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
              const Divider(),
              ListTile(
                  // change theme
                  leading: const Icon(Icons.color_lens),
                  title: const Text('Change Theme'),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          //title: Text('Choose an Option', textAlign: TextAlign.center),
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
                          content: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  //Provider.of<ThemeProvider>(context).togleTheme(3); //nature
                                },
                                style: ButtonStyle(
                                  padding: MaterialStateProperty.all(
                                      EdgeInsets.zero),
                                  shape: MaterialStateProperty.all(
                                      const CircleBorder()),
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.transparent),
                                  shadowColor: MaterialStateProperty.all(
                                      Colors.transparent),
                                ),
                                child: Ink(
                                  decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Color.fromARGB(255, 184, 215, 229),
                                        Color.fromARGB(255, 242, 195, 178)
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const SizedBox(
                                    width: 60.0,
                                    height: 60.0,
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  //Provider.of<ThemeProvider>(context).togleTheme(3); //nature
                                },
                                style: ButtonStyle(
                                  padding: MaterialStateProperty.all(
                                      EdgeInsets.zero),
                                  shape: MaterialStateProperty.all(
                                      const CircleBorder()),
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.transparent),
                                  shadowColor: MaterialStateProperty.all(
                                      Colors.transparent),
                                ),
                                child: Ink(
                                  decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.grey,
                                        Color.fromARGB(255, 48, 48, 48)
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const SizedBox(
                                    width: 60.0,
                                    height: 60.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          actions: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    //Provider.of<ThemeProvider>(context).togleTheme(3); //nature
                                  },
                                  style: ButtonStyle(
                                    padding: MaterialStateProperty.all(
                                        EdgeInsets.zero),
                                    shape: MaterialStateProperty.all(
                                        const CircleBorder()),
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.transparent),
                                    shadowColor: MaterialStateProperty.all(
                                        Colors.transparent),
                                  ),
                                  child: Ink(
                                    decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Color.fromRGBO(236, 206, 130, 1),
                                          Color.fromARGB(255, 154, 114, 99)
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const SizedBox(
                                      width: 60.0,
                                      height: 60.0,
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    //Provider.of<ThemeProvider>(context).togleTheme(3); //nature
                                  },
                                  style: ButtonStyle(
                                    padding: MaterialStateProperty.all(
                                        EdgeInsets.zero),
                                    shape: MaterialStateProperty.all(
                                        const CircleBorder()),
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.transparent),
                                    shadowColor: MaterialStateProperty.all(
                                        Colors.transparent),
                                  ),
                                  child: Ink(
                                    decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Color.fromRGBO(165, 214, 167, 1),
                                          Color.fromARGB(255, 96, 234, 167)
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const SizedBox(
                                      width: 60.0,
                                      height: 60.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    );
                  }),
              const Divider(),
              ListTile(
                //Notifications
                leading: const Icon(Icons.notifications),
                title: const Text('Notifications'),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return StatefulBuilder(
                        builder: (context, setState) {
                          return AlertDialog(
                            title: const Text('Notifications',
                                textAlign: TextAlign.center),
                            content: SwitchListTile(
                              title: const Text('Show Notifications'),
                              value: _notificationsOn,
                              onChanged: (bool value) {
                                setState(() {
                                  _notificationsOn = value;
                                });
                              },
                            ),
                            //actions: <Widget>[
                            //  TextButton(
                            //    child: Text('Close'),
                            //    onPressed: () {
                            //      Navigator.of(context).pop();
                            //    },
                            //  ),
                            //],
                          );
                        },
                      );
                    },
                  );
                },
              ),
              const Divider(),
              const ListTile(
                // clear chats
                leading: Icon(Icons.clear_all),
                title: Text('Clear Chats'),
              ),
              const Divider(),
              ListTile(
                // delete account
                leading: const Icon(Icons.delete),
                title: const Text('Delete Account'),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Delete Account'),
                        content: const Text(
                            'Are you sure you want to delete the account?'),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('No',
                                style: TextStyle(color: Colors.black)),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: const Text('Yes',
                                style: TextStyle(color: Colors.black)),
                            onPressed: () {
                              Navigator.of(context).pop();
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Confirmation',
                                        textAlign: TextAlign.center),
                                    content: const TextField(
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        hintText: 'Enter your password',
                                      ),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: const Text('Delete',
                                            style:
                                                TextStyle(color: Colors.black)),
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const LoginOrSignupPage()),
                                          );
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
