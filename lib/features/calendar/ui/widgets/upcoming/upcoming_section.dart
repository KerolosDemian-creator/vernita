import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/helper/spacing.dart';
import 'package:vernita/core/theme/app_colors.dart';
import 'package:vernita/core/theme/app_text_styles.dart';
import 'package:vernita/core/widgets/app_card.dart';
import 'package:vernita/features/calendar/logic/calendar_cubit.dart';
import 'package:vernita/features/calendar/logic/calendar_state.dart';
import 'package:vernita/features/calendar/ui/widgets/day_events/empty_events_card.dart';
import 'package:vernita/features/calendar/ui/widgets/upcoming/upcoming_event_tile.dart';

class UpcomingSection extends StatelessWidget {
  const UpcomingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarCubit, CalendarState>(
      builder: (context, state) {
        final events = state.upcoming;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Upcoming', style: AppTextStyles.font15BrownPoppins700W),
            verticalSpace(12),
            if (events.isEmpty)
              const EmptyEventsCard(message: 'Nothing coming up yet')
            else
              AppCard(
                radius: 22,
                child: Column(
                  children: [
                    for (var i = 0; i < events.length; i++) ...[
                      if (i > 0)
                        Divider(
                          height: 1,
                          indent: 16.w,
                          endIndent: 16.w,
                          color: AppColors.divider,
                        ),
                      UpcomingEventTile(event: events[i]),
                    ],
                  ],
                ),
              ),
          ],
        );
      },
    );
  }
}
