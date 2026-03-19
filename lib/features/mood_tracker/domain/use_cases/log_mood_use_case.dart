import '../entities/mood.dart';
import '../repositories/mood_repository.dart';

class LogMoodUseCase {
  LogMoodUseCase({required MoodRepository repository, DateTime Function()? now})
    : _repository = repository,
      _now = now ?? DateTime.now;

  final MoodRepository _repository;
  final DateTime Function() _now;

  void call(Mood mood) {
    _repository.saveMood(mood: mood, date: _now());
  }
}
