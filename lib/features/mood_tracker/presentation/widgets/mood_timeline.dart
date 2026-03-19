import 'package:flutter/material.dart';

import 'package:mind2matterdemo/l10n/app_localizations.dart';
import '../../domain/entities/mood_entry.dart';
import 'mood_entry_tile.dart';

class MoodTimeline extends StatelessWidget {
  const MoodTimeline({required this.entries, super.key});

  final List<MoodEntry> entries;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          localizations.timelineTitle,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 12),
        if (entries.isEmpty)
          Text(localizations.emptyTimeline)
        else
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (int index = 0; index < entries.length; index++) ...[
                  MoodEntryTile(entry: entries[index]),
                  if (index < entries.length - 1) const SizedBox(width: 12),
                ],
              ],
            ),
          ),
      ],
    );
  }
}
