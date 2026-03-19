import '../entities/mood.dart';
import '../entities/mood_entry.dart';

abstract class MoodRepository {
  List<MoodEntry> getRecentEntries();

  void saveMood({required Mood mood, required DateTime date});
}
