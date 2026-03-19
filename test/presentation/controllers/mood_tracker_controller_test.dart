import 'package:flutter_test/flutter_test.dart';
import 'package:mind2matterdemo/features/mood_tracker/presentation/controllers/mood_tracker_controller.dart';
import 'package:mind2matterdemo/features/mood_tracker/domain/entities/mood.dart';
import 'package:mind2matterdemo/features/mood_tracker/domain/entities/mood_entry.dart';
import 'package:mind2matterdemo/features/mood_tracker/domain/repositories/mood_repository.dart';
import 'package:mind2matterdemo/features/mood_tracker/domain/use_cases/get_recent_mood_entries_use_case.dart';
import 'package:mind2matterdemo/features/mood_tracker/domain/use_cases/log_mood_use_case.dart';

void main() {
  group(MoodTrackerController, () {
    test('logs entries in reverse chronological order and caps at seven', () {
      final FakeMoodRepository repository = FakeMoodRepository();
      DateTime now = DateTime(2026, 3, 20, 8);

      final MoodTrackerController controller = MoodTrackerController(
        logMoodUseCase: LogMoodUseCase(repository: repository, now: () => now),
        getRecentMoodEntriesUseCase: GetRecentMoodEntriesUseCase(
          repository: repository,
        ),
      );

      for (int i = 0; i < 8; i++) {
        now = now.add(const Duration(minutes: 1));
        controller.logMood(Mood.happy);
      }

      expect(controller.entries.length, 7);
      expect(
        controller.entries.first.date.isAfter(controller.entries.last.date),
        true,
      );
    });
  });
}

class FakeMoodRepository implements MoodRepository {
  final List<MoodEntry> _entries = <MoodEntry>[];

  @override
  List<MoodEntry> getRecentEntries() => List<MoodEntry>.unmodifiable(_entries);

  @override
  void saveMood({required Mood mood, required DateTime date}) {
    _entries.insert(0, MoodEntry(date: date, mood: mood));
    if (_entries.length > 7) {
      _entries.removeLast();
    }
  }
}
