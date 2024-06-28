import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learnfrenchwithmsuibrahim/widgets/text_widgets/text_field_widget.dart';

import '../../screens/home_screen.dart';
import '../../themes/colors.dart';
import '../../themes/icons.dart';
import '../button_widget/button_widget.dart';

class EditProfileWidget extends StatefulWidget {
  const EditProfileWidget({super.key});

  @override
  State<EditProfileWidget> createState() => _EditProfileWidgetState();
}

class _EditProfileWidgetState extends State<EditProfileWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  User? user = FirebaseAuth.instance.currentUser;
  File? _image;
  String? gender;
  String? phone;
  String? displayName;
  String? photoURL;
  String? phoneNumber;
  String? _imagePath;
  String? year;
  String? birthDate;

  @override
  void initState() {
    super.initState();
    _nameController.text = user!.displayName ?? '';
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _imagePath = pickedFile.path;
      });
    }
  }

  Future<void> _updateUserProfile() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Update user profile in Firebase Authentication
        await user?.updateDisplayName(_nameController.text);
        await user
            ?.updatePhotoURL(_imagePath != null ? _imagePath : user!.photoURL);

        // Update user profile in Firestore
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .update({
          'displayName': _nameController.text,
          'photoURL': _imagePath != null ? _imagePath : user!.photoURL,
        });

        // Navigate to HomeScreen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
        );
      } catch (e) {
        // Handle profile update errors here
        print('Failed to update profile: $e');
      }
    }
  }

  Future<Map<String, dynamic>> _fetchUserProfile() async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .get();

      if (userDoc.exists) {
        print('User document exists.');
        print('Document data: ${userDoc.data()}');

        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;

        // Convert Timestamp to String
        if (userData['birthdate'] != null &&
            userData['birthdate'] is Timestamp) {
          Timestamp timestamp = userData['birthdate'];
          DateTime date = timestamp.toDate();
          userData['birthdate'] = "${date.day}-${date.month}-${date.year}";
        }

        return userData;
      } else {
        print('User document does not exist.');
        return {};
      }
    } catch (e) {
      print('Error fetching user profile: $e');
      return {};
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return FutureBuilder<Map<String, dynamic>>(
      future: _fetchUserProfile(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error fetching user profile'));
        }

        if (snapshot.hasData) {
          final userProfileData = snapshot.data!;
          phoneNumber = userProfileData['phone'];
          gender = userProfileData['gender'];
          year = userProfileData['year'];
          birthDate = userProfileData['birthdate'];
          phone = '0' + (phoneNumber ?? '');

          return Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.all(8),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 680,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: isDarkMode ? Colors.deepPurple : backGroundColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(height: 5),
                          GestureDetector(
                            onTap: _pickImage,
                            child: CircleAvatar(
                              radius: 60,
                              backgroundColor: iconsTextColor,
                              child: CircleAvatar(
                                radius: 58,
                                backgroundColor: Colors.grey[300],
                                backgroundImage: _imagePath != null
                                    ? FileImage(File(_imagePath!))
                                    : user!.photoURL != null
                                        ? user!.photoURL!.contains('http')
                                            ? NetworkImage(user!.photoURL!)
                                            : FileImage(File(user!.photoURL!))
                                                as ImageProvider
                                        : AssetImage(
                                            'assets/images/avatar.png'),
                                child: _image == null
                                    ? Icon(Icons.camera_alt,
                                        color: Colors.grey[800], size: 50)
                                    : null,
                              ),
                            ),
                          ),
                          // Name
                          TextFieldWidget(
                            prefixIcon: aboutUsIcon,
                            hintText: 'Enter Your Name',
                            controller: _nameController,
                            textInputType: TextInputType.text,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Field is required';
                              }
                              return null;
                            },
                          ),
                          // Email
                          TextFieldWidget(
                            prefixIcon: emailIcon,
                            initialValue: user!.email ??
                                user!.providerData[0].email ??
                                'Email',
                            readOnly: true,
                            textInputType: TextInputType.emailAddress,
                          ),
                          // Phone
                          TextFieldWidget(
                            readOnly: true,
                            prefixIcon: Icon(Icons.phone_android_outlined),
                            initialValue: phone ?? 'phone',
                          ),
                          // Birthday
                          TextFieldWidget(
                            readOnly: true,
                            prefixIcon: Icon(FontAwesomeIcons.cakeCandles),
                            initialValue: birthDate ?? 'birthdate',
                          ),
                          // Year
                          TextFieldWidget(
                            readOnly: true,
                            prefixIcon: Icon(FontAwesomeIcons.school),
                            initialValue: year ?? 'year',
                          ),
                          // Select Gender
                          TextFieldWidget(
                            readOnly: true,
                            prefixIcon: aboutUsIcon,
                            initialValue: gender ?? 'gender',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    // Button
                    ButtonWidget(
                      text: 'Update',
                      onTap: _updateUserProfile,
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        return Center(child: Text('No user profile data available'));
      },
    );
  }
}
