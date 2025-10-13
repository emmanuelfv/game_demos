import 'dart:convert';

import 'package:stomp_dart_client/stomp_dart_client.dart';
import 'package:game_demos/config/api_config.dart';
import 'dart:math';

void onConnect(StompFrame frame) {
  stompClient.subscribe(
    destination: '/game_backend/move',
    callback: (frame) {
      if (frame.body != null) {
        Map<String, dynamic> message = json.decode(frame.body!);
        print('Received message: $message');
      }
    },
  );

  String random1 = '${Random().nextInt(100)}';
  String s = json.encode({'message': random1});
  print(s);
  stompClient.send(
    destination: '/connect4/move',
    body: s,
    headers: {},
  );
}

final stompClient = StompClient(
  config: StompConfig(
    url: 'ws://192.168.50.151:8080/ws_game',
    onConnect: onConnect,
    onWebSocketError: (dynamic error) => print(error.toString()),
  ),
);


