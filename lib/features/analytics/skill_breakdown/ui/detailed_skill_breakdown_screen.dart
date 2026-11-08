import 'package:flutter/material.dart';
import 'package:vernita/features/analytics/skill_breakdown/ui/widgets/skill_breakdown_body.dart';

class DetailedSkillBreakdownScreen extends StatelessWidget {
  const DetailedSkillBreakdownScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SkillBreakdownBody());
  }
}
