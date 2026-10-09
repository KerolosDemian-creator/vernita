import 'dart:io';

import 'package:file_picker/file_picker.dart' as picker;
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vernita/features/home/data/models/picked_cv_model.dart';
import 'package:vernita/features/home/logic/cv_rules.dart';
import 'package:vernita/features/home/logic/cv_upload_state.dart';

class CvUploadCubit extends Cubit<CvUploadState> {
  CvUploadCubit() : super(HomeNoCv());

  Future<void> pickCv() async {
    emit(HomeCvLoading());

    try {
      final result = await picker.FilePicker.pickFiles(
        type: picker.FileType.custom,
        allowedExtensions: CvRules.allowedExtensions,
      );

      if (result.isEmpty) {
        emit(HomeNoCv());
        return;
      }

      final file = result.single;
      final extension = (file.extension ?? '').toLowerCase();
      final path = file.path;

      debugPrint('Selected file: ${file.name}');
      debugPrint('Selected extension: $extension');

      // 1. Validate extension.
      if (!CvRules.allowedExtensions.contains(extension)) {
        emit(
          HomeCvError(
            'Unsupported file format. Please choose PDF, DOC, or DOCX.',
            fileName: file.name,
          ),
        );
        return;
      }

      // 2. Validate path.
      if (path == null || path.isEmpty) {
        emit(
          HomeCvError(
            'We couldn\'t read this file. Please try another one.',
            fileName: file.name,
          ),
        );
        return;
      }

      // 3. Validate file size.
      final sizeInBytes = await File(path).length();

      if (sizeInBytes > CvRules.maxSizeInBytes) {
        emit(
          HomeCvError(
            'Your CV exceeds the maximum allowed file size.',
            fileName: file.name,
            sizeInBytes: sizeInBytes,
          ),
        );
        return;
      }

      // 4. CV is valid.
      emit(
        HomeCvUploaded(
          PickedCvModel(name: file.name, path: path, sizeInBytes: sizeInBytes),
        ),
      );
    } catch (e, stackTrace) {
      debugPrint('CV picking failed: $e');
      debugPrintStack(stackTrace: stackTrace);

      emit(
        HomeCvError(
          'Something went wrong while selecting your CV. Please try again.',
        ),
      );
    }
  }

  void removeCv() {
    emit(HomeNoCv());
  }
}
