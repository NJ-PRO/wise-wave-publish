import 'package:flutter/material.dart';
import '../components/theme/main_bg_gradient.dart';
import 'chat_screen.dart';

class ChatWelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //appBar: AppBar(),
        body: Container(
      decoration: setMainBgGradient(),
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'How are you feeling today?',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  IconPair(
                    icon: Icons.sentiment_very_satisfied,
                    label: 'Happy',
                    onTap: () {
                      navigateToChatScreen(context, 'Happy');
                    },
                  ),
                  SizedBox(height: 16),
                  IconPair(
                    icon: Icons.sentiment_very_dissatisfied,
                    label: 'Sad',
                    onTap: () {
                      navigateToChatScreen(context, 'Sad');
                    },
                  ),
                  SizedBox(height: 16),
                  IconPair(
                    icon: Icons.sentiment_neutral,
                    label: 'Neutral',
                    onTap: () {
                      navigateToChatScreen(context, 'Neutral');
                    },
                  ),
                  SizedBox(height: 16),
                  IconPair(
                    icon: Icons.sentiment_very_satisfied,
                    label: 'Excited',
                    onTap: () {
                      navigateToChatScreen(context, 'Excited');
                    },
                  ),
                ],
              ),
              SizedBox(width: 32),
              Column(
                children: [
                  IconPair(
                    icon: Icons.sentiment_very_dissatisfied,
                    label: 'Angry',
                    onTap: () {
                      navigateToChatScreen(context, 'Angry');
                    },
                  ),
                  SizedBox(height: 16),
                  IconPair(
                    icon: Icons.sentiment_very_satisfied,
                    label: 'Love',
                    onTap: () {
                      navigateToChatScreen(context, 'Love');
                    },
                  ),
                  SizedBox(height: 16),
                  IconPair(
                    icon: Icons.sentiment_very_dissatisfied,
                    label: 'Surprised',
                    onTap: () {
                      navigateToChatScreen(context, 'Surprised');
                    },
                  ),
                  SizedBox(height: 16),
                  IconPair(
                    icon: Icons.sentiment_neutral,
                    label: 'Confused',
                    onTap: () {
                      navigateToChatScreen(context, 'Confused');
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      )),
    ));
  }

  void navigateToChatScreen(BuildContext context, String emotion) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ChatScreen(username: "naaji"),
      ),
    );
  }
}

class IconPair extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const IconPair({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon, size: 48),
          SizedBox(height: 8),
          Text(label),
        ],
      ),
    );
  }
}
