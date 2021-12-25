import 'package:flutter/material.dart';

enum DishType {
  BREAKFAST,
  STARTER,
  FIRSTCOURSE,
  SECONDCOURSE,
  SIDECOURSE,
  SWEETCOURSE
}

extension DishTypeExtension on DishType {
  int get index {
    switch (this) {
      case DishType.BREAKFAST:
        return 0;
      case DishType.STARTER:
        return 1;
      case DishType.FIRSTCOURSE:
        return 2;
      case DishType.SECONDCOURSE:
        return 3;
      case DishType.SIDECOURSE:
        return 4;
      case DishType.SWEETCOURSE:
        return 5;
      default:
        return -1;
    }
  }

  IconData get icon {
    switch (this) {
      case DishType.BREAKFAST:
        return Icons.free_breakfast;
      case DishType.STARTER:
        return Icons.food_bank;
      case DishType.FIRSTCOURSE:
        return Icons.dinner_dining;
      case DishType.SECONDCOURSE:
        return Icons.dining;
      case DishType.SIDECOURSE:
        return Icons.dinner_dining;
      case DishType.SWEETCOURSE:
        return Icons.bakery_dining;
      default:
        return Icons.dinner_dining;
    }
  }
}
