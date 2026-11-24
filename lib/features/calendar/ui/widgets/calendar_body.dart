import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/helper/spacing.dart';
import 'package:vernita/features/calendar/ui/widgets/calendar_header.dart';
import 'package:vernita/features/calendar/ui/widgets/day_events/day_events_section.dart';
import 'package:vernita/features/calendar/ui/widgets/month/month_card.dart';
import 'package:vernita/features/calendar/ui/widgets/upcoming/upcoming_section.dart';

class CalendarBody extends StatelessWidget {
  const CalendarBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CalendarHeader(),
              verticalSpace(20),
              const MonthCard(),
              verticalSpace(24),
              const DayEventsSection(),
              verticalSpace(24),
              const UpcomingSection(),
              verticalSpace(20),
            ],
          ),
        ),
      ),
    );
  }
}
