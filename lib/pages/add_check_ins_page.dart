import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/icon_park_solid.dart';
import 'package:wisewave/components/theme/main_bg_gradient.dart';

enum ActivityFillter {
  work,
  family,
  friends,
  hobbies,
  gaming,
  weather,
  school,
  relationship,
  traveling,
  sleep,
  shopping,
  food,
  exercise,
  health,
  music,
  relaxing,
}

enum FeelingFillter {
  happy,
  blessed,
  good,
  lucky,
  confused,
  bored,
  awkward,
  stressed,
  angry,
  anxious,
  down,
}

class AddCheckInPage extends StatefulWidget {
  //retrive uid from HomeScreen page
  final String uid;
  const AddCheckInPage({required this.uid, super.key});

  @override
  State<AddCheckInPage> createState() => _AddCheckInPageState();
}

class _AddCheckInPageState extends State<AddCheckInPage> {
  Set<ActivityFillter> activityFilters = <ActivityFillter>{};
  Set<FeelingFillter> feelingFillters = <FeelingFillter>{};
  final List<String> _emotionsList = [
    "REALLY TERRIBLE",
    "SOMEWHAT BAD",
    "COMPLETELY OKAY",
    "PRETTY GOOD",
    "SUPER AWSOME",
  ];
  late int _currentSliderPosition = 2;
  bool _isBottomButtonPressed = false;
  String _bottmButtonText = "Continue";
  Widget _leadingIcon = const Text('');
  bool _isSliderChanged = false;
  final TextEditingController _titleTextFieldController =
      TextEditingController();
  final TextEditingController _addNotesTextFieldController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Container checkInBody =
        !_isBottomButtonPressed ? _moodTrackerBody() : _noteWriterBody();

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: _myAppBar(context),
      body: checkInBody,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _bottomButton(context),
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
            onPressed: _isSliderChanged
                ? () {
                    setState(() {
                      if (!_isBottomButtonPressed) {
                        _bottmButtonText = "Complete Check-In";
                        _isBottomButtonPressed = true;
                        _leadingIcon = _getLeadingBackIcon();
                      } else if (_titleTextFieldController.text != "" &&
                          activityFilters.isNotEmpty &&
                          feelingFillters.isNotEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Check-In added to the journal!"),
                            behavior: SnackBarBehavior.fixed,
                            duration: Duration(milliseconds: 1000),
                          ),
                        );
                        Navigator.pop(context);
                        _saveCheckInData();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                "Activity, Feeling, and Title are required!"),
                            behavior: SnackBarBehavior.fixed,
                            duration: Duration(milliseconds: 1500),
                          ),
                        );
                        null;
                      }
                    });
                  }
                : null,
            style: const ButtonStyle(
              fixedSize: MaterialStatePropertyAll(Size(250, 60)),
              backgroundColor: MaterialStatePropertyAll(Colors.transparent),
            ),
            child: Text(
              _bottmButtonText,
              style: const TextStyle(
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

  Container _noteWriterBody() {
    return Container(
      decoration: setMainBgGradient(),
      child: Center(
        child: Container(
          margin: const EdgeInsets.fromLTRB(0, 107, 0, 0),
          padding: const EdgeInsets.only(bottom: 100),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // activity heading
                SizedBox(
                  width: 340,
                  child: Text(
                    "What's making you ${_emotionsList[_currentSliderPosition].toLowerCase()}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF000000),
                    ),
                  ),
                ),
                const SizedBox(height: 5),

                // activity chips
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Wrap(
                    spacing: 5.0,
                    runSpacing: -6.0,
                    children:
                        ActivityFillter.values.map((ActivityFillter activity) {
                      return FilterChip(
                        side: BorderSide.none,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        selectedColor: const Color.fromARGB(255, 229, 168, 182),
                        surfaceTintColor:
                            const Color.fromARGB(255, 229, 168, 182),
                        elevation: 5,
                        backgroundColor: const Color(0xFFE3F4F7),
                        labelStyle: const TextStyle(fontSize: 12),
                        label: Text(activity.name),
                        selected: activityFilters.contains(activity),
                        onSelected: (bool selected) {
                          setState(() {
                            if (selected) {
                              activityFilters.add(activity);
                            } else {
                              activityFilters.remove(activity);
                            }
                          });
                        },
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 30),

                // feeling heading
                const SizedBox(
                  width: 340,
                  child: Text(
                    "How are you feeling about this?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF000000),
                    ),
                  ),
                ),

                // feeling chips
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Wrap(
                    spacing: 5.0,
                    runSpacing: -6.0,
                    children:
                        FeelingFillter.values.map((FeelingFillter feeling) {
                      return FilterChip(
                        side: BorderSide.none,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        selectedColor: const Color.fromARGB(255, 229, 168, 182),
                        surfaceTintColor:
                            const Color.fromARGB(255, 229, 168, 182),
                        elevation: 5,
                        backgroundColor: const Color(0xFFE3F4F7),
                        labelStyle: const TextStyle(fontSize: 12),
                        label: Text(feeling.name),
                        selected: feelingFillters.contains(feeling),
                        onSelected: (bool selected) {
                          setState(() {
                            if (selected) {
                              feelingFillters.add(feeling);
                            } else {
                              feelingFillters.remove(feeling);
                            }
                          });
                        },
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 30),

                // Title textfield
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  child: TextField(
                    controller: _titleTextFieldController,
                    onTap: () async => setState(() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TitleTextfieldScreen(
                            initialValue: _titleTextFieldController.text,
                          ),
                        ),
                      ).then((enteredValue) {
                        if (enteredValue != null) {
                          setState(() {
                            _titleTextFieldController.text = enteredValue;
                          });
                        }
                      });
                    }),
                    autofocus: false,
                    readOnly: true,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFE3F4F7),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xFFE3F4F7)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xFFE3F4F7)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'Title...',
                      hintStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(122, 71, 71, 71),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),

                // add some notes textfeild...
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  child: TextField(
                    controller: _addNotesTextFieldController,
                    onTap: () async => setState(() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddNotesTextfieldScreen(
                            initialValue: _addNotesTextFieldController.text,
                          ),
                        ),
                      ).then((enteredValue) {
                        if (enteredValue != null) {
                          setState(() {
                            _addNotesTextFieldController.text = enteredValue;
                          });
                        }
                      });
                    }),
                    maxLines: 3,
                    autofocus: false,
                    readOnly: true,
                    style: const TextStyle(fontSize: 15),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFE3F4F7),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xFFE3F4F7)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xFFE3F4F7)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'Add some notes...',
                      hintStyle: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(122, 71, 71, 71),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container _moodTrackerBody() {
    return Container(
      decoration: setMainBgGradient(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 120),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                width: 340,
                child: Text(
                  "How are you feeling now?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF000000),
                  ),
                ),
              ),
              const SizedBox(height: 115),
              Image(
                width: 200,
                height: 200,
                image: AssetImage(
                  "assets/images/${_emotionsList[_currentSliderPosition]}.png",
                ),
              ),
              const SizedBox(height: 15),
              Text(
                _emotionsList[_currentSliderPosition],
                style: const TextStyle(
                  fontSize: 20,
                  color: Color(0xFF000000),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                width: 350,
                height: 100,
                child: SliderTheme(
                  data: const SliderThemeData(
                    trackHeight: 15,
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 17.0),
                  ),
                  child: Slider(
                    value: _currentSliderPosition.toDouble(),
                    activeColor: const Color(0xFFE5ABB5),
                    inactiveColor: const Color(0xFFE5ABB5),
                    thumbColor: const Color(0xFFffffff),
                    min: 0,
                    max: 4,
                    onChanged: (double value) async {
                      setState(() {
                        _currentSliderPosition = value.round().toInt();
                        _isSliderChanged = true;
                      });
                    },
                  ),
                ),
              ),
            ],
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
      leadingWidth: 65,
      automaticallyImplyLeading: false,
      scrolledUnderElevation: 10,
      surfaceTintColor: const Color.fromARGB(255, 255, 255, 255),
      backgroundColor: Colors.transparent,
      leading: _leadingIcon,
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

  Row _getLeadingBackIcon() {
    return Row(
      children: [
        const SizedBox(width: 20),
        GestureDetector(
          onTap: () {
            setState(() {
              if (_isBottomButtonPressed) {
                _bottmButtonText = "Continue";
                _isBottomButtonPressed = false;
                _leadingIcon = const Text('');
              }
            });
          },
          child: const Image(
            width: 45,
            image: AssetImage("assets/images/back-button.png"),
          ),
        ),
      ],
    );
  }

  void _saveCheckInData() async {
    // Prepare data for Firestore
    Map<String, dynamic> checkInData = {
      'activities':
          activityFilters.map((activity) => activity.toString()).toList(),
      'feelings': feelingFillters.map((feeling) => feeling.toString()).toList(),
      'mood': _emotionsList[_currentSliderPosition],
      'title': _titleTextFieldController.text,
      'notes': _addNotesTextFieldController.text,
      'timestamp': DateTime.now(),
      'userId': widget.uid,
    };

    // Add data to Firestore
    try {
      await FirebaseFirestore.instance.collection('check_ins').add(checkInData);
      // Data added successfully, you can navigate to another screen or show a success message
    } catch (e) {
      // Error occurred while adding data to Firestore, handle the error
      print('Error adding check-in: $e');
      // Show an error message or retry logic
    }
  }
}

// new activity
// ignore: must_be_immutable
class TitleTextfieldScreen extends StatelessWidget {
  String initialValue;
  TitleTextfieldScreen({super.key, required this.initialValue});
  final TextEditingController _titleTextfieldController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    _titleTextfieldController.text = initialValue;
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
        automaticallyImplyLeading: false,
        title: const Text(
          "Check-In Title",
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: Color(0xFF000000),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: PopScope(
        canPop: false,
        child: Container(
          decoration: setMainBgGradient(),
          alignment: Alignment.center,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            child: TextField(
              controller: _titleTextfieldController,
              maxLength: 25,
              onEditingComplete: () async =>
                  Navigator.pop(context, _titleTextfieldController.text),
              focusNode: FocusNode(),
              autofocus: true,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFFE3F4F7),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xFFE3F4F7)),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xFFE3F4F7)),
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: 'Title...',
                hintStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0x79474747),
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async =>
            Navigator.pop(context, _titleTextfieldController.text),
        backgroundColor: const Color(0xFFE5ABB5),
        child: const Iconify(
          IconParkSolid.correct,
          color: Color(0xFFFFFFFF),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class AddNotesTextfieldScreen extends StatelessWidget {
  String initialValue;
  AddNotesTextfieldScreen({super.key, required this.initialValue});
  final TextEditingController _addNotesTextfieldController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    _addNotesTextfieldController.text = initialValue;
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
        automaticallyImplyLeading: false,
        title: const Text(
          "Notes",
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: Color(0xFF474747),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: PopScope(
        canPop: false,
        child: Container(
          decoration: setMainBgGradient(),
          alignment: Alignment.center,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            child: TextField(
              controller: _addNotesTextfieldController,
              onEditingComplete: () async =>
                  Navigator.pop(context, _addNotesTextfieldController.text),
              maxLines: 10,
              focusNode: FocusNode(),
              autofocus: true,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFFE3F4F7),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xFFE3F4F7)),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xFFE3F4F7)),
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: 'Add some notes...',
                hintStyle: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(122, 71, 71, 71),
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async =>
            Navigator.pop(context, _addNotesTextfieldController.text),
        backgroundColor: const Color(0xFFE5ABB5),
        child: const Iconify(
          IconParkSolid.correct,
          color: Color(0xFFFFFFFF),
        ),
      ),
    );
  }
}
