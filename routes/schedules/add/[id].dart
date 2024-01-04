import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:postgres/postgres.dart';

Future<Response> onRequest(RequestContext context, String id) async {
  return switch (context.request.method) {
    HttpMethod.post => addSchedule(context, id),
    _ => Future.value(Response())
  };
}

Future<Response> addSchedule(RequestContext context, String id) async {
  final connection = await context.read<Future<Connection>>();

  return context.request.json().then((value) async {
    Response response = Response();
    if (value["date_for"] != null &&
        value["time_for"] != null &&
        value["loc"] != null &&
        value["address"] != null &&
        value["id_group"] != null) {
      await connection
          .execute(
        "INSERT INTO Schedules (date_for, time_for, loc, address, id_group) VALUES ('${value["date_for"]}', '${value["time_for"]}', '${value["loc"]}', '${value["address"]}', ${value["id_group"]}) RETURNING id",
      )
          .then((value) async {
        await connection.execute(
            "INSERT INTO joingroups (id_user, id_schedule) VALUES ($id, ${value.first.first})");
        response = Response();
      }).catchError((onError) {
        response = Response(
          statusCode: HttpStatus.internalServerError,
        );
      });
    } else {
      response = Response(statusCode: HttpStatus.badRequest);
    }
    // print(
    await connection.close().then((value) => print('Database Disconnect'));
    // "UPDATE users SET nama = '${value["username"]}', url_profile = '${value["url"]}' WHERE email = '${value["email"]}'");
    return response;
  });
}
