import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mind2matterdemo/app/theme/app_colors.dart';
import 'package:mind2matterdemo/l10n/app_localizations.dart';

import '../../domain/entities/mood_entry.dart';
import 'mood_entry_tile.dart';

class MoodTimeline extends StatelessWidget {
  const MoodTimeline({required this.entries, super.key});

  final List<MoodEntry> entries;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.card.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.surfaceStrong),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                LucideIcons.history,
                color: AppColors.mutedText,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                localizations.timelineTitle,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            localizations.timelineHint,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 14),
          if (entries.isEmpty)
            _EmptyState(text: localizations.emptyTimeline)
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
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 14),
      decoration: BoxDecoration(
        color: AppColors.surfaceSoft,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.surfaceStrong),
      ),
      child: Row(
        children: [
          const Icon(
            LucideIcons.sparkles,
            color: AppColors.mutedText,
            size: 18,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(text, style: Theme.of(context).textTheme.bodyMedium),
          ),
        ],
      ),
    );
  }
}
