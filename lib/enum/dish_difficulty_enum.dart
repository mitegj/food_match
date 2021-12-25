import 'package:flutter/material.dart';

enum DishDifficulty { Facile, Intermedio, Difficile }

extension DishDifficultyExtension on DishDifficulty {
  int get index {
    switch (this) {
      case DishDifficulty.Facile:
        return 0;
      case DishDifficulty.Intermedio:
        return 1;
      case DishDifficulty.Difficile:
        return 2;
      default:
        return -1;
    }
  }
}
