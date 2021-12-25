import 'package:flutter/material.dart';

enum DishType { Colazione, Primo, Secondo, Contorno, Dolce }

extension DishTypeExtension on DishType {
  int get index {
    switch (this) {
      case DishType.Colazione:
        return 0;
      case DishType.Primo:
        return 1;
      case DishType.Secondo:
        return 2;
      case DishType.Contorno:
        return 3;
      case DishType.Dolce:
        return 4;
      default:
        return -1;
    }
  }

  IconData get icon {
    switch (this) {
      case DishType.Colazione:
        return Icons.free_breakfast;
      case DishType.Primo:
        return Icons.dinner_dining;
      case DishType.Secondo:
        return Icons.dining;
      case DishType.Contorno:
        return Icons.dinner_dining;
      case DishType.Dolce:
        return Icons.bakery_dining;
      default:
        return Icons.dinner_dining;
    }
  }
}
