import 'package:flutter/material.dart';
import 'package:glint_frontend/di/injection.dart';
import 'package:glint_frontend/features/exports.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  final client = StreamChatClient(
    'b67pax5b2wdq',
    logLevel: Level.OFF,
  );

  await client.connectUser(
    User(id: 'tutorial-flutter'),
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoidHV0b3JpYWwtZmx1dHRlciJ9.S-MJpoSwDiqyXpUURgO5wVqJ4vKlIVFLSEyrFYCOE1c',
  );

  final channel = client.channel('messaging', id: 'flutterdevs');

  await channel.watch();

  runApp(
    MyGlintApp(
      client: client,
      channel: channel,
    ),
  );
}
