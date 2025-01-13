import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_firebase/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

Widget buildDrawer() {
  final user = FirebaseAuth.instance.currentUser;

  return Drawer(
    child: Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          color: Colors.green,
          child: Column(
            children: [
              SizedBox(height: 30),
              CircleAvatar(
                radius: 40,
                backgroundColor: Colors.orange,
                child: Icon(
                  Icons.person,
                  size: 40,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Text(
                user?.displayName ?? 'User',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'ID: ${user?.uid.substring(0, 3) ?? '000'}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        ListTile(
          leading: Icon(Icons.logout),
          title: Text('Log out'),
          onTap: () async {
            await GoogleSignIn().signOut();
            await FirebaseAuth.instance.signOut();
            Get.delete<HomeController>(force: true);
            Get.offAllNamed(Routes.auth);
          },
        ),
      ],
    ),
  );
}
