import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:learnfrenchwithmsuibrahim/screens/fill_info_screen.dart';
import 'package:learnfrenchwithmsuibrahim/screens/forget_password_screen.dart';
import '../../screens/home_screen.dart';
import '../../screens/resgister_screen.dart';
import '../../themes/colors.dart';
import '../../themes/icons.dart';
import '../button_widget/button_widget.dart';
import '../text_widgets/primary_text_widget.dart';
import '../text_widgets/text_field_widget.dart';
import '../themes_widget/image_widget.dart';

class LoginScreenWidget extends StatefulWidget {
  const LoginScreenWidget({super.key});

  @override
  State<LoginScreenWidget> createState() => _LoginScreenWidgetState();
}

class _LoginScreenWidgetState extends State<LoginScreenWidget> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isLoading = false;
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: ListView(
            children: [
              const SizedBox(height: 75),
              const ImageWidget(),
              const SizedBox(height: 30),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  TextWidget(
                    text: 'Bienvenue',
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  TextWidget(
                    text: 'مرحبا',
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
              const Row(
                children: [
                  TextWidget(
                    text: 'Login',
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
              const SizedBox(height: 15),
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
              const SizedBox(height: 15),
              TextFieldWidget(
                controller: passwordController,
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
              const SizedBox(height: 15),
              ButtonWidget(
                onTap: _login,
                text: 'Login',
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ForgetPasswordScreen(),
                        ),
                      );
                    },
                    child: TextWidget(
                      text: 'Forget Password?',
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextWidget(text: 'Don\'t have an account ?'),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => RegisterScreen(),
                        ),
                      );
                    },
                    child: TextWidget(
                      text: 'Register',
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

  @override
  void initState() {
    super.initState();
  }

  void _login() async {
    if (!formKey.currentState!.validate()) return;

    _showLoadingDialog();

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      User? user = userCredential.user;
      if (user == null) {
        _hideLoadingDialog();
        _showError('Failed to sign in');
        return;
      }

      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(user.uid).get();

      if (userDoc.exists) {
        Map<String, dynamic>? userData =
            userDoc.data() as Map<String, dynamic>?;
        bool isInfoFilled = userData?['isInfoFilled'] ?? false;

        _hideLoadingDialog();
        if (userDoc.exists || isInfoFilled) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => HomeScreen()),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => FillInfoScreen()),
          );
        }
      } else {
        // If the user document does not exist, assume it's a new user
        await _firestore
            .collection('users')
            .doc(user.uid)
            .set({'isInfoFilled': false});
        _hideLoadingDialog();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => FillInfoScreen()),
        );
      }
    } catch (e) {
      _hideLoadingDialog();
      _showError('Failed to sign in: ${e.toString()}');
    }
  }

  void _showLoadingDialog() {
    setState(() {
      isLoading = true;
    });
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 20),
              Text("Signing in..."),
            ],
          ),
        );
      },
    );
  }

  void _hideLoadingDialog() {
    if (isLoading) {
      setState(() {
        isLoading = false;
      });
      Navigator.of(context).pop();
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text(message),
      ),
    );
  }
}
