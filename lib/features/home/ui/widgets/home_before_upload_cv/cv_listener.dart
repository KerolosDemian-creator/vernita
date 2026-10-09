import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:vernita/features/home/logic/home_cubit.dart';
import 'package:vernita/features/home/logic/home_state.dart';
import 'package:vernita/features/main/logic/bottom_nav_cubit.dart';
import 'package:vernita/features/main/ui/widgets/custom_bottom_nav_bar.dart';
import 'package:vernita/features/home/ui/widgets/home_before_upload_cv/upload_cv_container.dart';

class CvListener extends StatelessWidget {
  const CvListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is HomeCvUploaded) {
          context.read<BottomNavCubit>().changeTab(
            CustomBottomNavBar.interviewTabIndex,
          );
        }
      },
      child: const UploadCvContainer(),
    );
  }
}
