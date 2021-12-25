enum DishDifficulty { EASY, INTERMEDIATE, HARD }

extension DishDifficultyExtension on DishDifficulty {
  int get index {
    switch (this) {
      case DishDifficulty.EASY:
        return 0;
      case DishDifficulty.INTERMEDIATE:
        return 1;
      case DishDifficulty.HARD:
        return 2;
      default:
        return -1;
    }
  }
}
