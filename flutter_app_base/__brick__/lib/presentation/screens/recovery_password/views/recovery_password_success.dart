import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:{{app_name}}/core/localization/extension/localization_extension.dart';
import 'package:{{app_name}}/core/theme/extensions/textstyles_extension.dart';
import 'package:{{app_name}}/core/theme/extensions/theme_extensions.dart';
import 'package:{{app_name}}/core/theme/icons/index.dart';
import 'package:{{app_name}}/presentation/blocs/recovery_password/recovery_password_bloc.dart';
import 'package:{{app_name}}/presentation/widgets/buttons/app_primary_button.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class RecoveryPasswordCompleteSuccess extends StatelessWidget {
  const RecoveryPasswordCompleteSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppIcon(AppIcons.success_mark),
          SizedBox(height: 4.h),
          Text(
            context.l10n.passwordChangedTitle,
            textAlign: TextAlign.center,
            style: context.textStyles.poppins.titleLarge,
          ),
          SizedBox(height: 3.h),
          Text(
            context.l10n.passwordChangedMessage,
            textAlign: TextAlign.center,
            style: context.textStyles.poppins.titleMed.copyWith(
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(height: 6.h),
          AppPrimaryButton(
            backgroundColor: context.colorScheme.primary,
            onPressed: () {
              context.pop();
              context.read<RecoveryPasswordBloc>().add(CleanState());
            },
            child: Text(context.l10n.continue_btn),
          ),
          SizedBox(height: 5.h),
        ],
      ),
    );
  }
}
