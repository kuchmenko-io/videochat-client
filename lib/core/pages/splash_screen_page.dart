import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:videochat_client/features/authentication/presentation/bloc/session_cubit/session_cubit.dart';
import 'package:videochat_client/features/authentication/presentation/bloc/session_cubit/session_state.dart';

class SplashScreenPage extends StatelessWidget {
  static const String route = '/splash-screen';
  final String redirectOnSuccessUrl;
  final String redirectOnErrorUrl;

  const SplashScreenPage({
    Key? key,
    required this.redirectOnSuccessUrl,
    required this.redirectOnErrorUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<SessionCubit, SessionState>(
      listener: (context, state) {
        if (state is SessionStateLoaded) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            redirectOnSuccessUrl,
            (r) => false,
          );
        } else if (state is SessionStateFailure) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            redirectOnErrorUrl,
            (r) => false,
          );
        }
      },
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  const Color(0xFF373B44),
                  const Color(0xFF4286f4),
                ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
          child: Center(
            child: Text(
              'Video Chat',
              style: Theme.of(context).textTheme.headline3!.merge(
                    TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
