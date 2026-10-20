import 'package:flutter/material.dart';

enum NotificationSection { interview, accountSecurity, engagement }

class NotificationPrefModel {
  const NotificationPrefModel({
    required this.id,
    required this.section,
    required this.icon,
    required this.title,
    required this.enabled,
    this.subtitle,
  });

  final String id;
  final NotificationSection section;
  final IconData icon;
  final String title;
  final String? subtitle;
  final bool enabled;

  NotificationPrefModel copyWith({bool? enabled}) => NotificationPrefModel(
        id: id,
        section: section,
        icon: icon,
        title: title,
        subtitle: subtitle,
        enabled: enabled ?? this.enabled,
      );

  /// Default preferences (until they come from the API).
  static const List<NotificationPrefModel> defaults = [
    NotificationPrefModel(
      id: 'scheduled_reminders',
      section: NotificationSection.interview,
      icon: Icons.event_outlined,
      title: 'Scheduled Reminders',
      subtitle: 'Get reminded before your sessions',
      enabled: true,
    ),
    NotificationPrefModel(
      id: 'performance_insights',
      section: NotificationSection.interview,
      icon: Icons.insights_rounded,
      title: 'Performance Insights',
      subtitle: 'Weekly score updates and tips',
      enabled: true,
    ),
    NotificationPrefModel(
      id: 'new_ai_features',
      section: NotificationSection.interview,
      icon: Icons.bolt_rounded,
      title: 'New AI Features',
      subtitle: 'When new interview modes drop',
      enabled: false,
    ),
    NotificationPrefModel(
      id: 'security_alerts',
      section: NotificationSection.accountSecurity,
      icon: Icons.shield_outlined,
      title: 'Security Alerts',
      subtitle: 'Suspicious login attempts',
      enabled: true,
    ),
    NotificationPrefModel(
      id: 'streak_reminders',
      section: NotificationSection.engagement,
      icon: Icons.trending_up_rounded,
      title: 'Streak Reminders',
      enabled: true,
    ),
    NotificationPrefModel(
      id: 'achievements',
      section: NotificationSection.engagement,
      icon: Icons.emoji_events_outlined,
      title: 'Achievements',
      subtitle: 'Celebrate your milestones',
      enabled: true,
    ),
    NotificationPrefModel(
      id: 'tips_motivation',
      section: NotificationSection.engagement,
      icon: Icons.chat_bubble_outline_rounded,
      title: 'Tips & Motivation',
      subtitle: 'Useful tips and motivation to keep going',
      enabled: true,
    ),
  ];
}
