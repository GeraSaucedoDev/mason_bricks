import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:{{app_name}}/presentation/blocs/register/register_bloc.dart';
import 'package:{{app_name}}/presentation/widgets/overlays/loading_overlay.dart';
import 'package:{{app_name}}/presentation/widgets/snackbars/app_snackbar.dart';

class RegisterBlocListener extends StatelessWidget {
  final Widget child;

  const RegisterBlocListener({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterBlocState>(
      /* listenWhen: (previous, current) {
        return previous.status != current.status ||
            previous.errorMessage != current.errorMessage;
      }, */
      listener: (context, state) {
        final bloc = context.read<RegisterBloc>();

        if (state.status == RegisterStatus.success) {
          AppSnackbar.show(
            context,
            'Registro exitoso',
            type: SnackbarType.success,
          );
          context.go('/');
          bloc.add(CleanState());
          if (state.errorMessage.isNotEmpty) {
            bloc.add(CleanError());
          }
        }

        if (state.status == RegisterStatus.failure) {
          if (state.errorMessage.isNotEmpty) {
            AppSnackbar.show(context, state.errorMessage);
            bloc.add(CleanError());
          }
        }

        if (state.isLoading) {
          LoadingOverlay.show(context);
        } else {
          LoadingOverlay.remove();
        }
      },
      child: child,
    );
  }
}
