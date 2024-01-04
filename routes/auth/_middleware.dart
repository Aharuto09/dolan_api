import 'package:dart_frog/dart_frog.dart';
import 'package:dolan_api/provider.dart';

Handler middleware(Handler handler) {
  return handler.use(databaseConnection());
}
