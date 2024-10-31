import 'dart:io';

import 'package:mongo_dart/mongo_dart.dart';
import 'package:unpub/unpub.dart' as unpub;

main(List<String> args) async {
  final mongoUrl = Platform.environment['MONGO_URL']!;

  print(mongoUrl);

  final db = Db(mongoUrl);
  await db.open();

  final app = unpub.App(
    metaStore: unpub.MongoStore(db),
    packageStore: unpub.FileStore('./unpub-packages'),
  );

  final address = InternetAddress.anyIPv6;
  final server = await app.serve(
    address.address,
    int.parse(Platform.environment['PORT'] ?? '4000'),
  );
  print('Serving at http://${server.address.host}:${server.port}');
}
