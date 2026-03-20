import 'package:flutter/material.dart';

import 'package:mind2matterdemo/app/theme/app_colors.dart';
import 'package:mind2matterdemo/l10n/app_localizations.dart';
import '../../domain/entities/mood.dart';
import '../../domain/entities/mood_entry.dart';
import 'mood_face.dart';

class MoodEntryTile extends StatefulWidget {
  const MoodEntryTile({required this.entry, super.key});

  final MoodEntry entry;

  @override
  State<MoodEntryTile> createState() => _MoodEntryTileState();
}

class _MoodEntryTileState extends State<MoodEntryTile>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _scaleAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 360),
    );
    _scaleAnimation =
        TweenSequence<double>([
          TweenSequenceItem<double>(
            tween: Tween<double>(begin: 1, end: 1.12),
            weight: 1,
          ),
          TweenSequenceItem<double>(
            tween: Tween<double>(begin: 1.12, end: 1),
            weight: 1,
          ),
        ]).animate(
          CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
        );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _playTapAnimation() {
    _animationController
      ..reset()
      ..forward();
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context);
    final String formattedDate = MaterialLocalizations.of(
      context,
    ).formatCompactDate(widget.entry.date);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: _playTapAnimation,
        child: AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) {
            final double interactiveScale = _isHovered ? 1.05 : 1;
            return Transform.scale(
              scale: _scaleAnimation.value * interactiveScale,
              child: child,
            );
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOut,
            width: 144,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: widget.entry.mood.accentColor.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: widget.entry.mood.accentColor.withValues(
                  alpha: _isHovered ? 0.75 : 0.4,
                ),
              ),
              boxShadow: [
                BoxShadow(
                  color: widget.entry.mood.accentColor.withValues(
                    alpha: _isHovered ? 0.28 : 0.18,
                  ),
                  blurRadius: _isHovered ? 14 : 10,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MoodFace(
                  mood: widget.entry.mood,
                  size: 44,
                  animationValue: _isHovered
                      ? 0.45 + (_animationController.value * 0.55)
                      : _animationController.value,
                ),
                const SizedBox(height: 10),
                Text(
                  localizations.entryOnDate(
                    _labelForMood(localizations),
                    formattedDate,
                  ),
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: AppColors.text),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _labelForMood(AppLocalizations localizations) {
    switch (widget.entry.mood) {
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
