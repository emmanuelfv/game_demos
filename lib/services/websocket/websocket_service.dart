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
    destination: '/app/make-move',
    body: json.encode({'player': 'Player1', 'move': 'e4'}),
    headers: {},
  );
}

final stompClient = StompClient(
  config: StompConfig(
    url: '${ApiConfig.baseUrl}/${ApiConfig.websocketEndpoint}',
    onConnect: onConnect,
    onWebSocketError: (dynamic error) => print(error.toString()),
    stompConnectHeaders: {'Authorization': '${ApiConfig.token}'}, // If you have auth
    webSocketConnectHeaders: {'Authorization': '${ApiConfig.token}'}, // If you have auth
  ),
);


