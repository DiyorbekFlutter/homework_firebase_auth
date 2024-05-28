import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:homework_firebase_auth/auth_sevice.dart';
import 'package:homework_firebase_auth/button.dart';
import 'package:homework_firebase_auth/path_provider_service.dart';
import 'package:image_picker/image_picker.dart';

import '../delete_profile_image_dialog.dart';
import '../get_image_from_phone.dart';
import '../profile_custom_modal_bottom_sheet.dart';

class HomePage extends StatefulWidget {
  final User user;
  const HomePage({required this.user, super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int number;
  bool lateException = false;
  bool hasCrash = false;
  bool networkImageException = false;

  String? profileImagePath;

  @override
  void initState(){
    super.initState();
    getImagePath();
  }

  Future<void> getImagePath() async {
    String? location = await StorageService.getLocation;
    String path = StorageService.readFile("$location/profile_image.txt");

    if(path.isNotEmpty){
      profileImagePath = path;
      setState((){});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: const Text('Home Page',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if(hasCrash)
                const SizedBox(height: 200),

              InkWell(
                onTap: () => profileCustomModalBottomSheet(
                    context: context,
                    profileImagePath: profileImagePath,
                    pressedGallery: () async {
                      await getImageFromPhone(context, ImageSource.gallery);
                      getImagePath();
                    },
                    pressedCamera: () async {
                      await getImageFromPhone(context, ImageSource.camera);
                      getImagePath();
                    },
                    closeBottomSheetAndOpenDialog: () async {
                      Navigator.pop(context);
                      if(await deleteProfileImageDialog(context, profileImagePath!)){
                        profileImagePath = null;
                        setState(() {});
                      }
                    }
                ),
                child: CircleAvatar(
                  radius: 60,
                  foregroundImage: profileImagePath != null ? Image.file(File(profileImagePath!)).image : null,
                ),
              ),

              const SizedBox(height: 20),
              Text("Firstname: ${widget.user.displayName.toString().split('/')[0]}"),
              Text("Lastname: ${widget.user.displayName.toString().split('/')[1]}"),
              Text("Email: ${widget.user.email}"),
              Text("UID: ${widget.user.uid}"),
              const SizedBox(height: 10),
              Button(
                text: "Logout",
                onPressed: () async => await AuthService.logout(),
              ),
              Button(
                marginTop: 5,
                text: "Delete account",
                onPressed: () async => await AuthService.deleteAccount(),
              ),
              Button(
                marginTop: 5,
                text: "Throw test exception",
                onPressed: () => throw Exception("Prosta exaption chiqardim xolos"),
              ),
              Button(
                marginTop: 5,
                text: "Crash",
                onPressed: () async {
                  hasCrash = true;
                  setState(() {});
                  await Future.delayed(const Duration(seconds: 5));
                  hasCrash = false;
                  setState(() {});
                },
              ),
              Button(
                marginTop: 5,
                text: "Network image exception",
                onPressed: () async {
                  networkImageException = true;
                  setState(() {});
                  await Future.delayed(const Duration(seconds: 5));
                  networkImageException = false;
                  setState(() {});
                },
              ),
              Button(
                marginTop: 5,
                text: "'number' has not been initialized.",
                onPressed: () async {
                  lateException = true;
                  setState(() {});
                  await Future.delayed(const Duration(seconds: 3));
                  lateException = false;
                  setState(() {});
                },
              ),
              const SizedBox(height: 50),

              if(lateException)
                ...[
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.red),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text("Late number is: $number"),
                  )
                ],

              if(networkImageException)
                ...[
                  const SizedBox(height: 20),
                  Image.network("no url")
                ],

              if(hasCrash)
                Container(
                  height: 300,
                  width: 200,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: 40),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: const Text("This is crash", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                )
            ],
          ),
        ),
      )
    );
  }
}
