import 'package:flutter_riverpod/flutter_riverpod.dart';

class SavedMovie extends StateNotifier<List<String>> {
  SavedMovie() : super([]);

  void add(String id) {
    state = [...state, id];
  }

  void remove(String id) {
    state = state.where((media) => media != id).toList();
  }
}

final savedMovieProvider = StateNotifierProvider<SavedMovie, List<String>>(
  (ref) => SavedMovie(),
);
