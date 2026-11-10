import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/features/calendar/logic/calendar_state.dart';
import 'package:vernita/features/calendar/logic/calendar_utils.dart';
import 'package:vernita/features/calendar/ui/widgets/month/calendar_day_cell.dart';

/// 6 rows x 7 days.
class MonthGrid extends StatelessWidget {
  const MonthGrid({super.key, required this.state, required this.onDayTap});

  final CalendarState state;
  final ValueChanged<DateTime> onDayTap;

  @override
  Widget build(BuildContext context) {
    final days = monthGridDays(state.focusedMonth);

    return Column(
      children: [
        for (var row = 0; row < 6; row++)
          Padding(
            padding: EdgeInsets.only(top: row == 0 ? 0 : 2.h),
            child: Row(
              children: [
                for (var col = 0; col < 7; col++)
                  Expanded(child: _cell(days[row * 7 + col])),
              ],
            ),
          ),
      ],
    );
  }

  Widget _cell(DateTime day) {
    return CalendarDayCell(
      day: day,
      isCurrentMonth: day.month == state.focusedMonth.month,
      isSelected: isSameDay(day, state.selectedDate),
      isToday: isSameDay(day, state.today),
      eventTypes: state.eventsOn(day).map((e) => e.type).toSet(),
      onTap: () => onDayTap(day),
    );
  }
}
