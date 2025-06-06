import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:{{app_name}}/presentation/screens/register/register_bloc_listener.dart';
import 'package:{{app_name}}/presentation/screens/register/register_view.dart';
import 'package:{{app_name}}/presentation/widgets/buttons/app_back_button.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:{{app_name}}/presentation/blocs/register/register_bloc.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  static const String screenName = 'register-screen';

  @override
  Widget build(BuildContext context) {
    final int currentStep = context.select<RegisterBloc, int>(
      (bloc) => bloc.state.currentStep,
    );

    return RegisterBlocListener(
      child: PopScope(
        canPop: currentStep == 0,
        onPopInvokedWithResult: (didPop, _) {
          if (didPop) {
            context.read<RegisterBloc>().add(CleanState());
          } else {
            context.read<RegisterBloc>().add(PreviousStepPressed());
          }
        },
        child: Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: SizedBox(
                    height: 100.sh,
                    child: RegisterView(currentStep: currentStep),
                  ),
                ),
                if (currentStep != 2)
                  Positioned(
                    top: 3.h,
                    left: 4.w,
                    child: AppBackButton(
                      onTap: () {
                        if (currentStep == 0) {
                          context.pop();
                        } else {
                          context.read<RegisterBloc>().add(
                                PreviousStepPressed(),
                              );
                        }
                      },
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
