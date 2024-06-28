import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:learnfrenchwithmsuibrahim/widgets/themes_widget/image_widget.dart';

import '../../themes/icons.dart';
import '../button_widget/button_widget.dart';
import '../text_widgets/text_field_widget.dart';

class ForgetPasswordWidget extends StatefulWidget {
  const ForgetPasswordWidget({super.key});

  @override
  State<ForgetPasswordWidget> createState() => _ForgetPasswordWidgetState();
}

class _ForgetPasswordWidgetState extends State<ForgetPasswordWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  String? _email;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ImageWidget(),
            const SizedBox(height: 40),
            Row(
              children: [
                Text(
                  'Reset Password',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            TextFieldWidget(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Field is required';
                }
                return null;
              },
              prefixIcon: emailIcon,
              hintText: 'Enter Your Email',
              labelText: 'Email',
              onChanged: (value) {
                _email = value;
              },
            ),
            const SizedBox(height: 15),
            ButtonWidget(
              onTap: _handleSendEmail,
              text: 'Send Email',
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleSendEmail() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      try {
        await _resetPassword();
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Password reset email sent successfully')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to send password reset email: $e')),
        );
      }
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _resetPassword() async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: _email!);
  }
}
