import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/helper/extensions.dart';
import 'package:vernita/core/helper/spacing.dart';
import 'package:vernita/core/widgets/app_gradient_button.dart';
import 'package:vernita/core/widgets/app_header.dart';
import 'package:vernita/features/calendar/data/models/calendar_event_model.dart';
import 'package:vernita/features/calendar/logic/calendar_cubit.dart';
import 'package:vernita/features/calendar/logic/calendar_utils.dart';
import 'package:vernita/features/calendar/ui/widgets/event_form/event_form_section.dart';
import 'package:vernita/features/calendar/ui/widgets/event_form/event_picker_tile.dart';
import 'package:vernita/features/calendar/ui/widgets/event_form/event_text_field.dart';
import 'package:vernita/features/calendar/ui/widgets/event_form/reminder_picker_sheet.dart';
import 'package:vernita/features/calendar/ui/widgets/event_form/steps_indicator.dart';
import 'package:vernita/features/calendar/ui/widgets/event_type_style.dart';

/// Holds the form values (name / time / reminder / notes) and submits them
/// to [CalendarCubit]. Each input is its own small widget.
class AddTaskBody extends StatefulWidget {
  const AddTaskBody({super.key, required this.type});

  final EventType type;

  @override
  State<AddTaskBody> createState() => _AddTaskBodyState();
}

class _AddTaskBodyState extends State<AddTaskBody> {
  final _nameController = TextEditingController();
  final _notesController = TextEditingController();
  TimeOfDay _time = const TimeOfDay(hour: 10, minute: 30);
  int _reminderMin = 10;

  @override
  void dispose() {
    _nameController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(context: context, initialTime: _time);
    if (picked != null) setState(() => _time = picked);
  }

  Future<void> _pickReminder() async {
    final picked = await showReminderPicker(context, _reminderMin);
    if (picked != null) setState(() => _reminderMin = picked);
  }

  void _submit() {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(content: Text('Please enter the ${widget.type.nameLabel.toLowerCase()}')),
        );
      return;
    }

    context.read<CalendarCubit>().addEvent(
          type: widget.type,
          title: name,
          hour: _time.hour,
          minute: _time.minute,
          reminderMin: _reminderMin,
          notes: _notesController.text.trim(),
        );
    context.popToFirst(); // back to the Calendar tab
  }

  @override
  Widget build(BuildContext context) {
    final type = widget.type;

    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 0),
            child: Column(
              children: [
                AppHeader(title: type.addTitle),
                verticalSpace(14),
                const StepsIndicator(current: 1, total: 2),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 16.h),
              child: Column(
                children: [
                  EventFormSection(
                    label: type.nameLabel,
                    child: EventTextField(
                      controller: _nameController,
                      hint: type.nameHint,
                      icon: type.icon,
                      showPaste: true,
                    ),
                  ),
                  EventFormSection(
                    label: 'Time',
                    child: EventPickerTile(
                      icon: Icons.access_time_rounded,
                      text: formatTime(_time.hour, _time.minute),
                      onTap: _pickTime,
                    ),
                  ),
                  EventFormSection(
                    label: 'Reminder',
                    child: EventPickerTile(
                      icon: Icons.notifications_none_rounded,
                      text: reminderLabel(_reminderMin),
                      onTap: _pickReminder,
                    ),
                  ),
                  EventFormSection(
                    label: 'Notes (Optional)',
                    child: EventTextField(
                      controller: _notesController,
                      hint: 'Add notes...',
                      icon: Icons.sticky_note_2_outlined,
                      maxLines: 4,
                      maxLength: 200,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 16.h),
            child: AppGradientButton(
              label: type.addTitle,
              showArrow: true,
              onPressed: _submit,
            ),
          ),
        ],
      ),
    );
  }
}
