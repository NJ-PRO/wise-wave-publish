import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wisewave/components/theme/main_bg_gradient.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  String _displayName = '';
  String _email = '';

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  Future<void> getUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    DocumentSnapshot userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .get();

    setState(() {
      _displayName = userData['name'];
      _email = userData['email'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Account Details',
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
        actions: [
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
        padding: const EdgeInsets.all(50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Username',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFE3F4F7),
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: const EdgeInsets.all(10.0),
              child: Text(
                _displayName,
                style: const TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Email Address',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFE3F4F7),
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: const EdgeInsets.all(10.0),
              child: Text(
                _email,
                style: const TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ),
            const SizedBox(height: 50.0),
            ElevatedButton(
              onPressed: () {
                // Handle activity history button press
              },
              child: const Text('Activity History'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Handle feedback/support button press
              },
              child: const Text('Feedback/Support'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Handle get analysis button press
              },
              child: const Text('Get Analysis'),
            ),
            const SizedBox(height: 16.0),
            const Divider(), // Add a divider below the Get Analysis button
            const SizedBox(height: 16.0),
            // Add a donut chart with dummy data
            // Container(
            //   height: 200,
            //   width: 200,
            //   child: Stack(
            //     children: [
            //       CustomPaint(
            //         painter: DonutChartPainter(),
            //         child: Container(
            //           height: 200,
            //           width: 200,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

class DonutChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Dummy data
    final data = {
      'happy': 5,
      'sad': 3,
      'angry': 2,
      'anxious': 4,
      'stressed': 1,
      'excited': 6,
      'relaxed': 7,
      'energetic': 3,
      'lonely': 2,
      'calm': 5,
      'hopeful': 4,
      'bored': 2,
    };

    final total = data.values.reduce((a, b) => a + b);

    final colors = [
      Colors.blue,
      Colors.red,
      Colors.green,
      Colors.yellow,
      Colors.orange,
      Colors.purple,
      Colors.teal,
      Colors.pink,
      Colors.indigo,
      Colors.cyan,
      Colors.amber,
      Colors.lime,
    ];

    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    // final center = Offset(size.width / 2, size.height / 2);
    // final radius = size.width / 2;

    double startAngle = 0;

    data.forEach((key, value) {
      final sweepAngle = (value / total) * 2 * 3.14159;

      final paint = Paint()
        ..style = PaintingStyle.fill
        ..color = colors[data.keys.toList().indexOf(key) % colors.length];

      canvas.drawArc(rect, startAngle, sweepAngle, true, paint);

      startAngle += sweepAngle;
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
