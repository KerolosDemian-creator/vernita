import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vernita/features/home/logic/cv_state.dart';
import 'package:vernita/features/home/logic/cv_upload_cubit.dart';
import 'package:vernita/features/home/ui/widgets/home_before_upload_cv/cv_error_container.dart';
import 'package:vernita/features/home/ui/widgets/home_before_upload_cv/cv_loading_container.dart';
import 'package:vernita/features/home/ui/widgets/home_before_upload_cv/upload_cv_container.dart';

class CvListener extends StatelessWidget {
  const CvListener({super.key});

  bool _isFetchOrUpload(CvActionType actionType) {
    return actionType == CvActionType.fetch ||
        actionType == CvActionType.upload;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CvUploadCubit, CvState>(
      builder: (context, state) {
        if (state is CvInitial) {
          return const CvLoadingContainer();
        }

        if (state is CvLoading) {
          if (_isFetchOrUpload(state.actionType)) {
            return const CvLoadingContainer();
          }

          return const UploadCvContainer();
        }

        if (state is CvError) {
          if (_isFetchOrUpload(state.actionType)) {
            return CvErrorContainer(error: state);
          }

          return const UploadCvContainer();
        }

        return const UploadCvContainer();
      },
    );
  }
}
