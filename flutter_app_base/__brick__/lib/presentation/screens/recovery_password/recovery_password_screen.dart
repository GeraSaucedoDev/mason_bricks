import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:{{app_name}}/presentation/blocs/recovery_password/recovery_password_bloc.dart';
import 'package:{{app_name}}/presentation/screens/recovery_password/recovery_password_bloc_listener.dart';
import 'package:{{app_name}}/presentation/screens/recovery_password/recovery_password_view.dart';
import 'package:{{app_name}}/presentation/widgets/buttons/app_back_button.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class RecoveryPasswordScreen extends StatelessWidget {
  const RecoveryPasswordScreen({super.key});

  static const screenName = 'recovery-password-screen';

  @override
  Widget build(BuildContext context) {
    return RecoveryPasswordBlocListener(
      child: BlocBuilder<RecoveryPasswordBloc, RecoveryPasswordState>(
        builder: (context, state) {
          return PopScope(
            canPop: state.currentStep == 0,
            onPopInvokedWithResult: (didPop, _) {
              context.read<RecoveryPasswordBloc>().add(GoBackStep());

              if (didPop) {
                context.read<RecoveryPasswordBloc>().add(CleanState());
              }
            },
            child: Scaffold(
              body: SafeArea(
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      child: SizedBox(
                        height: 100.sh,
                        child: RecoveryPasswordView(
                            currentStep: state.currentStep),
                      ),
                    ),
                    Positioned(
                      top: 3.h,
                      left: 4.w,
                      child: state.currentStep != 3
                          ? AppBackButton(
                              onTap: () {
                                if (state.currentStep == 0) {
                                  context.pop();
                                } else {
                                  context
                                      .read<RecoveryPasswordBloc>()
                                      .add(GoBackStep());
                                }
                              },
                            )
                          : const SizedBox(),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
