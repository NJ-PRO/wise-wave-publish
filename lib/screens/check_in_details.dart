import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:wisewave/components/theme/main_bg_gradient.dart';

class CheckInDetails extends StatelessWidget {
  final QueryDocumentSnapshot<Object?> document;

  const CheckInDetails({super.key, required this.document});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _myAppBar(context),
      body: Container(
        decoration: setMainBgGradient(),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(
                              fontSize: 23, color: Colors.black),
                          children: [
                            const TextSpan(
                              text: 'Title\n',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w800,
                                color: Color.fromARGB(70, 70, 70, 70),
                              ),
                            ),
                            TextSpan(
                              text: '${document['title']}',
                              style: const TextStyle(
                                fontSize: 22,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Divider(
                        thickness: 2,
                        color: Color(0x7E9E9E9E),
                      ),
                      const SizedBox(height: 10),
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(
                              fontSize: 23, color: Colors.black),
                          children: [
                            const TextSpan(
                              text: 'Feelings\n',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w800,
                                color: Color.fromARGB(70, 70, 70, 70),
                              ),
                            ),
                            ...document['feelings'].map((feeling) {
                              return TextSpan(
                                text: '${feeling.toString().split('.')[1]}, ',
                                style: const TextStyle(
                                  fontSize: 22,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            }).toList(),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Divider(
                        thickness: 2,
                        color: Color(0x7E9E9E9E),
                      ),
                      const SizedBox(height: 10),
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(
                              fontSize: 23, color: Colors.black),
                          children: [
                            const TextSpan(
                              text: 'Activities\n',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w800,
                                color: Color.fromARGB(70, 70, 70, 70),
                              ),
                            ),
                            ...document['activities'].map((activities) {
                              return TextSpan(
                                text:
                                    '${activities.toString().split('.')[1]}, ',
                                style: const TextStyle(
                                  fontSize: 22,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            }).toList(),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Divider(
                        thickness: 2,
                        color: Color(0x7E9E9E9E),
                      ),
                      const SizedBox(height: 10),
                      RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Mood\n',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w800,
                                color: Color.fromARGB(70, 70, 70, 70),
                              ),
                            ),
                            TextSpan(
                              text: '${document['mood']}',
                              style: const TextStyle(
                                fontSize: 22,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Divider(
                        thickness: 2,
                        color: Color(0x7E9E9E9E),
                      ),
                      const SizedBox(height: 10),
                      RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Notes\n',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w800,
                                color: Color.fromARGB(70, 70, 70, 70),
                              ),
                            ),
                            TextSpan(
                              text: '${document['notes']}',
                              style: const TextStyle(
                                fontSize: 22,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
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
          "Journal Details",
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
            colors: [Color.fromARGB(255, 242, 195, 178), Color(0xFFE5A8B6)],
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
}
