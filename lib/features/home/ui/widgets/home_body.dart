import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/helper/spacing.dart';
import 'package:vernita/features/home/ui/widgets/home_after_upload_cv/home_after_upload_cv.dart';
import 'package:vernita/features/home/ui/widgets/home_header.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const HomeHeader(),
              verticalSpace(20),

              HomeAfterUploadCv(),

              //   const  HomeBeforeUploadCv()
            ],
          ),
        ),
      ),
    );
  }
}
