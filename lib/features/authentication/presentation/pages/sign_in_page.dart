import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:videochat_client/features/authentication/presentation/bloc/session_cubit/session_cubit.dart';
import 'package:videochat_client/features/authentication/presentation/bloc/session_cubit/session_state.dart';
import 'package:videochat_client/locator_service.dart';

class SignInPage extends StatelessWidget {
  static const String route = '/auth/sign-in';
  final String redirectAfterSignIn;

  const SignInPage({
    Key? key,
    required this.redirectAfterSignIn,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionCubit, SessionState>(
      builder: (BuildContext context, SessionState state) {
        Widget widget = _signInForm();
        if (state is SessionStateLoading) {
          widget = _loadingIndicator();
        } else if (state is SessionStateLoaded) {
          // print(state.session.idToken.nickname);
          Navigator.of(context).pushNamed(redirectAfterSignIn);
        }

        print(state);
        print(state.runtimeType);

        return Scaffold(
          body: SafeArea(
            child: Container(
              child: Center(
                child: widget,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _loadingIndicator() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: CircularProgressIndicator(),
    );
  }

  Widget _signInForm() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
          child: OutlinedButton(
        child: Text('sign - in'),
        onPressed: () {
          sl<SessionCubit>().signIn();
        },
      )),
    );
  }
}
