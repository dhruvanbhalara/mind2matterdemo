import 'package:flutter_test/flutter_test.dart';
import 'package:mind2matterdemo/features/mood_tracker/domain/entities/mood.dart';
import 'package:mind2matterdemo/features/mood_tracker/domain/entities/mood_entry.dart';
import 'package:mind2matterdemo/features/mood_tracker/domain/repositories/mood_repository.dart';
import 'package:mind2matterdemo/features/mood_tracker/domain/use_cases/get_recent_mood_entries_use_case.dart';

void main() {
  test('returns recent entries from repository', () {
    final List<MoodEntry> entries = <MoodEntry>[
      MoodEntry(date: DateTime(2026, 3, 20), mood: Mood.happy),
    ];
    final StubMoodRepository repository = StubMoodRepository(entries);
    final GetRecentMoodEntriesUseCase useCase = GetRecentMoodEntriesUseCase(
      repository: repository,
    );

    final List<MoodEntry> result = useCase();

    expect(result, entries);
  });
}

class StubMoodRepository implements MoodRepository {
  StubMoodRepository(this.entries);

  final List<MoodEntry> entries;

  @override
  List<MoodEntry> getRecentEntries() => entries;

  @override
  void saveMood({required Mood mood, required DateTime date}) {}
}
