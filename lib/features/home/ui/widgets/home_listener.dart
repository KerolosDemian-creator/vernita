import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vernita/features/home/logic/cv_state.dart';
import 'package:vernita/features/home/logic/cv_upload_cubit.dart';
import 'package:vernita/features/home/ui/widgets/home_after_upload_cv/home_after_upload_cv.dart';
import 'package:vernita/features/home/ui/widgets/home_before_upload_cv/home_before_upload_cv.dart';

class HomeListener extends StatelessWidget {
  const HomeListener({super.key});

  bool _hasActiveCv(CvState state) {
    if (state is CvError &&
        (state.actionType == CvActionType.fetch ||
            state.actionType == CvActionType.upload)) {
      return false;
    }

    if (state is CvLoaded) {
      return state.cv != null;
    }

    return state.cvs.any((cv) => cv.active);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CvUploadCubit, CvState>(
      builder: (context, state) {
        if (_hasActiveCv(state)) {
          return const HomeAfterUploadCv();
        }

        return const HomeBeforeUploadCv();
      },
    );
  }
}
