import 'dart:convert';

import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:videochat_client/core/errors/exceptions/server_exception.dart';
import 'package:videochat_client/features/authentication/data/models/session_id_token_model.dart';
import 'package:videochat_client/features/authentication/data/models/session_model.dart';

abstract class SessionRemoteDatasource {
  /// Calls authentication to create session method
  ///
  /// throws a [ServerException] for all errors
  Future<SessionModel> createSession();

  /// Calls authentication to restore session method
  ///
  /// throws a [ServerException] for all errors
  Future<SessionModel> restoreSession(String refreshToken);
}

class SessionRemoteDatasourceImpl implements SessionRemoteDatasource {
  final FlutterAppAuth appAuth;

  SessionRemoteDatasourceImpl({required this.appAuth});

  @override
  Future<SessionModel> createSession() async {
    try {
      print(dotenv.env['AUTH0_CLIENT_ID']);
      print(dotenv.env['AUTH0_REDIRECT_URI']);
      print(dotenv.env['AUTH0_DOMAIN']);
      final AuthorizationTokenResponse? result =
          await appAuth.authorizeAndExchangeCode(
        AuthorizationTokenRequest(
          dotenv.env['AUTH0_CLIENT_ID']!,
          dotenv.env['AUTH0_REDIRECT_URI']!,
          issuer: 'https://${dotenv.env['AUTH0_DOMAIN']}',
          scopes: ['openid', 'profile', 'offline_access'],
          // promptValues: ['login']
        ),
      );

      if (result == null) {
        throw ServerException();
      }

      return SessionModel(
        accessToken: result.accessToken!,
        refreshToken: result.refreshToken!,
      );
    } catch (e, s) {
      throw ServerException();
    }
  }

  @override
  Future<SessionModel> restoreSession(String refreshToken) async {
    try {
      final TokenResponse? result = await appAuth.token(
        TokenRequest(
            dotenv.env['AUTH0_CLIENT_ID']!, dotenv.env['AUTH0_REDIRECT_URI']!,
            issuer: 'https://${dotenv.env['AUTH0_DOMAIN']}',
            scopes: ['openid', 'profile', 'offline_access'],
            refreshToken: refreshToken
            // promptValues: ['login']
            ),
      );

      if (result == null) {
        throw ServerException();
      }

      return SessionModel(
        accessToken: result.accessToken!,
        refreshToken: result.refreshToken!,
      );
    } catch (e, s) {
      throw ServerException();
    }
  }

  SessionIdTokenModel _parseIdToken(String idToken) {
    final parts = idToken.split(r'.');
    assert(parts.length == 3);

    final json = jsonDecode(
        utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))));

    return SessionIdTokenModel.fromJson(json);
  }
}
