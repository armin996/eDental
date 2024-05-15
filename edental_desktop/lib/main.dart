import 'dart:convert';
import 'dart:io';

import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:dart_json_mapper_flutter/dart_json_mapper_flutter.dart';
import 'package:edental_desktop/common/models/payment.dart';
import 'package:edental_desktop/features/dentists/screen/dentist_screen.dart';
import 'package:edental_desktop/features/login/provider/authProvider.dart';
import 'package:edental_desktop/features/login/screen/authScreen.dart';
import 'package:edental_desktop/features/ratings/screens/ratingScreen.dart';
import 'package:edental_desktop/features/reports/screens/reportScreen.dart';
import 'package:edental_desktop/features/treatments/screens/treatmentScreen.dart';
import 'package:edental_desktop/features/users/screens/userScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/io_client.dart';
import 'package:signalr_core/signalr_core.dart';
import 'features/appointments/screens/appointment_screen.dart';
import 'common/sidebar/sidebar.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'features/payments/screens/paymentScreen.dart';
import 'main.mapper.g.dart';

Future<void> main() async {
  await dotenv.load();
  WidgetsFlutterBinding.ensureInitialized();
  initializeJsonMapper(adapters: [flutterAdapter]);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  final storage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void dispose() {
    // Clear all data when the app is being disposed
    storage.deleteAll();
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.detached) {
      storage.deleteAll();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        home: MyHomePage(),
      ),
    );
  }
}

final List<Widget Function()> screens = [
  () => AppointmentScreen(),
  () => DentistScreen(),
  () => TreatmentScreen(),
  () => UserScreen(),
  () => PaymentScreen(),
  () => RatingScreen(),
  () => ReportScreen()
];

class MyHomePage extends HookConsumerWidget {
  final List<String> menuItems = [
    'Appointments',
    'Dentists',
    'Treatments',
    'Users',
    'Payments',
    'Ratings',
    'Reports',
  ];
  late HubConnection connection;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var selectedIndex = ref.watch(sidebarControllerProvider);
    final localStorage = ref.watch(localStorageProvider);
    final authState = useState<String?>(null);

    Future<void> startConnection() async {
      final apiUrl = dotenv.env["API_URL"]!.replaceAll("/api", "/payments");

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
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                'Payment has been done by user ${newPayment!.client} for treatment ${newPayment.treatmentName}, amount ${newPayment.amount}')));
      });
    }

    useEffect(() {
      localStorage.read(key: "user").then((value) => authState.value = value);
      print(authState.value);
      startConnection();
      return null;
    });
    return Scaffold(
      appBar: AppBar(title: const Text('eDental Desktop')),
      body: authState.value == null
          ? AuthScreen()
          : Row(
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: MediaQuery.of(context).size.width * .2,
                  ),
                  child: Sidebar(
                    menuItems: menuItems,
                    screens: screens,
                  ),
                ),
                Expanded(
                  child: selectedIndex < screens.length
                      ? screens[selectedIndex]()
                      : Container(),
                ),
              ],
            ),
    );
  }
}
