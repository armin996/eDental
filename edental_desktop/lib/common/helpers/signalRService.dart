// import 'package:dart_json_mapper/dart_json_mapper.dart';
// import 'package:flutter/material.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:json_annotation/json_annotation.dart';
// import 'package:signalr_flutter/signalr_api.dart';
// import 'package:signalr_flutter/signalr_flutter.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart' as dotenv;

// import '../models/payment.dart';

// final signalRServiceProvider =
//     Provider<SignalRService>((ref) => SignalRService());

// class SignalRService {
//   late SignalR signalR;

//   SignalRService() {
//     final apiUrl = dotenv.dotenv.env[""];
//     if (apiUrl != null && apiUrl.isNotEmpty) {
//       throw Exception("apiUrl is empty");
//     }
//     signalR = SignalR(
//       apiUrl ?? "",
//       "PaymentHub",
//       hubMethods: ["SendPaymentInfo"],
//       statusChangeCallback: _onStatusChange,
//       hubCallback: _onNewMessage,
//     );
//   }

//   void _onStatusChange(ConnectionStatus? status) {
//     // Handle status changes
//   }

//   void _onNewMessage(String methodName, dynamic message) {
//     if (methodName == "paymentsNotification") {
//       final newPayment = JsonMapper.deserialize<Payment>(
//           message); // Convert the message to your Payment model
//     }
//   }

//   Future<void> connect() async {
//     await signalR.connect();
//   }

//   Future<void> disconnect() async {
//     await signalR.stop();
//   }
// }
