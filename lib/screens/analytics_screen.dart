import 'package:flutter/material.dart';
import 'package:wisewave/components/theme/main_bg_gradient.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({Key key = const Key('default')}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: setMainBgGradient(),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Card(
                    shadowColor: const Color.fromARGB(111, 0, 0, 0),
                    elevation: 10,
                    color: const Color(0xFFE3F4F7),
                    surfaceTintColor: const Color(0xFFE3F4F7),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 30,
                      ),
                      child: Column(
                        children: [
                          const Text(
                            'KAI Says!', // Add the title here
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Transform.rotate(
                                angle:
                                    3.14159, // Rotate by 180 degrees (pi radians)
                                child: const Image(
                                  image: AssetImage(
                                      "assets/images/fa_quote-left.png"),
                                ),
                              ),
                              const SizedBox(width: 15),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: const Text(
                                  "This feeling won't last forever. There will be brighter days ahead. Remember, even the darkest night eventually gives way to the sun.",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              const SizedBox(width: 15),
                              const Image(
                                image: AssetImage(
                                    "assets/images/fa_quote-left.png"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Card(
                    shadowColor: const Color.fromARGB(111, 0, 0, 0),
                    elevation: 10,
                    color: const Color(0xFFE3F4F7),
                    surfaceTintColor: const Color(0xFFE3F4F7),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: const ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        child: Stack(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 30,
                                vertical: 30,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Spent Time",
                                    style: TextStyle(
                                      color: Color(0xff000000),
                                      fontSize: 23,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  Text(
                                    "03 Hrs 14 Mins",
                                    style: TextStyle(
                                      color: Color(0xFFFF3F18),
                                      fontSize: 20,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Positioned(
                              left: 200,
                              bottom: 0,
                              child: Icon(
                                Icons.access_time,
                                size: 190,
                                color: Color(0x3BFF9B87),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Data class for the bar graph
class HappinessData {
  final String day;
  final int happiness;

  HappinessData({required this.day, required this.happiness});
}
