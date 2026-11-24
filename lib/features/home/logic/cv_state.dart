import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vernita/features/home/data/models/cv_response_model.dart';

part 'cv_state.freezed.dart';

enum CvActionType { fetch, upload, delete, download }

@freezed
abstract class CvState with _$CvState {
  const factory CvState.initial({@Default([]) List<CvResponseModel> cvs}) =
      CvInitial;

  const factory CvState.loading({
    @Default([]) List<CvResponseModel> cvs,
    required CvActionType actionType,
  }) = CvLoading;

  const factory CvState.loaded({
    @Default([]) List<CvResponseModel> cvs,
    required CvActionType actionType,
    CvResponseModel? cv,
  }) = CvLoaded;

  const factory CvState.error({
    required String message,
    @Default([]) List<CvResponseModel> cvs,
    required CvActionType actionType,
    String? fileName,
    int? sizeInBytes,
  }) = CvError;
}
