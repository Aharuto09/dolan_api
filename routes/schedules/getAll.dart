import 'dart:convert';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:postgres/postgres.dart';

import '../../models/dolan.dart';

Future<Response> onRequest(RequestContext context) async {
  final connection = await context.read<Future<Connection>>();
  final Map<String, dynamic> data = {};

  final result = await connection.execute(
    'SELECT * FROM dolans',
  );
  result.asMap().forEach((key, value) {
    data.addEntries({'${value[0]}': toDolan(value).toJson}.entries);
  });
  await connection.close().then((value) => print('Database Disconnect'));
  return Response(
    statusCode: HttpStatus.ok,
    headers: {'Content-Type': 'application/json'},
    body: //
        // result.toString()
        json.encode(data),
  );
}
