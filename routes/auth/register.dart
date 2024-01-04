import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:postgres/postgres.dart';

Future<Response> onRequest(RequestContext context) async {
  final connection = await context.read<Future<Connection>>();
  // final data = await connection.execute(
  // return Response(body: data.toString());
  return context.request.json().then((value) async {
    var count = await connection.execute(
        "SELECT COUNT(*) FROM users WHERE email = '${value["email"]}'");
    if (count.first.first! as int < 1) {
      await connection.execute(
          "INSERT INTO users (name, email, password) VALUES ('${value["username"]}', '${value["email"]}', '${value["password"]}')");
      await connection.close().then((value) => print('Database Disconnect'));
      return Response();
    } else {
      await connection.close().then((value) => print('Database Disconnect'));
      return Response(statusCode: HttpStatus.conflict);
    }
  }).catchError(
    // ignore: inference_failure_on_untyped_parameter
    (e) => Response(statusCode: HttpStatus.badRequest, body: e.toString()),
  );
}
