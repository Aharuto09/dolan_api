import 'package:postgres/postgres.dart';

class Database {
  Endpoint confPosgreSQL = Endpoint(
      host: 'localhost',
      database: 'dolan_database',
      username: 'postgres',
      password: 'admin001');
}
