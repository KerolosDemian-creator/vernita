import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/helper/spacing.dart';
import 'package:vernita/core/theme/app_colors.dart';
import 'package:vernita/core/theme/app_text_styles.dart';
import 'package:vernita/features/interview/data/models/interview_config.dart';
import 'package:vernita/features/interview/data/models/interview_topic.dart';
import 'package:vernita/features/interview/data/topics_catalog.dart';
import 'package:vernita/features/interview/ui/widgets/setup_primary_button.dart';
import 'package:vernita/features/interview/ui/widgets/topic_chips.dart';

/// Opens the "Select Interview Topics" sheet.
/// Returns the new selection, or null if the sheet was closed without
/// confirming (so nothing changes).
Future<List<InterviewTopic>?> showTopicsSheet(
  BuildContext context, {
  required List<InterviewTopic> selected,
  required List<InterviewTopic> suggested,
}) {
  return showModalBottomSheet<List<InterviewTopic>>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => TopicsSheet(selected: selected, suggested: suggested),
  );
}

class TopicsSheet extends StatefulWidget {
  const TopicsSheet({
    super.key,
    required this.selected,
    required this.suggested,
  });

  final List<InterviewTopic> selected;
  final List<InterviewTopic> suggested;

  @override
  State<TopicsSheet> createState() => _TopicsSheetState();
}

class _TopicsSheetState extends State<TopicsSheet> {
  // A local copy: it is only handed back when the user taps "Add to Session".
  late final Set<InterviewTopic> _selected = {...widget.selected};
  String _query = '';

  bool get _limitReached => _selected.length >= InterviewConfig.maxTopics;

  void _toggle(InterviewTopic topic) {
    setState(() {
      if (!_selected.remove(topic) && !_limitReached) {
        _selected.add(topic);
      }
    });
  }

  List<InterviewTopicCategory> get _sections {
    final query = _query.trim().toLowerCase();
    final sections = <InterviewTopicCategory>[];

    if (query.isEmpty && widget.suggested.isNotEmpty) {
      sections.add(
        InterviewTopicCategory(
          title: 'Suggested from your CV',
          topics: widget.suggested,
        ),
      );
    }

    for (final category in TopicsCatalog.categories) {
      final topics = query.isEmpty
          ? category.topics
          : category.topics
                .where((topic) => topic.title.toLowerCase().contains(query))
                .toList();
      if (topics.isNotEmpty) {
        sections.add(
          InterviewTopicCategory(title: category.title, topics: topics),
        );
      }
    }
    return sections;
  }

  @override
  Widget build(BuildContext context) {
    final sections = _sections;
    final maxHeight = MediaQuery.sizeOf(context).height * 0.88;

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: Container(
        constraints: BoxConstraints(maxHeight: maxHeight),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            verticalSpace(10),
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: AppColors.analyticsDivider,
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
            verticalSpace(16),
            Text(
              'Select Interview Topics',
              textAlign: TextAlign.center,
              style: AppTextStyles.font20BrownPoppins700W,
            ),
            verticalSpace(4),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Text(
                'Choose relevant domains or technical competencies for this session.',
                textAlign: TextAlign.center,
                style: AppTextStyles.font12GreyPoppins400W,
              ),
            ),
            verticalSpace(14),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: TextField(
                onChanged: (value) => setState(() => _query = value),
                style: AppTextStyles.font13BrownPoppins500W,
                decoration: InputDecoration(
                  hintText: 'Search topics, stacks, or keywords...',
                  hintStyle: AppTextStyles.font12GreyPoppins400W,
                  prefixIcon: Icon(
                    Icons.search_rounded,
                    size: 20.r,
                    color: AppColors.nonSelectedIcon,
                  ),
                  filled: true,
                  fillColor: AppColors.fieldFill,
                  contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.r),
                    borderSide: const BorderSide(
                      color: AppColors.analyticsDivider,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.r),
                    borderSide: const BorderSide(
                      color: AppColors.analyticsDivider,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.r),
                    borderSide: const BorderSide(
                      color: AppColors.lightPeachText,
                    ),
                  ),
                ),
              ),
            ),
            verticalSpace(8),
            Flexible(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 8.h),
                child: sections.isEmpty
                    ? Padding(
                        padding: EdgeInsets.symmetric(vertical: 32.h),
                        child: Center(
                          child: Text(
                            'No topics found',
                            style: AppTextStyles.font12GreyPoppins400W,
                          ),
                        ),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (final section in sections) ...[
                            Text(
                              section.title,
                              style: AppTextStyles.font13BrownPoppins600W,
                            ),
                            verticalSpace(10),
                            Wrap(
                              spacing: 8.w,
                              runSpacing: 8.h,
                              children: [
                                for (final topic in section.topics)
                                  SelectableTopicChip(
                                    title: topic.title,
                                    selected: _selected.contains(topic),
                                    enabled: !_limitReached,
                                    onTap: () => _toggle(topic),
                                  ),
                              ],
                            ),
                            verticalSpace(18),
                          ],
                        ],
                      ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 16.h),
              decoration: BoxDecoration(
                color: AppColors.fieldFill,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.fieldShadow,
                    offset: Offset(0, -4),
                    blurRadius: 16,
                  ),
                ],
              ),
              child: SafeArea(
                top: false,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _limitReached
                          ? 'Maximum of ${InterviewConfig.maxTopics} topics reached'
                          : 'Selected: ${_selected.length}/${InterviewConfig.maxTopics} topics',
                      style: AppTextStyles.font12BrownPoppins600W,
                    ),
                    verticalSpace(10),
                    SetupPrimaryButton(
                      label: 'Add to Session',
                      onPressed: _selected.isEmpty
                          ? null
                          : () =>
                                Navigator.of(context).pop(_selected.toList()),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
