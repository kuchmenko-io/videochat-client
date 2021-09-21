import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:videochat_client/features/authentication/presentation/bloc/session_cubit/session_cubit.dart';
import 'package:videochat_client/features/authentication/presentation/bloc/session_cubit/session_state.dart';

class UserProfilePage extends StatelessWidget {
  static const String route = '/profile';

  const UserProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionCubit, SessionState>(
      builder: (context, state) {
        var session = (state as SessionStateLoaded).session;
        return Scaffold(
          body: Container(
            child: Center(
              child: Text(session.user.fullName),
            ),
          ),
        );
      },
    );
  }
}
