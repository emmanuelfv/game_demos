import 'dart:convert';

import 'package:stomp_dart_client/stomp_dart_client.dart';
import 'package:game_demos/config/api_config.dart';


void onConnect(StompFrame frame) {
  stompClient.subscribe(
    destination: '/game/connect4',
    callback: (frame) {
      // Received a message from the server
      if (frame.body != null) {
        Map<String, dynamic> message = json.decode(frame.body!);
        print('Received message: $message');
        // Handle the received game status or move
      }
    },
  );

  // Send a message to the server
  // This could be a player's move, for example.
  stompClient.send(
    destination: '/app/move',
    body: json.encode({'player': 'Player1', 'move': 'e4'}),
    headers: {},
  );
}

final stompClient = StompClient(
  config: StompConfig(
    url: ApiConfig.wsUrl,
    onConnect: onConnect,
    beforeConnect: () async {
      print('waiting to connect...');
      await Future.delayed(const Duration(milliseconds: 200));
      print('connecting...');
    },
    onWebSocketError: (dynamic error) => print(error.toString()),
    stompConnectHeaders: {'Authorization': 'Bearer yourToken'},
    webSocketConnectHeaders: {'Authorization': 'Bearer your2Token'}, // If you have auth
  ),
);


