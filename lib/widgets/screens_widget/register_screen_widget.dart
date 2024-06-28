import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../screens/login_screen.dart';
import '../../themes/colors.dart';
import '../../themes/icons.dart';
import '../button_widget/button_widget.dart';
import '../text_widgets/primary_text_widget.dart';
import '../text_widgets/text_field_widget.dart';
import '../themes_widget/image_widget.dart';

class RegisterScreenWidget extends StatefulWidget {
  const RegisterScreenWidget({
    super.key,
  });

  @override
  State<RegisterScreenWidget> createState() => _RegisterScreenWidgetState();
}

class _RegisterScreenWidgetState extends State<RegisterScreenWidget> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  bool isObscure = true;
  bool isObscureAnother = true;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: ListView(
            children: [
              const SizedBox(
                height: 60,
              ),
              // Logo
              const ImageWidget(),
              const SizedBox(
                height: 30,
              ),
              // Welcome Text
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const TextWidget(
                    text: 'Bienvenue',
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  const TextWidget(
                    text: 'مرحبا',
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
              // Login Text
              const Row(
                children: [
                  // Register Text
                  TextWidget(
                    text: 'Register',
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              // Enter Your Email Field
              TextFieldWidget(
                controller: emailController,
                textInputType: TextInputType.emailAddress,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Field is required';
                  }
                  if (value!.length < 6) {
                    return 'Email should be at least 6 characters';
                  }
                  return null;
                },
                hintText: 'Email',
                labelText: 'Enter Your Email',
                prefixIcon: emailIcon,
              ),
              const SizedBox(
                height: 15,
              ),
              // Enter your Password Field
              TextFieldWidget(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Field is required';
                  }
                  if (value.length < 8) {
                    return 'Password should be at least 8 characters';
                  }
                  return null;
                },
                obscureText: isObscure,
                controller: passwordController,
                hintText: 'Password',
                labelText: 'Enter Your Password',
                prefixIcon: passwordIcon,
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      isObscure = !isObscure;
                    });
                  },
                  icon: isObscure ? passwordIconEyeOff : passwordIconEyeOn,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              // Confirm Password
              TextFieldWidget(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Field is required';
                  }
                  if (value != passwordController.text) {
                    return 'Password doesn\'t match';
                  }
                  return null;
                },
                obscureText: isObscureAnother,
                controller: confirmPasswordController,
                hintText: 'Confirm Password',
                labelText: 'Confirm Your Password',
                prefixIcon: passwordIcon,
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      isObscureAnother = !isObscureAnother;
                    });
                  },
                  icon:
                      isObscureAnother ? passwordIconEyeOff : passwordIconEyeOn,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              // Button
              ButtonWidget(
                onTap: () async {
                  if (formKey.currentState!.validate() &&
                      passwordController.text ==
                          confirmPasswordController.text) {
                    _showLoadingDialog();
                    try {
                      String email = emailController.text;
                      await _auth.createUserWithEmailAndPassword(
                        email: email,
                        password: passwordController.text,
                      );
                      _hideLoadingDialog();

                      // Navigate to home screen after successful sign in
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => LoginScreen(),
                        ),
                      );
                    } catch (e) {
                      _hideLoadingDialog();
                      ScaffoldMessenger.of(context).removeCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red,
                          content: Text(
                              'The email address is already in use (Sign in)'),
                        ),
                      );
                    }
                  }
                },
                text: 'Register',
              ),
              const SizedBox(
                height: 10,
              ),
              // Navigator to Register Page
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Text
                  TextWidget(text: 'Already have an account ?'),
                  const SizedBox(
                    width: 10,
                  ),
                  // Text Tab
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => LoginScreen(),
                        ),
                      );
                    },
                    child: TextWidget(
                      text: 'Login',
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void initState() {
    super.initState();
  }

  void _showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 20),
              Text("Signing up..."),
            ],
          ),
        );
      },
    );
  }

  void _hideLoadingDialog() {
    Navigator.of(context).pop();
  }
}
