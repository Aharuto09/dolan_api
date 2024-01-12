import 'package:postgres/postgres.dart';

class Database {
  Endpoint confPosgreSQL = Endpoint(
      host: 'roundhouse.proxy.rlwy.net',
      port: 56086,
      database: 'railway',
      username: 'postgres',
      password: '6ad5AG-DgCgGf45BEdfF--gBAfCG6BF2');
}
