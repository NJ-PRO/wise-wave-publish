import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/bxs.dart';
import 'package:wisewave/components/theme/main_bg_gradient.dart';
import 'package:http/http.dart' as http;

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ChatPageState createState() => _ChatPageState();
}

class Message {
  final String text;
  final bool isSentByUser;

  Message({required this.text, required this.isSentByUser});
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _textEditingController = TextEditingController();
  final List<Message> messages = [];
  final ScrollController _scrollController = ScrollController();

  http.Client _getClient() {
    return http.Client();
  }

  void sendMessage(String text) {
    final message = Message(text: text, isSentByUser: true);
    setState(() {
      messages.add(message);
      _textEditingController.clear();
    });
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOut,
        );
      },
    );
    var client = _getClient();
    // ignore: avoid_single_cascade_in_expression_statements
    client.post(
      Uri.parse('https://kai-chatbot-9dde5a75cb6d.herokuapp.com/bot'),
      // Uri.parse('http://192.168.8.129:5000/bot'),
      body: {'query': text},
    )..then((response) {
        if (response.statusCode == 200) {
          Map<String, dynamic> messages = jsonDecode(response.body);
          receiveMessage(messages['response']);
        } else {
          if (kDebugMode) {
            print('Failed to send message');
          }
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Bad response from Bot..."),
              behavior: SnackBarBehavior.fixed,
              duration: Duration(milliseconds: 700),
            ),
          );
        }
      }).catchError((error) {
        if (kDebugMode) {
          print(error);
        }
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Failed to send message..."),
            behavior: SnackBarBehavior.fixed,
            duration: Duration(milliseconds: 700),
          ),
        );
      }).whenComplete(() {
        client.close();
      });
  }

  void receiveMessage(String text) {
    final message = Message(text: text, isSentByUser: false);
    setState(() {
      messages.add(message);
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _myChatAppBar(context),
      body: Container(
        decoration: setMainBgGradient(),
        padding: const EdgeInsets.only(
          bottom: 20,
          right: 20,
          left: 20,
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  return Align(
                    alignment: message.isSentByUser
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 5.0),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: message.isSentByUser
                            ? const BorderRadius.only(
                                bottomLeft: Radius.circular(20.0),
                                topLeft: Radius.circular(20.0),
                                topRight: Radius.circular(20.0),
                                bottomRight: Radius.circular(5.0))
                            : const BorderRadius.only(
                                bottomLeft: Radius.circular(5.0),
                                topLeft: Radius.circular(20.0),
                                topRight: Radius.circular(20.0),
                                bottomRight: Radius.circular(20.0)),
                        color: message.isSentByUser
                            ? const Color(0xFF426C5E)
                            : const Color(0xFF6C4059),
                      ),
                      child: Text(
                        message.text,
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                color: const Color(0xFF63726D),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 5.0,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(width: 20.0),
                  Expanded(
                    child: TextField(
                      controller: _textEditingController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter your message',
                        hintStyle: TextStyle(color: Color(0x85D2D2D2)),
                      ),
                      cursorColor: const Color(0xffffffff),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                    ),
                  ),
                  IconButton(
                    icon: const Iconify(
                      Bxs.send,
                      size: 33.0,
                      color: Color(0xffffffff),
                    ),
                    onPressed: () {
                      if (_textEditingController.text.isEmpty) {
                        return;
                      }
                      sendMessage(_textEditingController.text);
                    },
                  ),
                  const SizedBox(width: 5.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _myChatAppBar(BuildContext context) {
    return AppBar(
      title: const Row(
        children: [
          SizedBox(width: 5),
          CircleAvatar(
            backgroundColor: Color.fromARGB(124, 0, 45, 129),
            child: Image(
              image: AssetImage("assets/images/KAI-face.png"),
            ),
          ),
          SizedBox(
            width: 15.0,
          ),
          Text(
            'KAI',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
          ),
        ],
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
    );
  }
}
