import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/helper/extensions.dart';
import 'package:vernita/core/helper/spacing.dart';
import 'package:vernita/core/routing/routes.dart';
import 'package:vernita/core/theme/app_text_styles.dart';
import 'package:vernita/core/widgets/app_card.dart';
import 'package:vernita/core/widgets/app_header.dart';
import 'package:vernita/features/calendar/data/models/calendar_event_model.dart';
import 'package:vernita/features/calendar/ui/widgets/add_event/event_type_card.dart';

class AddEventBody extends StatelessWidget {
  const AddEventBody({super.key});

  void _open(BuildContext context, EventType type) {
    context.pushNamed(Routes.addTask, arguments: type);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 24.h),
        child: Column(
          children: [
            const AppHeader(title: 'Add Event'),
            verticalSpace(18),
            AppCard(
              radius: 32,
              padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 32.h),
              child: Column(
                children: [
                  Text(
                    'What do you want to add?',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.font22BrownPoppins700W,
                  ),
                  verticalSpace(10),
                  Text(
                    "Choose the type of event you'd like to schedule.",
                    textAlign: TextAlign.center,
                    style: AppTextStyles.font12GreyPoppins400W,
                  ),
                  verticalSpace(28),
                  EventTypeCard(
                    type: EventType.interview,
                    title: 'Interview Session',
                    subtitle: 'Schedule an AI interview practice session.',
                    onTap: () => _open(context, EventType.interview),
                  ),
                  verticalSpace(14),
                  EventTypeCard(
                    type: EventType.task,
                    title: 'Task',
                    subtitle: 'Add something you want to complete.',
                    onTap: () => _open(context, EventType.task),
                  ),
                  verticalSpace(28),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
