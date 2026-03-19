import '../../domain/entities/mood.dart';
import '../../domain/entities/mood_entry.dart';
import '../../domain/repositories/mood_repository.dart';

class InMemoryMoodRepository implements MoodRepository {
  final List<MoodEntry> _entries = <MoodEntry>[];

  @override
  List<MoodEntry> getRecentEntries() {
    return List<MoodEntry>.unmodifiable(_entries);
  }

  @override
  void saveMood({required Mood mood, required DateTime date}) {
    _entries.insert(0, MoodEntry(date: date, mood: mood));

    if (_entries.length > 7) {
      _entries.removeLast();
    }
  }
}
