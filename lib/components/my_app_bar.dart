import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wisewave/screens/user_profile_screen.dart';

AppBar myAppBar(String name, String userProfilePic, int currentPageIndex,
    BuildContext context) {
  //retrive uid from auth service page
  String defaultProfilePic = "assets/images/default-profile-pic.png";

  return AppBar(
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
    backgroundColor: Colors.transparent,
    automaticallyImplyLeading: false,
    titleSpacing: 20,
    elevation: 0,
    title: currentPageIndex == 0
        ? RichText(
            text: TextSpan(
              text: "Hi ",
              style: const TextStyle(
                color: Color(0xFF000000),
                fontSize: 30,
              ),
              children: <TextSpan>[
                TextSpan(
                  // change the old one to reduce the crud operations. and pass the value from the nav_page.dart whick is return from crud.
                  text: "${name.toString().split(" ")[0]}!",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          )
        : currentPageIndex == 1
            ? Text(
                "Journals",
                style: _altTitleStyle(),
              )
            : currentPageIndex == 2
                ? Text(
                    "AI Assistant",
                    style: _altTitleStyle(),
                  )
                : Text(
                    "Analytics",
                    style: _altTitleStyle(),
                  ),
    actions: <Widget>[
      GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return UserProfileScreen(
              userName: name,
              userProfilePic: userProfilePic,
            );
          }));
        },
        child: CircleAvatar(
          radius: 23,
          backgroundColor: const Color(0xFF474747),
          child: userProfilePic != ""
              ? CircleAvatar(
                  radius: 18,
                  backgroundImage: NetworkImage(userProfilePic),
                )
              : CircleAvatar(
                  radius: 18,
                  backgroundImage: AssetImage(defaultProfilePic),
                ),
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

TextStyle _altTitleStyle() {
  return const TextStyle(
    color: Color(0xFF000000),
    fontWeight: FontWeight.bold,
    fontSize: 30,
  );
}
