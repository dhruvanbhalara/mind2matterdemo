import 'package:flutter/material.dart';

import 'package:mind2matterdemo/l10n/app_localizations.dart';
import '../controllers/mood_tracker_controller.dart';
import '../widgets/mood_selector.dart';
import '../widgets/mood_timeline.dart';

class MoodTrackerPage extends StatelessWidget {
  const MoodTrackerPage({required this.controller, super.key});

  final MoodTrackerController controller;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                localizations.appTitle,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 20),
              Text(
                localizations.moodPrompt,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 14),
              MoodSelector(onMoodSelected: controller.logMood),
              const SizedBox(height: 24),
              Expanded(
                child: AnimatedBuilder(
                  animation: controller,
                  builder: (context, _) {
                    return MoodTimeline(entries: controller.entries);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
