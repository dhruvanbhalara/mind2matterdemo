import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mind2matterdemo/features/mood_tracker/presentation/controllers/mood_tracker_controller.dart';
import 'package:mind2matterdemo/features/mood_tracker/domain/entities/mood.dart';
import 'package:mind2matterdemo/features/mood_tracker/domain/use_cases/get_recent_mood_entries_use_case.dart';
import 'package:mind2matterdemo/features/mood_tracker/domain/use_cases/log_mood_use_case.dart';
import 'package:mind2matterdemo/features/mood_tracker/data/repositories/in_memory_mood_repository.dart';
import 'package:mind2matterdemo/features/mood_tracker/presentation/pages/mood_tracker_page.dart';
import 'package:mind2matterdemo/l10n/app_localizations.dart';

Widget _buildTestWidget(MoodTrackerController controller) {
  return MaterialApp(
    localizationsDelegates: const [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: AppLocalizations.supportedLocales,
    home: MoodTrackerPage(controller: controller),
  );
}

void main() {
  MoodTrackerController buildController() {
    final InMemoryMoodRepository repository = InMemoryMoodRepository();
    return MoodTrackerController(
      logMoodUseCase: LogMoodUseCase(
        repository: repository,
        now: () => DateTime(2026, 3, 20),
      ),
      getRecentMoodEntriesUseCase: GetRecentMoodEntriesUseCase(
        repository: repository,
      ),
    );
  }

  testWidgets('renders all available moods in selector', (
    WidgetTester tester,
  ) async {
    final MoodTrackerController controller = buildController();

    await tester.pumpWidget(_buildTestWidget(controller));

    expect(find.byType(InkWell), findsNWidgets(Mood.values.length));
  });

  testWidgets('adds a timeline card when a mood is selected', (
    WidgetTester tester,
  ) async {
    final MoodTrackerController controller = buildController();

    await tester.pumpWidget(_buildTestWidget(controller));
    await tester.tap(find.byType(InkWell).first);
    await tester.pumpAndSettle();

    expect(find.byType(Transform), findsWidgets);
    expect(controller.entries.length, 1);
  });

  testWidgets('tapping timeline entry starts animation without errors', (
    WidgetTester tester,
  ) async {
    final MoodTrackerController controller = buildController();

    controller.logMood(Mood.neutral);
    await tester.pumpWidget(_buildTestWidget(controller));

    await tester.tap(find.byType(GestureDetector).first);
    await tester.pump(const Duration(milliseconds: 120));

    expect(tester.takeException(), isNull);
  });
}
