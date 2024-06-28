import 'package:flutter/material.dart';

import '../models/favorites_model.dart';

class FavoritesProvider with ChangeNotifier {
  List<Favorite> _favorites = [];

  List<Favorite> get favorites => _favorites;

  void addFavorite(Favorite favorite) {
    _favorites.add(favorite);
    notifyListeners();
  }

  void removeFavorite(Favorite favorite) {
    _favorites.remove(favorite);
    notifyListeners();
  }
}
