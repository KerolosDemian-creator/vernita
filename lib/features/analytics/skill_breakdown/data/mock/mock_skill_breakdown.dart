import '../models/skill_breakdown_data.dart';

const mockSkillBreakdown = SkillBreakdownData(
  subtitle: 'Senior Product Designer • 35 min',
  groups: [
    SkillGroupData(
      type: SkillGroupType.technical,
      title: 'Technical Mastery',
      score: 92,
      metrics: [
        SkillMetricData(
          title: 'Domain Depth & Accuracy',
          score: 94,
          detail:
              'Strong trade-off justification and architectural vocabulary.',
        ),
        SkillMetricData(
          title: 'Problem-Solving Structure',
          score: 90,
          detail: 'Logical scoping and clear step-by-step edge-case handling.',
        ),
      ],
    ),
    SkillGroupData(
      type: SkillGroupType.delivery,
      title: 'Delivery & Response',
      score: 85,
      metrics: [
        SkillMetricData(
          title: 'Response Latency',
          score: 88,
          detail: 'Avg latency 2.4s • Fast cognitive pickup, natural pauses.',
        ),
        SkillMetricData(
          title: 'Vocal Flow & Conciseness',
          score: 82,
          detail:
              '3.1 filler words/min • Steady cadence maintained throughout.',
        ),
      ],
    ),
    SkillGroupData(
      type: SkillGroupType.visual,
      title: 'Visual Presence (CV)',
      score: 79,
      metrics: [
        SkillMetricData(
          title: 'Eye Engagement & Focus',
          score: 84,
          detail: '78% gaze in natural contact zone • Minimal static staring.',
        ),
        SkillMetricData(
          title: 'Posture & Alignment',
          score: 82,
          detail:
              "Open shoulder frame • 2 minor slouching ('turtle') "
              'recoveries.',
        ),
        SkillMetricData(
          title: 'Composure & Movement Control',
          score: 74,
          detail:
              '3.4 fidget touches/min • Hand-to-neck touches during hard '
              'questions.',
        ),
        SkillMetricData(
          title: 'Emotional Receptivity & Valence',
          score: 76,
          detail: 'Attentive neutral baseline • 5 genuine smiles registered.',
        ),
      ],
    ),
  ],
);
