import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class FavoritesState {
  final Set<int> favorites;
  FavoritesState(this.favorites);
}

class FavoritesCubit extends Cubit<FavoritesState> {
  static const _key = 'favorites_ids';
  FavoritesCubit() : super(FavoritesState({})) {
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = prefs.getString(_key);
    if (jsonStr != null) {
      final List<dynamic> list = json.decode(jsonStr);
      final Set<int> ids = list.map((e) => (e as num).toInt()).toSet();
      emit(FavoritesState(ids));
    }
  }

  Future<void> toggleFavorite(int productId) async {
    final current = Set<int>.from(state.favorites);
    if (current.contains(productId)) {
      current.remove(productId);
    } else {
      current.add(productId);
    }
    emit(FavoritesState(current));
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, json.encode(current.toList()));
  }

  bool isFavorite(int productId) {
    return state.favorites.contains(productId);
  }
}
