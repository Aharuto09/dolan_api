import 'dart:convert';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:postgres/postgres.dart';

import '../../../models/schedule.dart';

Future<Response> onRequest(RequestContext context, String keyword) async {
  final connection = await context.read<Future<Connection>>();
  final Map<String, dynamic> data = {};

  if (keyword.isNotEmpty) {
    final result = await connection.execute(
      "SELECT schedules.id, schedules.date_for, schedules.time_for, schedules.loc, schedules.address, dolans.name, dolans.min_member FROM schedules JOIN dolans ON schedules.id_group = dolans.id WHERE dolans.name ILIKE '%$keyword%'",
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
