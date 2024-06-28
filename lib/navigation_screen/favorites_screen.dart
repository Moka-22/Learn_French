import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:learnfrenchwithmsuibrahim/themes/icons.dart';
import 'package:learnfrenchwithmsuibrahim/widgets/text_widgets/primary_text_widget.dart';
import 'package:provider/provider.dart';

import '../provider/favorites_provider.dart';
import '../sections_screens/pdf_screen.dart';
import '../themes/colors.dart';

class FavoritesScreen extends StatefulWidget {
  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<FavoritesProvider>(
        builder: (context, provider, child) {
          return ListView.builder(
            itemCount: provider.favorites.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  color: backGroundColor,
                  child: ListTile(
                    title: TextWidget(
                      text: provider.favorites[index].name,
                      color: Colors.black,
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        provider.removeFavorite(provider.favorites[index]);
                      },
                      icon: favoriteIcon,
                    ),
                    onTap: () async {
                      final storageRef = FirebaseStorage.instance.ref('');
                      final fileRef =
                          storageRef.child(provider.favorites[index].url);
                      final url = await fileRef.getDownloadURL();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PdfScreen(
                            url: url,
                            pdfName: provider.favorites[index].name,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
