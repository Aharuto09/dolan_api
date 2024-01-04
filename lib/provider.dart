import 'package:dart_frog/dart_frog.dart';
import 'package:dolan_api/database.dart';
import 'package:postgres/postgres.dart';

Middleware databaseConnection() {
  final connetion = Connection.open(Database().confPosgreSQL,
          settings: ConnectionSettings(sslMode: SslMode.disable))
      .then((value) {
    print("-------------Database Connection");
    return value;
  });
  return provider<Future<Connection>>((context) => connetion);
}
