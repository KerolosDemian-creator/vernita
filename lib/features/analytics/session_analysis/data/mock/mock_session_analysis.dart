import '../models/session_analysis_data.dart';

const mockSessionAnalysis = SessionAnalysisData(
  overallScore: 84,
  scoreDelta: '+5%',
  sessionLabel: 'Oct 24 • Mock #14',
  percentileLabel: 'Top 15% of all candidates',
  overallPercent: 84,
  overallBadgeLabel: 'Great Job!',
  skills: [
    SessionSkillSummary(
      type: SessionSkillType.technical,
      title: 'Technical Depth',
      score: 92,
      highlight: '3 Strengths',
      detail: 'System design & algorithms',
      highlightTone: SessionHighlightTone.positive,
    ),
    SessionSkillSummary(
      type: SessionSkillType.delivery,
      title: 'Delivery & Response',
      score: 85,
      highlight: 'Avg 2.4s Response Latency',
      detail: 'Crisp articulation',
      highlightTone: SessionHighlightTone.danger,
    ),
    SessionSkillSummary(
      type: SessionSkillType.visual,
      title: 'Visual Presence (CV)',
      score: 79,
      highlight: '84% Steady Eye Contact',
      detail: 'Upright posture',
      highlightTone: SessionHighlightTone.warning,
    ),
  ],
  questions: [
    SessionQuestionPreview(
      number: 'Q1',
      question: 'Where do you see yourself after 5 years?',
      status: SessionAnswerStatus.needsImprovement,
      timing: '4.2s delay',
      feedbackTitle: 'Better Approach:',
      feedback:
          'Focus on technical leadership, system ownership, and company '
          'impact rather than compensation.',
    ),
    SessionQuestionPreview(
      number: 'Q2',
      question: 'Tell me about a difficult project trade-off.',
      status: SessionAnswerStatus.strong,
      timing: '1.8s response',
      feedbackTitle: 'Strong Delivery:',
      feedback:
          'Clear articulation of constraints, memory trade-offs, and final '
          'decision justification.',
    ),
  ],
);
