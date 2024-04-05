import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:wisewave/components/theme/main_bg_gradient.dart';
import 'package:wisewave/pages/add_work_page.dart';
import 'package:intl/intl.dart';

class WorkLoadScreen extends StatelessWidget {
  //retrive uid from HomeScreen page
  final String uid;
  const WorkLoadScreen({required this.uid, super.key});

  Future<void> refreshHandler() async {
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _myAppBar(context),
      floatingActionButton: _bottomButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Container(
        decoration: setMainBgGradient(),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('works')
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
                child: Text('No Workloads found.'),
              );
            } else {
              return LiquidPullToRefresh(
                onRefresh: refreshHandler,
                color: const Color(0xFFE5A8B6),
                height: 150,
                backgroundColor: const Color(0xFFB8D7E5),
                animSpeedFactor: 2,
                showChildOpacityTransition: false,
                child: ListView(children: [
                  const SizedBox(height: 20),
                  Column(
                    children: snapshot.data!.docs.map((document) {
                      return CheckInTile(
                        document: document,
                        onPressed: () {
                          //   Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => CheckInDetails(document: document),
                          //     ),
                          //   );
                        },
                      );
                    }).toList(),
                  ),
                ]),
              );
            }
          },
        ),
      ),
    );
  }

  AppBar _myAppBar(BuildContext context) {
    return AppBar(
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      automaticallyImplyLeading: false,
      title: const Padding(
        padding: EdgeInsets.only(left: 10.0),
        child: Text(
          "Workload",
          style: TextStyle(
            color: Color(0xFF000000),
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 242, 195, 178),
              Color.fromARGB(255, 229, 168, 182)
            ],
            stops: [0, 1],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      ),
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
    );
  }

  Padding _bottomButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 242, 195, 178),
                    Color.fromARGB(255, 229, 168, 182)
                  ],
                  stops: [0, 1],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.all(Radius.circular(100)),
              ),
            ),
          ),
          FilledButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddWorkPage(uid: uid)));
            },
            style: const ButtonStyle(
              fixedSize: MaterialStatePropertyAll(Size(250, 60)),
              backgroundColor: MaterialStatePropertyAll(Colors.transparent),
            ),
            child: const Text(
              "Add Work",
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 18,
                shadows: <Shadow>[
                  Shadow(
                    offset: Offset(0, 1.5),
                    color: Color.fromARGB(38, 0, 0, 0),
                    blurRadius: 30,
                  ),
                ],
              ),
            ),
          ),
        ],
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
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Container(
          color: const Color(0xFFE3F4F7),
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
          child: Column(
            children: [
              ListTile(
                title: Text(
                  document['title'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                subtitle: Text(document['details']),
                onTap: onPressed,
              ),
              const Divider(),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Wrap(
                    spacing: 4.0,
                    alignment: WrapAlignment.start,
                    children: <Widget>[
                      Chip(
                        label: Text(DateFormat.yMMMMd('en_US')
                            .format(DateTime.parse(document['date']))),
                        backgroundColor:
                            const Color.fromARGB(255, 198, 238, 245),
                        side: BorderSide.none,
                        labelStyle: const TextStyle(fontSize: 15),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
