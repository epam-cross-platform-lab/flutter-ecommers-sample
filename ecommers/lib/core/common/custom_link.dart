import 'dart:async';

import 'package:graphql_flutter/graphql_flutter.dart';


typedef GetHeaders = Map<String, String> Function();


class CustomAuthLink extends Link {
  CustomAuthLink({
    this.getHeaders,
  }) : super(
    request: (Operation operation, [NextLink forward]) {
      StreamController<FetchResult> controller;

      Future<void> onListen() async {
        try {
          final Map<String, String> headers =  getHeaders();

          operation.setContext(<String, Map<String, String>>{
            'headers': headers
          });
        } catch (error) {
          controller.addError(error);
        }

        await controller.addStream(forward(operation));
        await controller.close();
      }

      controller = StreamController<FetchResult>(onListen: onListen);

      return controller.stream;
    },
  );

  GetHeaders getHeaders;
}