import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:videochat_client/features/authentication/presentation/bloc/restore_session_bloc/restore_session_bloc.dart';
import 'package:videochat_client/features/authentication/presentation/bloc/session_cubit/session_cubit.dart';
import 'package:videochat_client/features/authentication/presentation/pages/sign_in_page.dart';
import 'package:videochat_client/features/users/presentation/pages/user_profile_page.dart';
import 'package:videochat_client/locator_service.dart' as di;
import 'package:videochat_client/locator_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await di.init();

  runApp(MainApplication());
}

class MainApplication extends StatelessWidget {
  const MainApplication({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SessionCubit>(
          create: (context) => sl<SessionCubit>()..restoreSession(),
        ),
        BlocProvider<RestoreSessionBloc>(
          create: (context) => sl<RestoreSessionBloc>(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(),
        initialRoute: SignInPage.route,
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case SignInPage.route:
              return MaterialPageRoute(
                builder: (context) => SignInPage(
                  redirectAfterSignIn: UserProfilePage.route,
                ),
              );
            case UserProfilePage.route:
              return MaterialPageRoute(
                builder: (context) => UserProfilePage(),
              );
          }
        },
      ),
    );
  }
}
