import 'dart:convert';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:postgres/postgres.dart';

import '../../models/message.dart';

Future<Response> onRequest(RequestContext context, String id_schedule) async {
  final connection = await context.read<Future<Connection>>();
  final parameter = int.tryParse(id_schedule);
  final Map<String, dynamic> data = {};

  if (parameter != null) {
    final result = await connection.execute(
      'SELECT messages.content, messages.create_date, messages.create_time, users.name, messages.id_schedule FROM messages JOIN users ON messages.id_sender = users.id WHERE messages.id_schedule = $parameter',
    );
    result.asMap().forEach((key, value) {
      data.addEntries({'$key': toMessage(value).toJson}.entries);
    });
    await connection.close().then((value) => print('Database Disconnect'));
    return Response(
      statusCode: HttpStatus.ok,
      headers: {'Content-Type': 'application/json'},
      body:
          // result.toString()
          json.encode(data),
    );
  } else {
    await connection.close().then((value) => print('Database Disconnect'));
    return Response(statusCode: HttpStatus.badRequest);
  }
}
