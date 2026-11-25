import 'package:vernita/features/interview/data/models/interview_topic.dart';

/// Topics the user can pick from.
/// TODO(backend): if the backend serves the topics, load them in a repo and
/// keep this file only as an offline fallback.
abstract final class TopicsCatalog {
  static const List<InterviewTopicCategory> categories = [
    InterviewTopicCategory(
      title: 'AI & Machine Learning',
      topics: [
        InterviewTopic(id: 'llms-prompt-eng', title: 'LLMs & Prompt Eng'),
        InterviewTopic(id: 'computer-vision', title: 'Computer Vision'),
        InterviewTopic(id: 'mlops-serving', title: 'MLOps & Serving'),
        InterviewTopic(id: 'fine-tuning-rag', title: 'Fine-tuning & RAG'),
      ],
    ),
    InterviewTopicCategory(
      title: 'Core Software Engineering',
      topics: [
        InterviewTopic(id: 'system-design', title: 'System Design'),
        InterviewTopic(
          id: 'distributed-systems',
          title: 'Distributed Systems',
        ),
        InterviewTopic(id: 'microservices-apis', title: 'Microservices & APIs'),
        InterviewTopic(
          id: 'cloud-architecture',
          title: 'Cloud Architecture (AWS/Azure)',
        ),
      ],
    ),
    InterviewTopicCategory(
      title: 'Product & Frontend',
      topics: [
        InterviewTopic(id: 'design-systems', title: 'Design Systems'),
        InterviewTopic(id: 'user-research', title: 'User Research'),
        InterviewTopic(
          id: 'cross-functional-comms',
          title: 'Cross-functional Comms',
        ),
        InterviewTopic(id: 'state-management', title: 'State Management'),
        InterviewTopic(id: 'prototyping', title: 'Prototyping'),
      ],
    ),
    InterviewTopicCategory(
      title: 'Cybersecurity & Infrastructure',
      topics: [
        InterviewTopic(
          id: 'soc-threat-analysis',
          title: 'SOC & Threat Analysis',
        ),
        InterviewTopic(id: 'devsecops', title: 'DevSecOps'),
        InterviewTopic(id: 'network-defense', title: 'Network Defense'),
      ],
    ),
  ];

  static List<InterviewTopic> get all => [
    for (final category in categories) ...category.topics,
  ];

  static InterviewTopic byId(String id) =>
      all.firstWhere((topic) => topic.id == id);
}
