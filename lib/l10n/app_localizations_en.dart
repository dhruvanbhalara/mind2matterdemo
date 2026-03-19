// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Mind2Matter Mood Tracker';

  @override
  String get moodPrompt => 'How do you feel right now?';

  @override
  String get timelineTitle => 'Last 7 mood entries';

  @override
  String get emptyTimeline => 'No moods logged yet.';

  @override
  String get moodHappy => 'Happy';

  @override
  String get moodExcited => 'Excited';

  @override
  String get moodCalm => 'Calm';

  @override
  String get moodNeutral => 'Neutral';

  @override
  String get moodAnxious => 'Anxious';

  @override
  String get moodSad => 'Sad';

  @override
  String get moodTired => 'Tired';

  @override
  String entryOnDate(Object mood, Object date) {
    return '$mood on $date';
  }
}
