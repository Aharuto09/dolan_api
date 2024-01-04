import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_web_socket/dart_frog_web_socket.dart';
import 'package:dolan_api/message_service.dart';

Handler get onRequest {
  return webSocketHandler((channel, protocol) async {
    print('Someone Connected');
    print(channel.stream.isBroadcast);
    // channel.stream
    channel.stream.listen(
      (message) async {
        await MessageService().send(message as String).whenComplete(() {
          channel.sink.add(message);
        });
        // print(result);
      },
      onDone: () => print('Disconnect'),
      onError: print,
    );
  });
}
