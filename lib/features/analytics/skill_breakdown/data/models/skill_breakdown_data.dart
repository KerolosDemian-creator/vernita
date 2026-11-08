enum SkillGroupType { technical, delivery, visual }

class SkillBreakdownData {
  const SkillBreakdownData({
    required this.subtitle,
    required this.groups,
    this.maxScore = 100,
  });

  final String subtitle;
  final List<SkillGroupData> groups;
  final int maxScore;
}

class SkillGroupData {
  const SkillGroupData({
    required this.type,
    required this.title,
    required this.score,
    required this.metrics,
    this.maxScore = 100,
  });

  final SkillGroupType type;
  final String title;
  final int score;
  final int maxScore;
  final List<SkillMetricData> metrics;
}

class SkillMetricData {
  const SkillMetricData({
    required this.title,
    required this.score,
    required this.detail,
    this.maxScore = 100,
  });

  final String title;
  final int score;
  final int maxScore;
  final String detail;
}
