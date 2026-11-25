import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noise_meter/noise_meter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vernita/features/interview/logic/device_check_state.dart';

/// Owns the camera and the microphone while the readiness screen is open.
/// Everything it opens is released in [close].
class DeviceCheckCubit extends Cubit<DeviceCheckState> {
  DeviceCheckCubit() : super(const DeviceCheckState());

  /// Above this level the room is considered noisy. The values depend on the
  /// phone, so tune it by testing on real devices.
  static const double _noisyThresholdDb = 65;
  static const Duration _noisyHold = Duration(seconds: 2);

  final NoiseMeter _noiseMeter = NoiseMeter();
  StreamSubscription<NoiseReading>? _noiseSub;
  CameraController? _camera;
  DateTime? _noisySince;
  bool _busy = false;

  /// Only use it when [DeviceCheckState.camera] is [DeviceStatus.ready].
  CameraController? get cameraController => _camera;

  /// Checks (and asks for, when [request] is true) the permissions, then
  /// opens the camera and the microphone.
  Future<void> start({bool request = true}) async {
    if (_busy || isClosed) return;
    _busy = true;
    try {
      final cameraPermission = await _resolve(
        Permission.camera,
        request: request,
      );
      final micPermission = await _resolve(
        Permission.microphone,
        request: request,
      );
      if (isClosed) return;

      final camera = cameraPermission == DeviceStatus.ready
          ? await _startCamera()
          : cameraPermission;
      final mic = micPermission == DeviceStatus.ready
          ? await _startMic()
          : micPermission;
      if (isClosed) return;

      emit(state.copyWith(camera: camera, mic: mic));
    } finally {
      _busy = false;
    }
  }

  /// "Allow access" button.
  Future<void> retry() async {
    if (isClosed) return;
    emit(
      state.copyWith(
        camera: DeviceStatus.checking,
        mic: DeviceStatus.checking,
      ),
    );
    await start();
  }

  Future<void> openSettings() async {
    await openAppSettings();
  }

  /// Called when the app goes to the background.
  Future<void> releaseDevices() async {
    if (isClosed || _busy) return;

    await _noiseSub?.cancel();
    _noiseSub = null;
    _noisySince = null;

    final controller = _camera;
    _camera = null;

    // Emit first so the preview leaves the tree before the controller dies.
    emit(
      state.copyWith(
        camera: DeviceStatus.checking,
        mic: DeviceStatus.checking,
        level: 0,
        noisy: false,
      ),
    );
    await controller?.dispose();
  }

  Future<DeviceStatus> _resolve(
    Permission permission, {
    required bool request,
  }) async {
    var status = await permission.status;
    if (!status.isGranted && request && !status.isPermanentlyDenied) {
      status = await permission.request();
    }
    if (status.isGranted) return DeviceStatus.ready;
    if (status.isPermanentlyDenied) return DeviceStatus.permanentlyDenied;
    return DeviceStatus.denied;
  }

  Future<DeviceStatus> _startCamera() async {
    if (_camera != null) return DeviceStatus.ready;
    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) return DeviceStatus.unavailable;

      final description = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
        orElse: () => cameras.first,
      );
      final controller = CameraController(
        description,
        ResolutionPreset.medium,
        enableAudio: false,
      );
      await controller.initialize();

      if (isClosed) {
        await controller.dispose();
        return DeviceStatus.unavailable;
      }
      _camera = controller;
      return DeviceStatus.ready;
    } on CameraException catch (e) {
      return e.code.startsWith('CameraAccess')
          ? DeviceStatus.denied
          : DeviceStatus.unavailable;
    } catch (_) {
      return DeviceStatus.unavailable;
    }
  }

  Future<DeviceStatus> _startMic() async {
    if (_noiseSub != null) return DeviceStatus.ready;
    try {
      _noiseSub = _noiseMeter.noise.listen(
        _onNoise,
        onError: (Object _) {
          if (isClosed) return;
          emit(
            state.copyWith(
              mic: DeviceStatus.unavailable,
              level: 0,
              noisy: false,
            ),
          );
        },
      );
      return DeviceStatus.ready;
    } catch (_) {
      return DeviceStatus.unavailable;
    }
  }

  void _onNoise(NoiseReading reading) {
    if (isClosed) return;
    final db = reading.meanDecibel;
    if (db.isNaN || db.isInfinite) return;

    // About 30 dB (quiet room) -> 0, 90 dB (very loud) -> 1.
    final level = ((db - 30) / 60).clamp(0.0, 1.0).toDouble();

    final now = DateTime.now();
    if (db >= _noisyThresholdDb) {
      _noisySince ??= now;
    } else {
      _noisySince = null;
    }
    final noisy =
        _noisySince != null && now.difference(_noisySince!) >= _noisyHold;

    emit(state.copyWith(level: level, noisy: noisy));
  }

  @override
  Future<void> close() async {
    await _noiseSub?.cancel();
    _noiseSub = null;
    final controller = _camera;
    _camera = null;
    await controller?.dispose();
    return super.close();
  }
}
