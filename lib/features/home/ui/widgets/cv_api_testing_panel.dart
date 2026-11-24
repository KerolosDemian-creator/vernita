import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/helper/spacing.dart';
import 'package:vernita/core/theme/app_colors.dart';
import 'package:vernita/core/theme/app_text_styles.dart';
import 'package:vernita/core/widgets/app_button.dart';
import 'package:vernita/features/authentication/widgets/auth_text_field.dart';
import 'package:vernita/features/home/data/models/cv_response_model.dart';
import 'package:vernita/features/home/logic/cv_state.dart';
import 'package:vernita/features/home/logic/cv_upload_cubit.dart';

/// Temporary manual CV API controls.
///
/// Remove this widget (and its entry in HomeBody) once each CV operation is
/// connected to its final UI location.
class CvApiTestingPanel extends StatelessWidget {
  const CvApiTestingPanel({super.key});

  String _busyLabel(CvActionType actionType) {
    return switch (actionType) {
      CvActionType.fetch => 'Loading CVs...',
      CvActionType.upload => 'Uploading CV...',
      CvActionType.delete => 'Deleting CV...',
      CvActionType.download => 'Downloading CV...',
    };
  }

  String _successMessage(CvActionType actionType) {
    return switch (actionType) {
      CvActionType.fetch => 'CVs loaded.',
      CvActionType.upload => 'CV uploaded successfully.',
      CvActionType.delete => 'CV deleted successfully.',
      CvActionType.download => 'CV download completed.',
    };
  }

  String _errorLabel(CvActionType actionType) {
    return switch (actionType) {
      CvActionType.fetch => 'Fetch failed',
      CvActionType.upload => 'Upload failed',
      CvActionType.delete => 'Delete failed',
      CvActionType.download => 'Download failed',
    };
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: AppColors.warmPeach),
      ),
      child: BlocBuilder<CvUploadCubit, CvState>(
        builder: (context, state) {
          final isBusy = state is CvLoading;
          final isLoadingCvs =
              state is CvLoading && state.actionType == CvActionType.fetch;
          final message = switch (state) {
            CvError(:final message, :final actionType) =>
              '${_errorLabel(actionType)}: $message',
            CvLoaded(:final actionType) => _successMessage(actionType),
            _ => null,
          };
          final hasError = state is CvError;
          final isSuccess = state is CvLoaded;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Icon(Icons.api, size: 20.r, color: AppColors.lightPeachText),
                  horizantalSpace(8),
                  Expanded(
                    child: Text(
                      'CV API Testing',
                      style: AppTextStyles.font16BrownPoppins600W,
                    ),
                  ),
                ],
              ),
              verticalSpace(4),
              Text(
                'Temporary controls for manual CV API checks.',
                style: AppTextStyles.font12GreyPoppins400W,
              ),
              verticalSpace(12),
              if (state is CvLoading) ...[
                LinearProgressIndicator(
                  minHeight: 3.h,
                  color: AppColors.lightPeachText,
                  backgroundColor: AppColors.warmPeach,
                ),
                verticalSpace(6),
                Text(
                  _busyLabel(state.actionType),
                  style: AppTextStyles.font11GreyPoppins400W,
                ),
                verticalSpace(8),
              ],
              if (message != null) ...[
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 8.h,
                  ),
                  decoration: BoxDecoration(
                    color: hasError
                        ? AppColors.analyticsDangerSurface
                        : isSuccess
                        ? AppColors.softSage
                        : AppColors.warmCream,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: hasError
                          ? AppColors.analyticsDangerBorder
                          : isSuccess
                          ? AppColors.lightGreen
                          : AppColors.warmPeach,
                    ),
                  ),
                  child: Text(
                    message,
                    style: AppTextStyles.font12GreyPoppins400W.copyWith(
                      color: hasError
                          ? AppColors.wrongAlert
                          : isSuccess
                          ? AppColors.positiveGreen
                          : AppColors.brownText,
                    ),
                  ),
                ),
                verticalSpace(12),
              ],
              _CvTestingList(
                cvs: state.cvs,
                isLoading: isBusy,
                isFetching: isLoadingCvs,
                isInitial: state is CvInitial,
                hasError: hasError,
              ),
              verticalSpace(12),
              FormField<String>(
                initialValue: '',
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  final text = value?.trim() ?? '';

                  if (text.isEmpty) {
                    return null;
                  }

                  final id = int.tryParse(text);
                  if (id == null || id <= 0) {
                    return 'Enter a numeric CV ID.';
                  }

                  return null;
                },
                builder: (field) {
                  final id = int.tryParse(field.value?.trim() ?? '');
                  final canUseId = id != null && id > 0 && !isBusy;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AuthTextField(
                        hint: 'CV ID',
                        icon: Icons.tag,
                        controller: null,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        onChanged: field.didChange,
                      ),
                      if (field.hasError) ...[
                        verticalSpace(4),
                        Text(
                          field.errorText!,
                          style: AppTextStyles.font11GreyPoppins400W.copyWith(
                            color: AppColors.wrongAlert,
                          ),
                        ),
                      ],
                      verticalSpace(10),
                      AppButton(
                        label: 'Get CVs',
                        icon: Icons.refresh,
                        isEnabled: !isBusy,
                        margin: EdgeInsets.zero,
                        onTap: () => context.read<CvUploadCubit>().fetchCvs(),
                      ),
                      verticalSpace(8),
                      AppButton(
                        label: 'Delete CV',
                        icon: Icons.delete_outline,
                        isEnabled: canUseId,
                        margin: EdgeInsets.zero,
                        onTap: () {
                          if (id != null) {
                            context.read<CvUploadCubit>().deleteCv(id);
                          }
                        },
                      ),
                      verticalSpace(8),
                      AppButton(
                        label: 'Download CV',
                        icon: Icons.download_outlined,
                        isEnabled: canUseId,
                        margin: EdgeInsets.zero,
                        onTap: () {
                          if (id != null) {
                            context.read<CvUploadCubit>().downloadCv(id);
                          }
                        },
                      ),
                    ],
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

class _CvTestingList extends StatelessWidget {
  const _CvTestingList({
    required this.cvs,
    required this.isLoading,
    required this.isFetching,
    required this.isInitial,
    required this.hasError,
  });

  final List<CvResponseModel> cvs;
  final bool isLoading;
  final bool isFetching;
  final bool isInitial;
  final bool hasError;

  @override
  Widget build(BuildContext context) {
    if (cvs.isEmpty) {
      if (isFetching) {
        return const _CvTestingHint('Loading CVs...');
      }

      if (hasError) {
        return const _CvTestingHint('CV list unavailable.');
      }

      if (isInitial) {
        return const _CvTestingHint('Tap Get CVs to load the current CV list.');
      }

      if (isLoading) {
        return const _CvTestingHint('No CVs available.');
      }

      return const _CvTestingHint('No CVs returned.');
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: AppColors.warmCream,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          for (var index = 0; index < cvs.length; index++) ...[
            if (index > 0)
              Divider(height: 1.h, color: AppColors.analyticsDivider),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ID: ${cvs[index].id}',
                          style: AppTextStyles.font12BrownPoppins600W,
                        ),
                        Text(
                          cvs[index].fileName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.font11GreyPoppins400W,
                        ),
                      ],
                    ),
                  ),
                  horizantalSpace(8),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 3.h,
                    ),
                    decoration: BoxDecoration(
                      color: cvs[index].active
                          ? AppColors.softSage
                          : AppColors.white,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      cvs[index].active ? 'Active' : 'Inactive',
                      style: AppTextStyles.font10OliverForestPopppins700W
                          .copyWith(
                            color: cvs[index].active
                                ? AppColors.positiveGreen
                                : AppColors.greyText,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _CvTestingHint extends StatelessWidget {
  const _CvTestingHint(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.warmCream,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Text(text, style: AppTextStyles.font12GreyPoppins400W),
    );
  }
}
