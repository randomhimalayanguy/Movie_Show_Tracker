import 'package:flutter_riverpod/flutter_riverpod.dart';

class WatchedMovieNotifier extends StateNotifier<List<String>> {
  WatchedMovieNotifier() : super([]);

  void addWatchedMovie(String id) {
    state = [...state, id];
  }

  void removeWatchedMovie(String id) {
    state = state.where((element) => element != id).toList();
  }
}

class PlannedMovieNotifer extends StateNotifier<List<String>> {
  PlannedMovieNotifer() : super([]);

  void addPlannedMovie(String id) {
    state = [...state, id];
  }

  void removePlannedMovie(String id) {
    state = state.where((element) => element != id).toList();
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
