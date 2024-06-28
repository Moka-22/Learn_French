import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:learnfrenchwithmsuibrahim/drawer_list_screen/settings_screen.dart';
import '../../drawer_list_screen/about_us_screen.dart';
import '../../drawer_list_screen/contact_us_screen.dart';
import '../../drawer_list_screen/edit_profile_screen.dart';
import '../../screens/login_screen.dart';
import '../../themes/colors.dart';
import '../../themes/icons.dart';
import '../text_widgets/primary_text_widget.dart';

class MenuDrawer extends StatefulWidget {
  const MenuDrawer({
    super.key,
  });

  @override
  State<MenuDrawer> createState() => _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Drawer(
      backgroundColor: isDarkMode ? Colors.black : backGroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              DrawerHeader(
                child: Center(
                  child: Column(
                    children: [
                      // Pic
                      CircleAvatar(
                        radius: 68,
                        backgroundImage: user!.photoURL != null
                            ? (user!.photoURL!.contains('http')
                                ? NetworkImage(user!.photoURL!)
                                : FileImage(File(user!.photoURL!))
                                    as ImageProvider<Object>)
                            : const AssetImage('assets/images/avatar.png')
                                as ImageProvider<Object>,
                      ),
                    ],
                  ),
                ),
              ),
              // Home
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  title: TextWidget(
                    text: 'Home',
                    fontWeight: FontWeight.bold,
                  ),
                  leading: homeIcon,
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              // Edit Profile
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  title: TextWidget(
                    text: 'Edit Profile',
                    fontWeight: FontWeight.bold,
                  ),
                  leading: editProfileIcon,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => EditProfileScreen(),
                      ),
                    );
                  },
                ),
              ),
              // About Us
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  title: TextWidget(
                    text: 'AboutUs',
                    fontWeight: FontWeight.bold,
                  ),
                  leading: aboutUsIcon,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => AboutUsScreen(),
                      ),
                    );
                  },
                ),
              ),
              // Contact Us
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  title: TextWidget(
                    text: 'ContactUs',
                    fontWeight: FontWeight.bold,
                  ),
                  leading: contactUsIcon,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ContactUsScreen(),
                      ),
                    );
                  },
                ),
              ),
              // Settings
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  title: TextWidget(
                    text: 'Settings',
                    fontWeight: FontWeight.bold,
                  ),
                  leading: settingIcon,
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => SettingsScreen()));
                  },
                ),
              ),
            ],
          ),
          // Logout
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: ListTile(
              title: TextWidget(
                text: 'Logout',
                fontWeight: FontWeight.bold,
              ),
              leading: logOutIcon,
              onTap: () {
                _signOut(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _signOut(BuildContext context) async {
    if (FirebaseAuth.instance.currentUser != null) {
      await FirebaseAuth.instance.signOut();
    }
    Navigator.of(context).pop();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => LoginScreen()));
  }


}
