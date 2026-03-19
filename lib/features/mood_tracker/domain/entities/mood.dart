import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';

enum Mood { happy, excited, calm, neutral, anxious, sad, tired }

extension MoodStyle on Mood {
  Color get accentColor {
    switch (this) {
      case Mood.happy:
        return AppColors.happy;
      case Mood.excited:
        return AppColors.excited;
      case Mood.calm:
        return AppColors.calm;
      case Mood.neutral:
        return AppColors.neutral;
      case Mood.anxious:
        return AppColors.anxious;
      case Mood.sad:
        return AppColors.sad;
      case Mood.tired:
        return AppColors.tired;
    }
  }
}
