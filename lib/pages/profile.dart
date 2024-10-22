import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_app_todo/pages/HomePage.dart';
import 'package:mobile_app_todo/pages/MotiveSozler.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final ImagePicker _picker = ImagePicker();
  XFile? image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xFFffe0e0),
            Color(0xFFc25900),
          ]),
        ),
        child: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  padding: EdgeInsets.only(right: 330),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (builder) => HomePage()),
                        (route) => false);
                  },
                  icon: Icon(
                    CupertinoIcons.arrow_left,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                CircleAvatar(
                  radius: 60,
                  backgroundImage: getImage(),
                ),
                SizedBox(
                  height: 95,
                ),
                button(),
                SizedBox(
                  height: 55,
                ),
                button3(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ImageProvider getImage() {
    if (image != null) {
      return FileImage(File(image!.path));
    }
    return AssetImage("assets/logo.png");
  }

  Widget button() {
    return InkWell(
      onTap: () async {
        image = await _picker.pickImage(source: ImageSource.gallery);
        setState(() {
          image = image;
        });
      },
      child: Row(
        children: [
          IconButton(
              padding: EdgeInsets.only(right: 30),
              onPressed: () async {
                image = await _picker.pickImage(source: ImageSource.gallery);
                setState(() {
                  image = image;
                });
              },
              icon: Icon(
                Icons.add_a_photo,
                color: Colors.redAccent,
                size: 40,
              )),
          Container(
            height: 56,
            width: MediaQuery.of(context).size.width / 2,
            margin: EdgeInsets.symmetric(horizontal: 30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(144, 255, 46, 46),
                  Color.fromARGB(143, 139, 10, 10),
                ],
              ),
            ),
            child: Center(
              child: Text(
                "Guncelle",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget button3() {
    return InkWell(
      onTap: () async {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (builder) => MotiveSozler()),
            (route) => false);
      },
      child: Row(
        children: [
          IconButton(
              padding: EdgeInsets.only(right: 30),
              onPressed: () async {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (builder) => MotiveSozler()),
                    (route) => false);
              },
              icon: Icon(
                Icons.wordpress_sharp,
                color: Colors.redAccent,
                size: 40,
              )),
          Container(
            height: 56,
            width: MediaQuery.of(context).size.width / 2,
            margin: EdgeInsets.symmetric(horizontal: 30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(144, 255, 46, 46),
                  Color.fromARGB(143, 139, 10, 10),
                ],
              ),
            ),
            child: Center(
              child: Text(
                "Motivasyon Cumleleri",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
