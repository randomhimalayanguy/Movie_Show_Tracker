import 'package:flutter_riverpod/flutter_riverpod.dart';

class WatchedShowNotifier extends StateNotifier<List<String>> {
  WatchedShowNotifier() : super([]);

  void addWatchedShow(String id) {
    state = [...state, id];
  }

  void removeWatchedShow(String id) {
    state = state.where((element) => element != id).toList();
  }
}

class PlannedShowNotifer extends StateNotifier<List<String>> {
  PlannedShowNotifer() : super([]);

  void addPlannedShow(String id) {
    state = [...state, id];
  }

  void removePlannedShow(String id) {
    state = state.where((element) => element != id).toList();
  }
}

final watchedShowProvider =
    StateNotifierProvider<WatchedShowNotifier, List<String>>(
      (ref) => WatchedShowNotifier(),
    );

final plannedShowProvider =
    StateNotifierProvider<PlannedShowNotifer, List<String>>(
      (ref) => PlannedShowNotifer(),
    );
