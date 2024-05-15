import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../common/models/appointment.dart';
import '../services/appointmentsService.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../common/models/appointment.dart';
import '../services/appointmentsService.dart';

class AppointmentState {
  final List<Appointment>? appointments;
  final Appointment? selectedAppointment;

  AppointmentState({this.appointments = const [], this.selectedAppointment});
}

final appointmentNotifierProvider =
    StateNotifierProvider<AppointmentNotifier, AsyncValue<AppointmentState>>(
        (ref) {
  return AppointmentNotifier(AppointmentService());
});

class AppointmentNotifier extends StateNotifier<AsyncValue<AppointmentState>> {
  final AppointmentService _service;

  AppointmentNotifier(this._service) : super(const AsyncValue.loading()) {
    loadAppointments();
  }

  void setAppointments(List<Appointment>? appointments) {
    try {
      state =
          AsyncValue.data(AppointmentState(appointments: appointments ?? []));
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> loadAppointments() async {
    try {
      final appointments = await _service.getAll();
      state = AsyncValue.data(AppointmentState(appointments: appointments));
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> searchAppointments(String term) async {
    try {
      final appointments = await _service.getAll(term);
      state = AsyncValue.data(AppointmentState(appointments: appointments));
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> updateAppointment(Appointment update) async {
    try {
      final result = await _service.put(update.id!, update);
      if (result != null) {
        final newList = await _service.getAll();
        state = AsyncValue.data(AppointmentState(
            selectedAppointment: result, appointments: newList));
      }
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> createAppointment(Appointment newAppointment) async {
    try {
      final result = await _service.post(newAppointment);
      if (result != null) {
        final newList = await _service.getAll();
        state = AsyncValue.data(AppointmentState(
            selectedAppointment: result, appointments: newList));
      }
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> fetchAppointmentById(int id) async {
    try {
      final appointment = await _service.getById(id);
      state = AsyncValue.data(AppointmentState(
          selectedAppointment: appointment,
          appointments: state.value!.appointments));
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}

final appointmentServiceProvider =
    Provider<AppointmentService>((ref) => AppointmentService());

class AppointmentSearchController extends StateNotifier<String> {
  final AppointmentService _service;

  AppointmentSearchController(this._service) : super('');

  void setSearchTerm(String term) {
    state = term;
  }

  Future<List<Appointment>> searchAppointments(Appointment appointment) async {
    final result =
        await _service.search(appointment, additionalPath: "/filtering");
    return result ?? [];
  }

  Future<List<Appointment>?> fetchAllAppointments() async {
    return await _service.getAll();
  }
}

final appointmentSearchControllerProvider =
    StateNotifierProvider<AppointmentSearchController, String>((ref) {
  final service = ref.watch(appointmentServiceProvider);
  return AppointmentSearchController(service);
});
