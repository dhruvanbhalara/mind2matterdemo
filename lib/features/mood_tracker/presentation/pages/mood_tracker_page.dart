import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mind2matterdemo/app/theme/app_colors.dart';
import 'package:mind2matterdemo/l10n/app_localizations.dart';

import '../../domain/entities/mood.dart';
import '../controllers/mood_tracker_controller.dart';
import '../widgets/mood_selector.dart';
import '../widgets/mood_timeline.dart';

class MoodTrackerPage extends StatelessWidget {
  const MoodTrackerPage({required this.controller, super.key});

  final MoodTrackerController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              AppColors.backgroundTop,
              AppColors.backgroundBottom,
            ],
          ),
        ),
        child: Stack(
          children: [
            const _BackgroundGlow(
              top: -130,
              left: -60,
              color: AppColors.glowPrimary,
              size: 260,
            ),
            const _BackgroundGlow(
              top: 90,
              right: -70,
              color: AppColors.glowSecondary,
              size: 220,
            ),
            SafeArea(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1080),
                  child: AnimatedBuilder(
                    animation: controller,
                    builder: (context, _) {
                      return SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 22,
                          vertical: 24,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _HeroSection(controller: controller),
                            const SizedBox(height: 20),
                            _MoodPickerSection(controller: controller),
                            const SizedBox(height: 20),
                            MoodTimeline(entries: controller.entries),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroSection extends StatelessWidget {
  const _HeroSection({required this.controller});

  final MoodTrackerController controller;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.card.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.surfaceStrong),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 24,
            offset: Offset(0, 12),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.surfaceSoft,
              border: Border.all(color: AppColors.surfaceStrong),
            ),
            child: Icon(
              LucideIcons.heartPulse,
              color: controller.currentMood?.accentColor ?? AppColors.calm,
              size: 24,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  localizations.appTitle,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(height: 6),
                Text(
                  localizations.pageSubtitle,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MoodPickerSection extends StatelessWidget {
  const _MoodPickerSection({required this.controller});

  final MoodTrackerController controller;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.card.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.surfaceStrong),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            localizations.moodSectionTitle,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 6),
          Text(
            localizations.moodPrompt,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 14),
          MoodSelector(
            selectedMood: controller.currentMood,
            onMoodSelected: controller.logMood,
          ),
        ],
      ),
    );
  }
}

class _BackgroundGlow extends StatelessWidget {
  const _BackgroundGlow({
    required this.size,
    required this.color,
    this.top,
    this.left,
    this.right,
  });

  final double size;
  final Color color;
  final double? top;
  final double? left;
  final double? right;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      child: IgnorePointer(
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color.withValues(alpha: 0.6),
          ),
        ),
      ),
    );
  }
}
