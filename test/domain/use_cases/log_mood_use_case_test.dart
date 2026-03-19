import 'package:flutter_test/flutter_test.dart';
import 'package:mind2matterdemo/features/mood_tracker/domain/entities/mood.dart';
import 'package:mind2matterdemo/features/mood_tracker/domain/entities/mood_entry.dart';
import 'package:mind2matterdemo/features/mood_tracker/domain/repositories/mood_repository.dart';
import 'package:mind2matterdemo/features/mood_tracker/domain/use_cases/log_mood_use_case.dart';

void main() {
  test('saves selected mood with injected timestamp', () {
    final RecordingMoodRepository repository = RecordingMoodRepository();
    final DateTime fixedDate = DateTime(2026, 3, 20, 12, 30);
    final LogMoodUseCase useCase = LogMoodUseCase(
      repository: repository,
      now: () => fixedDate,
    );

    useCase(Mood.anxious);

    expect(repository.savedMood, Mood.anxious);
    expect(repository.savedDate, fixedDate);
  });
}

class RecordingMoodRepository implements MoodRepository {
  Mood? savedMood;
  DateTime? savedDate;

  @override
  List<MoodEntry> getRecentEntries() => const <MoodEntry>[];

  @override
  void saveMood({required Mood mood, required DateTime date}) {
    savedMood = mood;
    savedDate = date;
  }
}
