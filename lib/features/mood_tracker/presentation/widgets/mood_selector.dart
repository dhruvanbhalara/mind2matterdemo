import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import 'package:mind2matterdemo/l10n/app_localizations.dart';
import '../../domain/entities/mood.dart';
import 'mood_face.dart';

class MoodSelector extends StatelessWidget {
  const MoodSelector({required this.onMoodSelected, super.key});

  final ValueChanged<Mood> onMoodSelected;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        for (final Mood mood in Mood.values)
          SizedBox(
            width: 112,
            child: _MoodButton(
              icon: _iconForMood(mood),
              label: _labelForMood(AppLocalizations.of(context), mood),
              mood: mood,
              onTap: onMoodSelected,
            ),
          ),
      ],
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
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Mood mood;
  final ValueChanged<Mood> onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () => onTap(mood),
      child: Ink(
        decoration: BoxDecoration(
          color: mood.accentColor.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: mood.accentColor.withValues(alpha: 0.35)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: mood.accentColor, size: 20),
              const SizedBox(height: 8),
              MoodFace(mood: mood, size: 48),
              const SizedBox(height: 8),
              Text(label),
            ],
          ),
        ),
      ),
    );
  }
}
