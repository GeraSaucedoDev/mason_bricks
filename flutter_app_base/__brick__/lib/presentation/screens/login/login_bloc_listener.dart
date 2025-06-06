import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:{{app_name}}/presentation/blocs/auth/auth_bloc.dart';
import 'package:{{app_name}}/presentation/blocs/login/login_bloc.dart';
import 'package:{{app_name}}/presentation/widgets/overlays/loading_overlay.dart';
import 'package:{{app_name}}/presentation/widgets/snackbars/app_snackbar.dart';

class LoginBlocListener extends StatelessWidget {
  final Widget child;

  const LoginBlocListener({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final loginBloc = context.read<LoginBloc>();
    final authBloc = context.read<AuthBloc>();

    return MultiBlocListener(
      listeners: [
        BlocListener<AuthBloc, AuthState>(
          listenWhen: (prev, curr) => prev.authStatus != curr.authStatus,
          listener: (context, state) {
            // Navigate to home screen when auth status changed,
            // triggered below on login bloc listener when Form status is success
            if (state.authStatus == AuthStatus.authenticated) {
              context.go('/');
            }
          },
        ),
        BlocListener<LoginBloc, LoginBlocState>(
          listenWhen: (p, c) {
            return p.isLoading != c.isLoading ||
                p.errorMessage != c.errorMessage;
          },
          listener: (context, state) {
            // Show loading overlay
            state.isLoading
                ? LoadingOverlay.show(context)
                : LoadingOverlay.remove();

            // Handle success login
            if (state.successLogin) {
              authBloc.add(ChangeAuthUser(state.user!));
              loginBloc.add(CleanState());
              authBloc.add(ChangeAuthStatus(AuthStatus.authenticated));
            }

            // Handle error message
            if (state.errorMessage.isNotEmpty) {
              AppSnackbar.show(context, state.errorMessage);

              /// We need to clean message error to allow bloc listener react with new
              /// error message althougt is same message as before one
              loginBloc.add(CleanError());
            }
          },
        ),
      ],
      child: child,
    );
  }
}
