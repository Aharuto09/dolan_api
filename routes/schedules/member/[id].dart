import 'dart:convert';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:postgres/postgres.dart';

Future<Response> onRequest(RequestContext context, String id) async {
  final connection = await context.read<Future<Connection>>();
  final parameter = int.tryParse(id);
  final Map<String, dynamic> data = {};

  if (parameter != null) {
    final result = await connection.execute(
      'SELECT users.id, users.name, users.url_profile FROM joingroups JOIN users ON joingroups.id_user = users.id WHERE joingroups.id_schedule = $parameter',
    );
    result.asMap().forEach((key, value) {
      data.addAll({
        '${value[0]}': {"name": value[1], "url": value[2]}
      });
    });
    await connection.close().then((value) => print('Database Disconnect'));
    return Response(
      statusCode: HttpStatus.ok,
      headers: {'Content-Type': 'application/json'},
      body: //as
          // result.toString()
          json.encode(data),
    );
  } else {
    await connection.close().then((value) => print('Database Disconnect'));
    return Response(statusCode: HttpStatus.badRequest);
  }
}
