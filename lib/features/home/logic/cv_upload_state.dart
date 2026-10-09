import 'package:vernita/features/home/data/models/picked_cv_model.dart';

abstract class CvUploadState {}

class HomeNoCv extends CvUploadState {}

class HomeCvLoading extends CvUploadState {}

class HomeCvUploaded extends CvUploadState {
  final PickedCvModel cv;

  HomeCvUploaded(this.cv);
}

class HomeCvError extends CvUploadState {
  final String message;
  final String? fileName;
  final int? sizeInBytes;

  HomeCvError(this.message, {this.fileName, this.sizeInBytes});
}
