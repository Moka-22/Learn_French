import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:learnfrenchwithmsuibrahim/themes/colors.dart';
import 'package:learnfrenchwithmsuibrahim/themes/icons.dart';
import 'package:learnfrenchwithmsuibrahim/widgets/button_widget/button_widget.dart';
import 'package:learnfrenchwithmsuibrahim/widgets/text_widgets/primary_text_widget.dart';
import 'package:learnfrenchwithmsuibrahim/widgets/text_widgets/text_field_widget.dart';
import '../../screens/home_screen.dart';

class FillInfoScreenWidget extends StatefulWidget {
  const FillInfoScreenWidget({super.key});

  @override
  State<FillInfoScreenWidget> createState() => _FillInfoScreenWidgetState();
}

class _FillInfoScreenWidgetState extends State<FillInfoScreenWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  User? user = FirebaseAuth.instance.currentUser;
  File? _image;
  String? gender;
  String? year;
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Form(
      key: _formKey,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  TextWidget(
                    text: 'Enter Your Info',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: 20),
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
                        const SizedBox(
                          height: 5,
                        ),
                        GestureDetector(
                          onTap: _pickImage,
                          child: CircleAvatar(
                            radius: 60,
                            backgroundColor: iconsTextColor,
                            child: CircleAvatar(
                              radius: 58,
                              backgroundColor: Colors.grey[300],
                              backgroundImage: _image != null
                                  ? FileImage(_image!)
                                  : AssetImage('assets/images/avatar.png')
                                      as ImageProvider,
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
                        // email
                        TextFieldWidget(
                          prefixIcon: emailIcon,
                          initialValue: user!.email,
                          readOnly: true,
                          textInputType: TextInputType.emailAddress,
                          validator: (value) {
                            if (!(value!.contains('@') &&
                                value.contains('.') &&
                                value.length > 8)) {
                              return 'Email is not valid';
                            }
                            return null;
                          },
                        ),
                        // Phone
                        IntlPhoneField(
                          controller: _phoneController,
                          decoration: InputDecoration(
                            hintText: 'Phone Number',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: primaryColor,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: primaryColor,
                              ),
                            ),
                          ),

                          initialCountryCode: 'EG', // Egypt
                          onChanged: (phone) {
                            print(phone.completeNumber);
                          },
                        ),
                        // Select Year
                        DropdownButtonFormField<String>(
                          value: year,
                          decoration: InputDecoration(
                            hintText: 'Select Year',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: primaryColor,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: primaryColor,
                              ),
                            ),
                          ),
                          items: [
                            DropdownMenuItem(
                              value: '1 Secondary',
                              child: Text('1 Secondary'),
                            ),
                            DropdownMenuItem(
                              value: '2 Secondary',
                              child: Text('2 Secondary'),
                            ),
                            DropdownMenuItem(
                              value: '3 Secondary',
                              child: Text('3 Secondary'),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              year = value;
                            });
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'Year is required';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          readOnly: true,
                          onTap: () => _selectDate(context),
                          decoration: InputDecoration(
                            hintText: _selectedDate == null
                                ? 'Date of Birth'
                                : 'Date of Birth: ${DateFormat.yMMMd().format(_selectedDate!)}',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: primaryColor,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: primaryColor,
                              ),
                            ),
                          ),
                        ),
                        // Select Gender
                        DropdownButtonFormField<String>(
                          value: gender,
                          decoration: InputDecoration(
                            hintText: 'Select Gender',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: primaryColor,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: primaryColor,
                              ),
                            ),
                          ),
                          items: [
                            DropdownMenuItem(
                              value: 'Male',
                              child: Text('Male'),
                            ),
                            DropdownMenuItem(
                              value: 'Female',
                              child: Text('Female'),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              gender = value;
                            });
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'Gender is required';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 38),
                  // button
                  ButtonWidget(
                    text: 'Done',
                    onTap: _updateUserProfile,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _updateUserProfile() async {
    if (_formKey.currentState!.validate()) {
      try {
        if (user != null) {
          // Update display name and photoURL in FirebaseAuth
          await user?.updatePhotoURL(
            _image?.path,
          );
          await user?.updateDisplayName(
            _nameController.text,
          );
          // Save Data to Firebase Store
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user!.uid)
              .set({
            'displayName': _nameController.text,
            'email': user!.email,
            'phone': _phoneController.text,
            'gender': gender,
            'photoURL': _image?.path,
            'birthdate': _selectedDate,
            'year': year,
          });

          // Navigate to the home screen if the profile update is successful
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ),
          );
        }
      } catch (e) {
        // Handle profile update errors here
        print('Failed to update profile: $e');
      }
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void navigateToHome(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) {
          return HomeScreen();
        },
      ),
    );
  }
}
