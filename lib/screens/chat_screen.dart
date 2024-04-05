import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:wisewave/components/theme/main_bg_gradient.dart';
import 'package:wisewave/pages/chat_page.dart';
import 'package:iconify_flutter/icons/ri.dart';

class ChatScreen extends StatelessWidget {
  final String username;
  const ChatScreen({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: setMainBgGradient(),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(height: 55),
              const Image(
                image: AssetImage("assets/images/KAI.png"),
                width: 250,
              ),
              SizedBox(
                width: 270,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        text:
                            "Hi ${username.toString().split(" ")[0]}\nMeet KAI!",
                        style: const TextStyle(
                            fontSize: 32,
                            color: Color(0xff000000),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "All your question answer by KAI,\nAsk here please!",
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              FilledButton(
                style: const ButtonStyle(
                    elevation: MaterialStatePropertyAll(10.0),
                    shadowColor:
                        MaterialStatePropertyAll(Color.fromARGB(104, 0, 0, 0)),
                    backgroundColor:
                        MaterialStatePropertyAll(Color(0xFFE3F4F7)),
                    fixedSize: MaterialStatePropertyAll(Size(300, 90))),
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ChatPage(),
                    )),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Iconify(
                      Ri.send_plane_fill,
                      color: Color.fromARGB(255, 0, 0, 0),
                      size: 50,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Chat with! KAI.",
                      style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFF000000),
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
