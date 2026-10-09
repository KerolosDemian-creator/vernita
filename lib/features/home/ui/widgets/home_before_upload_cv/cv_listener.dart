import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vernita/features/home/logic/cv_upload_cubit.dart';
import 'package:vernita/features/home/logic/cv_upload_state.dart';
import 'package:vernita/features/home/ui/widgets/home_before_upload_cv/cv_error_container.dart';
import 'package:vernita/features/home/ui/widgets/home_before_upload_cv/cv_loading_container.dart';
import 'package:vernita/features/home/ui/widgets/home_before_upload_cv/upload_cv_container.dart';
import 'package:vernita/features/main/logic/bottom_nav_cubit.dart';
import 'package:vernita/features/main/ui/widgets/custom_bottom_nav_bar.dart';

class CvListener extends StatelessWidget {
  const CvListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<CvUploadCubit, CvUploadState>(
      listener: (context, state) {
        if (state is HomeCvUploaded) {
          context.read<BottomNavCubit>().changeTab(
            CustomBottomNavBar.interviewTabIndex,
          );
        }
      },
      child: BlocBuilder<CvUploadCubit, CvUploadState>(
        builder: (context, state) {
          if (state is HomeCvLoading) {
            return const CvLoadingContainer();
          }

          if (state is HomeCvError) {
            return CvErrorContainer(error: state);
          }

          return const UploadCvContainer();
        },
      ),
    );
  }
}
