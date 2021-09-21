import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:videochat_client/core/errors/exceptions/cache_exception.dart';
import 'package:videochat_client/features/authentication/data/models/session_model.dart';

const CACHE_AUTH_SESSION_KEY = 'auth_session';

abstract class SessionLocalDatasource {
  Future<SessionModel> getSession();
  Future<void> setSession(SessionModel session);
  Future<void> clearSession();
}

class SessionLocalDatasourceImpl implements SessionLocalDatasource {
  final FlutterSecureStorage storage;

  SessionLocalDatasourceImpl({
    required this.storage,
  });

  @override
  Future<void> clearSession() async {
    await storage.delete(key: CACHE_AUTH_SESSION_KEY);
  }

  @override
  Future<SessionModel> getSession() async {
    final isSessionExists =
        await storage.containsKey(key: CACHE_AUTH_SESSION_KEY);

    if (!isSessionExists) {
      throw CacheException();
    }
    final json = await storage.read(key: CACHE_AUTH_SESSION_KEY);

    if (json == null) {
      throw CacheException();
    }

    try {
      return SessionModel.fromJson(jsonDecode(json));
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> setSession(SessionModel session) async {
    try {
      final json = session.toJson();

      await storage.write(key: CACHE_AUTH_SESSION_KEY, value: jsonEncode(json));
    } catch (e) {
      throw CacheException();
    }
  }
}
