import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:{{app_name}}/presentation/blocs/recovery_password/recovery_password_bloc.dart';
import 'package:{{app_name}}/presentation/widgets/overlays/loading_overlay.dart';
import 'package:{{app_name}}/presentation/widgets/snackbars/app_snackbar.dart';

class RecoveryPasswordBlocListener extends StatelessWidget {
  const RecoveryPasswordBlocListener({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<RecoveryPasswordBloc, RecoveryPasswordState>(
          listenWhen: (previous, current) {
            return previous.isLoading != current.isLoading ||
                previous.errorMessage != current.errorMessage;
          },
          listener: (context, state) {
            if (state.isLoading) {
              LoadingOverlay.show(context);
            } else {
              LoadingOverlay.remove();
            }

            if (state.errorMessage.trim().isNotEmpty) {
              AppSnackbar.show(context, state.errorMessage);
              context.read<RecoveryPasswordBloc>().add(CleanError());
            }
          },
        ),
      ],
      child: child,
    );
  }
}
