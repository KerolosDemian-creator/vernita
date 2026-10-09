import 'package:vernita/features/home/data/models/picked_cv_model.dart';

abstract class HomeState {}

class HomeNoCv extends HomeState {}

class HomeCvUploaded extends HomeState {
  final PickedCvModel cv;
  HomeCvUploaded(this.cv);
}

class HomeCvError extends HomeState {
  final String message;
  HomeCvError(this.message);
}