import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:postgres/postgres.dart';

Future<Response> onRequest(RequestContext context) async {
  final connection = await context.read<Future<Connection>>();

  return context.request.json().then((value) async {
    final count = await connection.execute(
        "SELECT COUNT(*) FROM joingroups WHERE joingroups.id_user = ${value["id_user"]} AND joingroups.id_schedule = ${value["id_schedule"]}");

    Response response;
    if (count.first.first as int < 1) {
      response = Response();
      await connection.execute(
          "INSERT INTO joingroups (id_user, id_schedule) VALUES (${value["id_user"]}, ${value["id_schedule"]})");
    } else {
      response = Response(statusCode: HttpStatus.conflict);
    }

    await connection.close().then((value) => print('Database Disconnect'));
    return response;
  });
}
