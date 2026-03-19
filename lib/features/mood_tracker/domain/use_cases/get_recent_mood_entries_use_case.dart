import '../entities/mood_entry.dart';
import '../repositories/mood_repository.dart';

class GetRecentMoodEntriesUseCase {
  GetRecentMoodEntriesUseCase({required MoodRepository repository})
    : _repository = repository;

  final MoodRepository _repository;

  List<MoodEntry> call() {
    return _repository.getRecentEntries();
  }
}
