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

class _MoodButton extends StatefulWidget {
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
  State<_MoodButton> createState() => _MoodButtonState();
}

class _MoodButtonState extends State<_MoodButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final bool isActive = widget.isSelected || _isHovered;

    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () => widget.onTap(widget.mood),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: AnimatedScale(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          scale: _isHovered ? 1.03 : 1,
          child: RepaintBoundary(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeOut,
              decoration: BoxDecoration(
                color: isActive
                    ? widget.mood.accentColor.withValues(alpha: 0.20)
                    : widget.mood.accentColor.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isActive
                      ? widget.mood.accentColor.withValues(alpha: 0.9)
                      : widget.mood.accentColor.withValues(alpha: 0.3),
                  width: 1.5,
                ),
                boxShadow: isActive
                    ? [
                        BoxShadow(
                          color: widget.mood.accentColor.withValues(
                            alpha: 0.25,
                          ),
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
                    AnimatedRotation(
                      duration: const Duration(milliseconds: 200),
                      turns: _isHovered ? 0.03 : 0,
                      child: Icon(
                        widget.icon,
                        color: widget.mood.accentColor,
                        size: 20,
                      ),
                    ),
                    const SizedBox(height: 8),
                    AnimatedScale(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeOut,
                      scale: _isHovered ? 1.08 : 1,
                      child: TweenAnimationBuilder<double>(
                        tween: Tween<double>(
                          begin: 0,
                          end: widget.isSelected
                              ? 0.22
                              : _isHovered
                              ? 0.16
                              : 0,
                        ),
                        duration: const Duration(milliseconds: 230),
                        curve: Curves.easeOut,
                        builder: (context, value, child) {
                          return MoodFace(
                            mood: widget.mood,
                            size: 44,
                            animationValue: value,
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.label,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: isActive ? AppColors.text : AppColors.mutedText,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
