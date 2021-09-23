import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:videochat_client/features/authentication/presentation/bloc/session_cubit/session_cubit.dart';
import 'package:videochat_client/features/authentication/presentation/bloc/session_cubit/session_state.dart';

class ProtectedLayoutWrapper extends StatelessWidget {
  final String redirectTo;
  final Widget child;

  const ProtectedLayoutWrapper({
    Key? key,
    required this.redirectTo,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<SessionCubit, SessionState>(
      listener: (context, state) {
        if (!(state is SessionStateLoaded)) {
          Navigator.of(context).pushNamed(redirectTo);
        }
      },
      child: child,
    );
  }
}
