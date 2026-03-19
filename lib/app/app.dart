import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../features/mood_tracker/presentation/controllers/mood_tracker_controller.dart';
import '../features/mood_tracker/domain/use_cases/get_recent_mood_entries_use_case.dart';
import '../features/mood_tracker/domain/use_cases/log_mood_use_case.dart';
import '../features/mood_tracker/data/repositories/in_memory_mood_repository.dart';
import '../features/mood_tracker/presentation/pages/mood_tracker_page.dart';
import 'package:mind2matterdemo/l10n/app_localizations.dart';
import 'theme/app_theme.dart';

class Mind2MatterApp extends StatefulWidget {
  const Mind2MatterApp({super.key});

  @override
  State<Mind2MatterApp> createState() => _Mind2MatterAppState();
}

class _Mind2MatterAppState extends State<Mind2MatterApp> {
  late final MoodTrackerController _controller;

  @override
  void initState() {
    super.initState();
    final InMemoryMoodRepository repository = InMemoryMoodRepository();
    _controller = MoodTrackerController(
      logMoodUseCase: LogMoodUseCase(repository: repository),
      getRecentMoodEntriesUseCase: GetRecentMoodEntriesUseCase(
        repository: repository,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
      theme: AppTheme.lightTheme,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: MoodTrackerPage(controller: _controller),
    );
  }
}
