import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:wisewave/animation/fade_animation.dart';
import 'package:wisewave/components/auth_service.dart';

class SignupPage extends StatefulWidget {
  final Function()? onTap;
  const SignupPage({super.key, required this.onTap});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final myimages = [
    Image.asset(
      'assets/images/alt-page1.png',
      fit: BoxFit.fitHeight,
    ),
    Image.asset(
      'assets/images/alt-page2.png',
      fit: BoxFit.fitHeight,
    ),
    Image.asset(
      'assets/images/alt-page3.png',
      fit: BoxFit.fitHeight,
    ),
    Image.asset(
      'assets/images/alt-page4.png',
      fit: BoxFit.fitHeight,
    ),
    Image.asset(
      'assets/images/alt-page5.png',
      fit: BoxFit.fitHeight,
    ),
  ];
  int currentIndex = 0;

  //final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: FadeAnimation(
                1.5,
                Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xfff2c2b1),
                          Color(0xffe5a8b6)
                        ], // Change these colors as needed
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 30),
                        Container(
                          padding: const EdgeInsets.all(40.0),
                          child: Image.asset(
                            'assets/images/final-logo-of-wise-wave.png',
                            fit: BoxFit.cover,
                            width: 200,
                            height: 115,
                          ),
                        ),
                        CarouselSlider(
                          items: myimages,
                          options: CarouselOptions(
                              height: 300.0,
                              enlargeCenterPage: true,
                              autoPlay: true,
                              aspectRatio: 2.0,
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enableInfiniteScroll: true,
                              autoPlayAnimationDuration:
                                  const Duration(milliseconds: 300),
                              viewportFraction: 0.8,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  currentIndex = index;
                                });
                              }),
                        ),
                        const SizedBox(height: 20),
                        AnimatedSmoothIndicator(
                          activeIndex: currentIndex,
                          count: myimages.length,
                          effect: const ExpandingDotsEffect(
                            dotColor: Color(0x52418883),
                            activeDotColor: Color(0xFF4CA59F),
                            dotHeight: 10,
                            dotWidth: 10,
                            spacing: 10,
                          ),
                        ),

                        const SizedBox(height: 50),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 60.0),
                          child: Material(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(100),
                              ),
                            ),
                            child: ListTile(
                              title: const Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.0),
                                child: Text(
                                  "Signup with Google",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              leading: Image.asset('assets/images/Google.png'),
                              onTap: () => AuthService().signInWithGoogle(context),
                              tileColor: const Color(0xFFFFFFFF),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(100),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 80),
                        //signup
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Already have an account?',
                              style: TextStyle(
                                fontSize: 15,
                                color: Color(0xff000000),
                              ),
                            ),
                            const SizedBox(width: 10),
                            GestureDetector(
                              onTap: widget.onTap,
                              child: const Text(
                                'Log in',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFF4CA59F),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )))));
  }
}
