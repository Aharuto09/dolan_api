import 'dart:convert';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:postgres/postgres.dart';

import '../../models/user.dart';

Future<Response> onRequest(RequestContext context) async {
  final connection = await context.read<Future<Connection>>();
  print("disni");
  return context.request.json().then((value) async {
    final data = await connection.execute(
        "SELECT * FROM users WHERE email='${value["email"]}' and password='${value["password"]}'");
    await connection.close().then((value) => print("Database Disconnect"));

    if (data.isNotEmpty) {
      return Response(body: json.encode(toUser(data.first).toJson));
    } else {
      return Response(statusCode: HttpStatus.badRequest);
    }
  });
}

  // final data = await connection.execute('SELECT * FROM users');

