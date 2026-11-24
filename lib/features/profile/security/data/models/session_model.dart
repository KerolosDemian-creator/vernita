class SessionModel {
  const SessionModel({
    required this.id,
    required this.device,
    required this.location,
    required this.lastActive,
    this.isCurrent = false,
    this.isPhone = false,
  });

  final String id;
  final String device;
  final String location;
  final String lastActive;
  final bool isCurrent;
  final bool isPhone;

  /// Demo sessions until they come from the API.
  static const List<SessionModel> mock = [
    SessionModel(
      id: '1',
      device: 'MacBook Pro - Safari',
      location: 'Cairo, Egypt',
      lastActive: 'Just now',
      isCurrent: true,
    ),
    SessionModel(
      id: '2',
      device: 'iPhone 15 - Chrome',
      location: 'Cairo, Egypt',
      lastActive: '2 days ago',
      isPhone: true,
    ),
  ];
}
