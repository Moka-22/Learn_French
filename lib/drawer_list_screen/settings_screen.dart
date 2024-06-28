import 'package:flutter/material.dart';
import 'package:learnfrenchwithmsuibrahim/provider/provider.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
        ),
        centerTitle: true,
      ),
      body:
          Consumer<uiProvider>(builder: (context, uiProvider notifier, child) {
        return Column(
          children: [
            ListTile(
              leading: Icon(Icons.dark_mode),
              title: Text('Dark Mode'),
              trailing: Switch(
                value: notifier.isDark,
                onChanged: (value) => notifier.changeTheme(),
              ),
            ),
          ],
        );
      }),
    );
  }
}
