import 'dart:convert';

import 'package:dolan_api/database.dart';
import 'package:postgres/postgres.dart';

class MessageService {
  Future<void> send(String message) async {
    final item = json.decode(message.toString());

    await Connection.open(Database().confPosgreSQL,
            settings: const ConnectionSettings(sslMode: SslMode.disable))
        .then((connection) {
      connection
          .execute(
              "INSERT INTO messages (id_sender, id_schedule, content, create_date, create_time) VALUES (${item["id_sender"]}, ${item["id_schedule"]}, '${item["content"]}', '${item["create_date"]}', '${item["create_time"]}')")
          .whenComplete(() {
        print('Disconnect Message');
        connection.close();
      });
    });
  }
}
