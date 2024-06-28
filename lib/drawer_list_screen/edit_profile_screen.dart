import 'package:flutter/material.dart';

import '../widgets/drawer_widget/edit_profile_widget.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Profile',
        ),
        centerTitle: true,
      ),
      body: EditProfileWidget(),
    );
  }
}
