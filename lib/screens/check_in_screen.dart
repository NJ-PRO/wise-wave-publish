import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:wisewave/components/theme/main_bg_gradient.dart';
import 'package:wisewave/screens/check_in_details.dart';

class CheckInScreen extends StatelessWidget {
  //passed uid from nav_page.dart
  final String uid;
  const CheckInScreen({super.key, required this.uid});

  Future<void> refreshHandler() async {
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: setMainBgGradient(),
        child: SafeArea(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('check_ins')
                .where('userId', isEqualTo: uid)
                .orderBy('timestamp', descending: true)
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.data!.docs.isEmpty) {
                return const Center(
                  child: Text('No check-Ins found.'),
                );
              } else {
                return LiquidPullToRefresh(
                  onRefresh: refreshHandler,
                  color: const Color(0xFFE5A8B6),
                  height: 150,
                  backgroundColor: const Color(0xFFB8D7E5),
                  animSpeedFactor: 2,
                  showChildOpacityTransition: false,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: snapshot.data!.docs.map((document) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: CheckInTile(
                            document: document,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CheckInDetails(document: document),
                                ),
                              );
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class CheckInTile extends StatelessWidget {
  final QueryDocumentSnapshot<Object?> document;
  final VoidCallback onPressed;

  const CheckInTile({
    super.key,
    required this.document,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    var notes = document['notes'],
        title = document['title'],
        mood = document['mood'];
    // Truncate title if it's too long UI BUG FIX
    if (title.length > 13) {
      title = title.substring(0, 13) + "...";
    }
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 5.0),
      child: GestureDetector(
        onTap: onPressed,
        child: Card(
          color: const Color(0xFFE3F4F7),
          shadowColor: const Color.fromARGB(111, 0, 0, 0),
          elevation: 10,
          surfaceTintColor: const Color(0xFFE3F4F7),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(25),
            ),
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
            child: Column(
              children: [
                Row(
                  children: [
                    const SizedBox(width: 10.0),
                    Image(
                      image: AssetImage('assets/images/$mood.png'),
                      width: 60,
                    ),
                    const SizedBox(width: 25.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                        Text(
                          notes.toString().length > 25
                              ? '${notes.toString().substring(0, 25)}...'
                              : notes,
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Divider(),
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Wrap(
                      spacing: 4.0,
                      alignment: WrapAlignment.start,
                      children: document['feelings'].map<Widget>((feeling) {
                        return Chip(
                          label: Text(feeling.toString().split(".")[1]),
                          backgroundColor: const Color(0xFFF4CEC6),
                          side: BorderSide.none,
                          labelStyle: const TextStyle(fontSize: 15),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(30),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
