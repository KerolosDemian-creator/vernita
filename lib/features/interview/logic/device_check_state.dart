enum DeviceStatus { checking, ready, denied, permanentlyDenied, unavailable }

class DeviceCheckState {
  const DeviceCheckState({
    this.camera = DeviceStatus.checking,
    this.mic = DeviceStatus.checking,
    this.level = 0,
    this.noisy = false,
  });

  final DeviceStatus camera;
  final DeviceStatus mic;

  /// Microphone level from 0 to 1.
  final double level;

  /// True when the background noise stayed high for a few seconds.
  /// It's a warning only: it does not block the user.
  final bool noisy;

  bool get canContinue =>
      camera == DeviceStatus.ready && mic == DeviceStatus.ready;

  DeviceCheckState copyWith({
    DeviceStatus? camera,
    DeviceStatus? mic,
    double? level,
    bool? noisy,
  }) {
    return DeviceCheckState(
      camera: camera ?? this.camera,
      mic: mic ?? this.mic,
      level: level ?? this.level,
      noisy: noisy ?? this.noisy,
    );
  }
}
