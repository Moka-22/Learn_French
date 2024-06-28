import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:learnfrenchwithmsuibrahim/provider/favorites_provider.dart';
import 'package:learnfrenchwithmsuibrahim/provider/provider.dart';
import 'package:learnfrenchwithmsuibrahim/screens/splash_screen.dart';
import 'package:learnfrenchwithmsuibrahim/services/notification_service.dart';
import 'package:learnfrenchwithmsuibrahim/themes/colors.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await NotificationService.initialize();


  runApp(
      MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_)=> FavoritesProvider(),),
          ],
          child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => uiProvider()..init(),
      child:
          Consumer<uiProvider>(builder: (context, uiProvider notifier, child) {
        return MaterialApp(
          themeMode: notifier.isDark ? ThemeMode.dark : ThemeMode.light,
          darkTheme: notifier.isDark ? notifier.darkTheme : notifier.lightTheme,
          theme: ThemeData(
            appBarTheme: AppBarTheme(color: primaryColor),
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
            useMaterial3: true,
          ),
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
        );
      }),
    );
  }
}
