import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:videochat_client/core/errors/exceptions/server_exception.dart';
import 'package:videochat_client/features/authentication/data/models/user_model.dart';

abstract class UserRemoteDatasource {
  /// Request user information based on [accessToken]
  ///
  /// throws an [ServerException] error.
  Future<UserModel> getCurrentUser(String accessToken);
}

class UserRemoteDatasourceImpl extends UserRemoteDatasource {
  final http.Client client;

  UserRemoteDatasourceImpl({required this.client});

  @override
  Future<UserModel> getCurrentUser(String accessToken) async {
    final url = Uri.parse('https://${dotenv.env['AUTH0_DOMAIN']}/userinfo');
    final response = await client.get(
      url,
      headers: {'Authorization': 'Bearer ${accessToken}'},
    );

    if (response.statusCode == 200) {
      return UserModel.fromJson(
        jsonDecode(response.body),
      );
    } else {
      throw ServerException();
    }
  }
}
