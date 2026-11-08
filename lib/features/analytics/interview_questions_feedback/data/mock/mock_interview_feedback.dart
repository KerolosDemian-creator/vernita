import '../models/interview_feedback_data.dart';

const mockInterviewFeedback = InterviewFeedbackData(
  sessionType: 'System Design Interview',
  date: 'Aug 26, 2024',
  time: '10:30 AM',
  duration: '45 min',
  summary: '18 Questions • 12 Good • 4 Needs Improvement • 2 Wrong',
  questions: [
    QuestionFeedbackData(
      number: 1,
      question: 'How would you design a scalable chat application?',
      score: 62,
      status: AnswerStatus.needsImprovement,
      scoreTone: ScoreTone.negative,
      isExpanded: true,
      answerTranscript:
          'I’d use WebSockets for real-time messaging, a load balancer in '
          'front of the chat servers, and Redis for presence. Messages would '
          'be written to a database and fan-out workers would deliver them to '
          'recipients. I’d also add pagination and basic retries.',
      aiFeedback:
          'You provided a good high-level overview but missed some key '
          "components. You also didn't explain how your design handles message "
          'delivery guarantees.',
      strengths: [
        'Mentioned horizontal scaling for the backend',
        'Good understanding of real-time communication',
      ],
      improvements: [
        'Explain database choices and sharding strategy',
        'Discuss message delivery (sent, delivered, read)',
        'Mention offline support and sync mechanism',
      ],
      betterApproach:
          'Start with requirements → identify core features → design system '
          'architecture → choose technologies → discuss scaling, reliability, '
          'and trade-offs.',
      tip:
          'Use diagrams to support your explanation for system design '
          'questions.',
    ),
    QuestionFeedbackData(
      number: 2,
      question: 'Explain the CAP theorem with an example.',
      score: 90,
      status: AnswerStatus.good,
      scoreTone: ScoreTone.positive,
    ),
    QuestionFeedbackData(
      number: 3,
      question: 'How would you handle 1M concurrent users?',
      score: 68,
      status: AnswerStatus.needsImprovement,
      scoreTone: ScoreTone.warning,
    ),
    QuestionFeedbackData(
      number: 4,
      question: 'Design a URL shortener like bit.ly',
      score: 85,
      status: AnswerStatus.good,
      scoreTone: ScoreTone.positive,
    ),
    QuestionFeedbackData(
      number: 5,
      question: 'What is the difference between SQL and NoSQL?',
      score: 92,
      status: AnswerStatus.good,
      scoreTone: ScoreTone.positive,
    ),
    QuestionFeedbackData(
      number: 6,
      question: 'How would you ensure data consistency?',
      score: 40,
      status: AnswerStatus.wrong,
      scoreTone: ScoreTone.negative,
    ),
  ],
);
