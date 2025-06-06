import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:{{app_name}}/core/localization/extension/localization_extension.dart';
import 'package:{{app_name}}/core/theme/extensions/theme_extensions.dart';
import 'package:{{app_name}}/presentation/blocs/auth/auth_bloc.dart';
import 'package:{{app_name}}/presentation/widgets/overlays/loading_overlay.dart';
import 'package:{{app_name}}/presentation/widgets/snackbars/app_snackbar.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({
    super.key,
    this.child,
  });

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.errorMessage != '') {
          AppSnackbar.show(context, 'error');
          context.read<AuthBloc>().add(CleanAuthError());
        }

        if (state.isLoading) {
          LoadingOverlay.show(context);
        } else {
          LoadingOverlay.remove();
        }

        if (state.authStatus == AuthStatus.notAuthenticated) {
          context.go('/login');
        }
      },
      child: SizedBox(
        width: double.infinity,
        child: GestureDetector(
          onTap: () {
            context.read<AuthBloc>().add(LogoutRequested());
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: OutlinedButton(
              onPressed: () => context.read<AuthBloc>().add(LogoutRequested()),
              style: OutlinedButton.styleFrom(
                  side: BorderSide(color: context.colorScheme.error),
                  backgroundColor: context.colorScheme.surface,
                  foregroundColor: context.colorScheme.error),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 18),
                child: Text(
                  context.l10n.logOutButton,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontVariations: const [FontVariation('wght', 600)],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
