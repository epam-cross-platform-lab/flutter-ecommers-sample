import 'dart:convert';

import 'package:ecommers/core/models/data_models/index.dart';
import 'package:ecommers/core/models/index.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';

import '../config.dart';

class AuthorizationService {
  static const String _jwtIssuer = 'eCommers Server';

  static String signToken(Map<String, dynamic> user) {
    final claimSet = JwtClaim(
      issuer: _jwtIssuer,
      subject: jsonEncode(user),
      issuedAt: DateTime.parse(Config.expirationDate),
    );

    return _encodeTokenData(issueJwtHS256(claimSet, Config.jwtSecret));
  }

  static bool isAuthorized(String authHeader) {
    final parts = authHeader.split(' ');

    if (parts == null || parts.length != 2 || parts[0] != 'Bearer') {
      return false;
    }

    return _isValidToken(parts[1]);
  }

  static bool _isValidToken(String token) {
    if (extractJwtClaimFrom(token) == null) {
      return false;
    }

    return true;
  }

  static JwtClaim extractJwtClaimFrom(String token) {
    try {
      return verifyJwtHS256Signature(token, Config.jwtSecret);
    } on JwtException {
      rethrow;
    }
  }

  static User getJwtSubject(String authorizationHeader) {
    final token = authorizationHeader.split(' ')[1];

    final jwtClaim = extractJwtClaimFrom(token);

    if (jwtClaim == null) {
      return null;
    }

    return User.fromJson(jsonDecode(jwtClaim.subject) as Map<String, dynamic>);
  }

  static String _encodeTokenData(String token) {
    final loginModel =
        LoginModel(token, Config.refreshToken, Config.expirationDate);

    return jsonEncode(loginModel);
  }
}
