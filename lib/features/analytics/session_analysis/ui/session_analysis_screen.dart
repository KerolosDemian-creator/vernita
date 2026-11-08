import 'package:flutter/material.dart';
import 'package:vernita/features/analytics/session_analysis/ui/widgets/session_analysis_body.dart';

class SessionAnalysisScreen extends StatelessWidget {
  const SessionAnalysisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SessionAnalysisBody());
  }
}
