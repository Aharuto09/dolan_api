import 'dart:convert';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:postgres/postgres.dart';

import '../../../models/schedule.dart';

Future<Response> onRequest(RequestContext context, String id) async {
  final connection = await context.read<Future<Connection>>();
  final parameter = int.tryParse(id);
  final Map<String, dynamic> data = {};

  if (parameter != null) {
    final result = await connection.execute(
      'SELECT schedules.id, schedules.date_for, schedules.time_for, schedules.loc, schedules.address, dolans.name, dolans.min_member FROM joingroups JOIN schedules ON joingroups.id_schedule = schedules.id JOIN dolans ON schedules.id_group = dolans.id WHERE joingroups.id_user = $parameter',
    );
    result.asMap().forEach((key, value) {
      data.addEntries({'$key': toSchedule(value).toJson}.entries);
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
