import 'package:flutter/foundation.dart';

import '../../domain/entities/mood.dart';
import '../../domain/entities/mood_entry.dart';
import '../../domain/use_cases/get_recent_mood_entries_use_case.dart';
import '../../domain/use_cases/log_mood_use_case.dart';

class MoodTrackerController extends ChangeNotifier {
  MoodTrackerController({
    required LogMoodUseCase logMoodUseCase,
    required GetRecentMoodEntriesUseCase getRecentMoodEntriesUseCase,
  }) : _logMoodUseCase = logMoodUseCase,
       _getRecentMoodEntriesUseCase = getRecentMoodEntriesUseCase;

  final LogMoodUseCase _logMoodUseCase;
  final GetRecentMoodEntriesUseCase _getRecentMoodEntriesUseCase;

  List<MoodEntry> get entries => _getRecentMoodEntriesUseCase();

  void logMood(Mood mood) {
    _logMoodUseCase(mood);
    notifyListeners();
  }
}
