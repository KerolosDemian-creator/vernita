class InterviewTopic {
  const InterviewTopic({required this.id, required this.title});

  final String id;
  final String title;

  @override
  bool operator ==(Object other) => other is InterviewTopic && other.id == id;

  @override
  int get hashCode => id.hashCode;
}

class InterviewTopicCategory {
  const InterviewTopicCategory({required this.title, required this.topics});

  final String title;
  final List<InterviewTopic> topics;
}
