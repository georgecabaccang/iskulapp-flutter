import 'package:flutter/material.dart';
import 'package:school_erp/features/auth/auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

AuthenticatedUser getAuthUser(BuildContext context) {
  final authState = context.read<AuthBloc>().state;
  return switch (authState) {
    Authenticated(:final user) => user,
    _ => throw Exception('User must be authenticated'),
  };
}

String getTeacherId(BuildContext context) {
  final authUser = getAuthUser(context);
  if (authUser.loginType != 'teacher') {
    throw Exception('Only teachers can create assignments');
  }

  return authUser.loginId;
}
