import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vernita/core/helper/spacing.dart';
import 'package:vernita/core/theme/app_text_styles.dart';
import 'package:vernita/features/calendar/logic/calendar_cubit.dart';
import 'package:vernita/features/calendar/logic/calendar_state.dart';
import 'package:vernita/features/calendar/logic/calendar_utils.dart';
import 'package:vernita/features/calendar/ui/widgets/day_events/empty_events_card.dart';
import 'package:vernita/features/calendar/ui/widgets/day_events/event_card.dart';
import 'package:vernita/features/calendar/ui/widgets/day_events/today_chip.dart';

/// "Friday, October 17  [TODAY]" + the events of the selected day.
class DayEventsSection extends StatelessWidget {
  const DayEventsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarCubit, CalendarState>(
      builder: (context, state) {
        final events = state.selectedDayEvents;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  formatLongDate(state.selectedDate),
                  style: AppTextStyles.font15BrownPoppins700W,
                ),
                if (state.isSelectedToday) ...[
                  horizantalSpace(8),
                  const TodayChip(),
                ],
              ],
            ),
            verticalSpace(12),
            if (events.isEmpty)
              const EmptyEventsCard(message: 'No events on this day')
            else
              for (final event in events) ...[
                EventCard(event: event),
                verticalSpace(12),
              ],
          ],
        );
      },
    );
  }
}
