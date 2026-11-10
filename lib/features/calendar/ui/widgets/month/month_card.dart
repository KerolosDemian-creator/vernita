import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/helper/spacing.dart';
import 'package:vernita/core/widgets/app_card.dart';
import 'package:vernita/features/calendar/logic/calendar_cubit.dart';
import 'package:vernita/features/calendar/logic/calendar_state.dart';
import 'package:vernita/features/calendar/ui/widgets/month/month_grid.dart';
import 'package:vernita/features/calendar/ui/widgets/month/month_header.dart';
import 'package:vernita/features/calendar/ui/widgets/month/weekdays_row.dart';

class MonthCard extends StatelessWidget {
  const MonthCard({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CalendarCubit>();

    return BlocBuilder<CalendarCubit, CalendarState>(
      builder: (context, state) {
        return AppCard(
          radius: 28,
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 16.h),
          child: Column(
            children: [
              MonthHeader(
                month: state.focusedMonth,
                onPrevious: () => cubit.changeMonth(-1),
                onNext: () => cubit.changeMonth(1),
              ),
              verticalSpace(14),
              const WeekdaysRow(),
              verticalSpace(6),
              MonthGrid(state: state, onDayTap: cubit.selectDate),
            ],
          ),
        );
      },
    );
  }
}
