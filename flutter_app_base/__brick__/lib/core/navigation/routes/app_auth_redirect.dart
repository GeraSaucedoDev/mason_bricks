import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:{{app_name}}/presentation/blocs/auth/auth_bloc.dart';

final Set<String> publicRoutes = {
  '/login',
  '/login/recovery-password',
  '/register',
};

FutureOr<String?> authRedirect(
  BuildContext context,
  GoRouterState state,
) async {
  log('NAVIGATION: ${state.fullPath}');

  final authBloc = context.read<AuthBloc>();
  final authStatus = authBloc.state.authStatus;
  final isGoingTo = state.matchedLocation;

  if (authStatus == AuthStatus.notAuthenticated) {
    return publicRoutes.contains(isGoingTo) ? null : '/login';
  }

  if (authStatus == AuthStatus.authenticated) {
    return publicRoutes.contains(isGoingTo) ? '/' : null;
  }

  return null;
}
