import 'dart:convert';

import 'package:ecommers/web_server/models/user.dart';
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

    const String secret = Config.jwtSecret;

    return _encodeTokenData (issueJwtHS256(claimSet, secret));
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
    const key = Config.jwtSecret;

    try {
      return verifyJwtHS256Signature(token, key);
    } on JwtException {
      print('invalid token');
    }

    return null;
  }

  static User getJwtSubject(String token) {
    final jwtClaim = extractJwtClaimFrom(token);

    if (jwtClaim == null) {
      return null;
    }

    return User.fromJson(jsonDecode(jwtClaim.subject) as Map<String, dynamic>);
  }

  static String _encodeTokenData(String token) {
    final loginModelMap = {
      'access_token': token,
      'refresh_token': Config.refreshToken,
      'expiration_date': Config.expirationDate
    };

    return jsonEncode(loginModelMap);
  }
}
