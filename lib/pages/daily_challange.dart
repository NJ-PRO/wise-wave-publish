import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wisewave/components/theme/main_bg_gradient.dart';

class DailyChallange extends StatefulWidget {
  const DailyChallange({super.key});

  @override
  State<DailyChallange> createState() => _DailyChallangeState();
}

class _DailyChallangeState extends State<DailyChallange> {
  bool _isAceptButtonPressed = false;
  String _acceptButtonText = "ACCEPT CHALLENGE";

  @override
  Widget build(BuildContext context) {
    Container dailyChallengeBody =
        !_isAceptButtonPressed ? _beforAcceptBody() : _afterAcceptBody();

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: _myAppBar(context),
      body: dailyChallengeBody,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _challangeButton(context),
    );
  }

  Padding _challangeButton(BuildContext context) {
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
            onPressed: () async => setState(() {
              if (!_isAceptButtonPressed) {
                _acceptButtonText = "CHALLENGE FINISHED";
                _isAceptButtonPressed = true;
              } else {
                Navigator.pop(context);
              }
            }),
            style: const ButtonStyle(
              fixedSize: MaterialStatePropertyAll(Size(250, 60)),
              backgroundColor: MaterialStatePropertyAll(Colors.transparent),
            ),
            child: Text(
              _acceptButtonText,
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 15,
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

  Container _afterAcceptBody() {
    return Container(
      padding: const EdgeInsets.only(top: 250),
      decoration: setMainBgGradient(),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              width: 300,
              child: Text(
                "Today I will stretch for 5 minutes at some point throughout my day",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF000000),
                ),
              ),
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: () {},
              style: const ButtonStyle(
                  fixedSize: MaterialStatePropertyAll(Size(130, 60)),
                  backgroundColor: MaterialStatePropertyAll(
                      Color.fromARGB(125, 255, 255, 255))),
              child: const Text(
                "Add Photo",
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                    color: Color(0xFF000000)),
              ),
            ),
            const SizedBox(height: 80),
            const Image(
              image: AssetImage("assets/images/fa-white-flag-big.png"),
            ),
          ],
        ),
      ),
    );
  }

  Container _beforAcceptBody() {
    return Container(
      padding: const EdgeInsets.only(top: 250),
      decoration: setMainBgGradient(),
      child: const Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(image: AssetImage("assets/images/fa-white-flag.png")),
            Padding(
              padding: EdgeInsets.only(top: 50),
              child: SizedBox(
                width: 300,
                child: Text(
                  "Today I will stretch for 5 minutes at some point throughout my day",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF000000),
                  ),
                ),
              ),
            ),
          ],
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
      titleSpacing: 20,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      toolbarHeight: 80,
      title: const Text(
        "Daily\nChallenge",
        style: TextStyle(
          fontWeight: FontWeight.w800,
          color: Color(0xFF000000),
          fontSize: 30,
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
        const SizedBox(width: 20)
      ],
      bottom: const PreferredSize(
        preferredSize: Size(0, 10),
        child: SizedBox(height: 0),
      ),
    );
  }
}
