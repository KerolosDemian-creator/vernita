import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vernita/features/home/logic/cv_upload_cubit.dart';
import 'package:vernita/features/home/logic/cv_upload_state.dart';
import 'package:vernita/features/home/ui/widgets/home_after_upload_cv/home_after_upload_cv.dart';
import 'package:vernita/features/home/ui/widgets/home_before_upload_cv/home_before_upload_cv.dart';

class HomeListener extends StatelessWidget {
  const HomeListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CvUploadCubit, CvUploadState>(
  builder: (context, state) {
    if (state is HomeCvUploaded) {
      return const HomeAfterUploadCv();
    }

    return const HomeBeforeUploadCv();
  },
);
  }
}