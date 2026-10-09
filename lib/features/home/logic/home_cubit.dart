import 'package:file_picker/file_picker.dart' as picker;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vernita/features/home/data/models/picked_cv_model.dart';
import 'package:vernita/features/home/logic/cv_rules.dart';
import 'package:vernita/features/home/logic/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeNoCv());
  Future<void> pickCv() async {
    try {
      final result = await picker.FilePicker.pickFiles(
        type: picker.FileType.custom,
        allowedExtensions: CvRules.allowedExtensions,
      );

      if (result.isEmpty) return;

      final file = result.single;
      final extension = (file.extension ?? '').toLowerCase();

      if (!CvRules.allowedExtensions.contains(extension)) {
        emit(HomeCvError('Only PDF, DOC, and DOCX files are allowed.'));
        return;
      }

      if (file.path == null) {
        emit(HomeCvError('Could not read this file. Please try another one.'));
        return;
      }

      emit(
        HomeCvUploaded(
          PickedCvModel(name: file.name, path: file.path!, sizeInBytes: 0),
        ),
      );
    } catch (_) {
      emit(HomeCvError('Something went wrong while picking the file.'));
    }
  }

  void removeCv() => emit(HomeNoCv());
}
