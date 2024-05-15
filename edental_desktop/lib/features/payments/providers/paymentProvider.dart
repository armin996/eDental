import 'dart:convert';
import 'dart:io';
import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:edental_desktop/features/payments/services/paymentService.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/io_client.dart';
import 'package:signalr_core/signalr_core.dart';
import '../../../common/models/payment.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart' as dotenv;

class PaymentState {
  final Payment? payment;
  final List<Payment>? payments;
  final String apiUrl = "";
  PaymentState({this.payment, this.payments = const []});
}

final paymentsNotifierProvider =
    StateNotifierProvider<PaymentNotifier, AsyncValue<PaymentState>>(
        (ref) => PaymentNotifier(PaymentService()));

class PaymentNotifier extends StateNotifier<AsyncValue<PaymentState>> {
  final PaymentService _service;
  late HubConnection connection;
  String _searchText = "";
  PaymentNotifier(this._service) : super(const AsyncValue.loading()) {
    loadPayments();
    final apiUrl =
        dotenv.dotenv.env["API_URL"]!.replaceAll("/api", "/payments");

    if (apiUrl != null && apiUrl.isEmpty) {
      throw Exception("apiUrl is empty");
    }
    startConnection(apiUrl);
  }

  Future<void> startConnection(String apiUrl) async {
    connection = HubConnectionBuilder()
        .withUrl(
            apiUrl,
            HttpConnectionOptions(
              client: IOClient(
                  HttpClient()..badCertificateCallback = (x, y, z) => true),
              logging: (level, message) => print(message),
            ))
        .build();
    connection.start();
    connection.on('paymentNotification', (message) {
      print(message.toString());
      final jsonMessage = jsonEncode(message);
      final parsedJson = jsonDecode(jsonMessage) as List;
      final singlePaymentJson = parsedJson.first;
      final newPayment = JsonMapper.deserialize<Payment>(singlePaymentJson);
      var newPaymentList = state.value!.payments;
      newPaymentList!.add(newPayment!);
      state = AsyncValue.data(PaymentState(
          payment: state.value!.payment, payments: newPaymentList));
    });
  }

  setSearchTerm(String text) {
    _searchText = text;
  }

  Future<void> loadPayments() async {
    try {
      final payments = await _service.getAll();
      state = AsyncValue.data(PaymentState(payment: null, payments: payments));
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> fetchPaymentById(int id) async {
    state = AsyncValue.loading();
    try {
      final payment = await _service.getById(id);
      state = AsyncValue.data(PaymentState(payment: payment, payments: []));
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}
