import 'package:dart_frog/dart_frog.dart';
import 'package:postgres/postgres.dart';

Future<Response> onRequest(RequestContext context) async {
  return switch (context.request.method) {
    HttpMethod.get => getByEmail(context),
    HttpMethod.post => updateProfile(context),
    _ => Future.value(Response())
  };
}

Future<Response> getByEmail(RequestContext context) async {
  final connection = await context.read<Future<Connection>>();

  return context.request.json().then((value) async {
    await connection.execute(
      "SELECT * users WHERE email = '${value["email"]}'",
    );
    await connection.close().then((value) => print('Database Disconnect'));
    return Response();
  });
}

Future<Response> updateProfile(RequestContext context) async {
  final connection = await context.read<Future<Connection>>();

  return context.request.json().then((value) async {
    await connection.execute(
      "UPDATE users SET name = '${value["username"]}', url_profile = '${value["url"]}' WHERE email = '${value["email"]}'",
    );
    // print(
    // "UPDATE users SET nama = '${value["username"]}', url_profile = '${value["url"]}' WHERE email = '${value["email"]}'");
    await connection.close().then((value) => print('Database Disconnect'));
    return Response();
  });
}
