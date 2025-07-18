import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

class WatchedShowNotifier extends StateNotifier<List<String>> {
  static const _watchedShows = "watchedShows";
  WatchedShowNotifier() : super([]) {
    _loadShowsList();
  }

  Future<void> _loadShowsList() async {
    final box = Hive.box(_watchedShows);
    final savedList = box.get('list', defaultValue: []);
    state = savedList ?? [];
  }

  void addWatchedShow(String id) {
    state = [...state, id];
    _saveToHive();
  }

  void removeWatchedShow(String id) {
    state = state.where((element) => element != id).toList();
    _saveToHive();
  }

  void _saveToHive() {
    final box = Hive.box(_watchedShows);
    box.put('list', state);
  }
}

class PlannedShowNotifer extends StateNotifier<List<String>> {
  static const _plannedShows = "plannedShows";

  PlannedShowNotifer() : super([]) {
    _loadShowsList();
  }

  Future<void> _loadShowsList() async {
    final box = Hive.box(_plannedShows);
    final savedList = box.get('list', defaultValue: []);
    state = savedList ?? [];
  }

  void addPlannedShow(String id) {
    state = [...state, id];
    _saveToHive();
  }

  void removePlannedShow(String id) {
    state = state.where((element) => element != id).toList();
    _saveToHive();
  }

  void _saveToHive() {
    final box = Hive.box(_plannedShows);
    box.put('list', state);
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
