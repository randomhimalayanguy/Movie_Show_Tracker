import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final curTypeProvider = StateProvider<bool>((ref) => true);

final themeProvider = StateProvider<ThemeData>((ref) => ThemeData.light());
