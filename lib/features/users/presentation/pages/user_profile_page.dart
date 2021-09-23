import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:videochat_client/features/authentication/domain/entities/user.dart';
import 'package:videochat_client/features/authentication/presentation/bloc/session_cubit/session_cubit.dart';
import 'package:videochat_client/features/authentication/presentation/bloc/session_cubit/session_state.dart';
import 'package:videochat_client/features/users/presentation/widgets/user_profile.dart';
import 'package:videochat_client/locator_service.dart';

///
/// User profile page. Display information about the user
/// Allows user:
/// - to [logout]
/// - to [change_settings]
///
class UserProfilePage extends StatelessWidget {
  static const String route = '/profile';

  const UserProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionCubit, SessionState>(
      builder: (context, state) {
        UserEntity? user = null;

        if (state is SessionStateLoaded) {
          user = state.session.user;
        }

        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 200,
                pinned: true,
                floating: true,
                snap: true,
                backgroundColor: Colors.white,
                flexibleSpace: FlexibleSpaceBar(
                  // title: Text(user.fullName),
                  collapseMode: CollapseMode.pin,
                  background: user != null ? UserProfile(user: user) : null,
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  ListTile(
                    leading: Icon(Icons.map),
                    title: Text('Contacts'),
                  ),
                  ListTile(
                    leading: Icon(Icons.photo_album),
                    title: Text('Settings'),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.phone),
                    title: Text('Logout'),
                    onTap: _handleLogoutPress,
                  ),
                ]),
              )
            ],
          ),
        );
      },
    );
  }

  Future<void> _handleLogoutPress() async {
    print('logout pressed');

    try {
      sl<SessionCubit>().logout();
    } catch (e) {
      print('Error during logout ${e.toString()}');
    }
  }
}
