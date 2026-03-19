import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mind2matterdemo/app/theme/app_colors.dart';
import 'package:mind2matterdemo/l10n/app_localizations.dart';

import '../../domain/entities/mood.dart';
import 'mood_face.dart';

class MoodSelector extends StatelessWidget {
  const MoodSelector({
    required this.onMoodSelected,
    super.key,
    this.selectedMood,
  });

  final ValueChanged<Mood> onMoodSelected;
  final Mood? selectedMood;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final int columns = constraints.maxWidth > 900
            ? 7
            : constraints.maxWidth > 640
            ? 4
            : 2;
        final double totalSpacing = (columns - 1) * 12;
        final double itemWidth =
            (constraints.maxWidth - totalSpacing) / columns;

        return Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            for (final Mood mood in Mood.values)
              SizedBox(
                width: itemWidth,
                child: _MoodButton(
                  icon: _iconForMood(mood),
                  label: _labelForMood(AppLocalizations.of(context), mood),
                  mood: mood,
                  isSelected: selectedMood == mood,
                  onTap: onMoodSelected,
                ),
              ),
          ],
        );
      },
    );
  }

  IconData _iconForMood(Mood mood) {
    switch (mood) {
      case Mood.happy:
        return LucideIcons.smile;
      case Mood.excited:
        return LucideIcons.partyPopper;
      case Mood.calm:
        return LucideIcons.leaf;
      case Mood.neutral:
        return LucideIcons.circleDashed;
      case Mood.anxious:
        return LucideIcons.alertTriangle;
      case Mood.sad:
        return LucideIcons.cloudRain;
      case Mood.tired:
        return LucideIcons.moon;
    }
  }

  String _labelForMood(AppLocalizations localizations, Mood mood) {
    switch (mood) {
      case Mood.happy:
        return localizations.moodHappy;
      case Mood.excited:
        return localizations.moodExcited;
      case Mood.calm:
        return localizations.moodCalm;
      case Mood.neutral:
        return localizations.moodNeutral;
      case Mood.anxious:
        return localizations.moodAnxious;
      case Mood.sad:
        return localizations.moodSad;
      case Mood.tired:
        return localizations.moodTired;
    }
  }
}

class _MoodButton extends StatelessWidget {
  const _MoodButton({
    required this.icon,
    required this.label,
    required this.mood,
    required this.isSelected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Mood mood;
  final bool isSelected;
  final ValueChanged<Mood> onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () => onTap(mood),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          color: isSelected
              ? mood.accentColor.withValues(alpha: 0.20)
              : mood.accentColor.withValues(alpha: 0.10),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? mood.accentColor.withValues(alpha: 0.9)
                : mood.accentColor.withValues(alpha: 0.3),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: mood.accentColor.withValues(alpha: 0.25),
                    blurRadius: 14,
                    offset: const Offset(0, 6),
                  ),
                ]
              : const [],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: mood.accentColor, size: 20),
              const SizedBox(height: 8),
              MoodFace(mood: mood, size: 44),
              const SizedBox(height: 8),
              Text(
                label,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: isSelected ? AppColors.text : AppColors.mutedText,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
