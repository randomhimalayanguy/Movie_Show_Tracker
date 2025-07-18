import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

class WatchedMovieNotifier extends StateNotifier<List<String>> {
  static const _watchedMovieKey = "watchedMovies";

  WatchedMovieNotifier() : super([]) {
    loadWatchedMovies();
  }

  Future<void> loadWatchedMovies() async {
    final box = Hive.box(_watchedMovieKey);
    final storedList = box.get('list', defaultValue: []);
    state = storedList ?? [];
  }

  void addWatchedMovie(String id) {
    state = [...state, id];
    _saveToHive();
  }

  void removeWatchedMovie(String id) {
    state = state.where((element) => element != id).toList();
    _saveToHive();
  }

  void _saveToHive() {
    final box = Hive.box(_watchedMovieKey);
    box.put('list', state);
  }
}

class PlannedMovieNotifer extends StateNotifier<List<String>> {
  static const _plannedMovies = "plannedMovies";

  PlannedMovieNotifer() : super([]) {
    _loadPlannedMovies();
  }

  Future<void> _loadPlannedMovies() async {
    final box = Hive.box(_plannedMovies);
    final storedList = box.get('list', defaultValue: []);
    state = storedList ?? [];
  }

  void addPlannedMovie(String id) {
    state = [...state, id];
    _saveToHive();
  }

  void removePlannedMovie(String id) {
    state = state.where((element) => element != id).toList();
    _saveToHive();
  }

  void _saveToHive() {
    final box = Hive.box(_plannedMovies);
    box.put('list', state);
  }
}

final watchedMovieProvider =
    StateNotifierProvider<WatchedMovieNotifier, List<String>>(
      (ref) => WatchedMovieNotifier(),
    );

final plannedMovieProvider =
    StateNotifierProvider<PlannedMovieNotifer, List<String>>(
      (ref) => PlannedMovieNotifer(),
    );
