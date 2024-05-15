import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../common/models/dentist.dart';
import '../service/dentistService.dart';

class DentistState {
  late List<Dentist>? dentists;
  late Dentist? selectedDentist;
  DentistState({this.dentists = const [], this.selectedDentist});
}

final dentistNotifierProvider =
    StateNotifierProvider<DentistNotifier, AsyncValue<DentistState>>((ref) {
  return DentistNotifier(DentistService());
});

class DentistNotifier extends StateNotifier<AsyncValue<DentistState>> {
  final DentistService _service;

  DentistNotifier(this._service) : super(AsyncValue.loading()) {
    loadDentists();
  }

  Future<void> loadDentists() async {
    try {
      final dentists = await _service.getAll();
      state = AsyncValue.data(DentistState(dentists: dentists));
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> searchDentists(String term) async {
    try {
      final req = Dentist.empty();
      req.searchTerm = term;
      final dentists = await _service.search(req, additionalPath: "/filtering");
      state = AsyncValue.data(DentistState(dentists: dentists));
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> createDentist(Dentist dentist) async {
    try {
      final result = await _service.post(dentist);
      state = AsyncValue.data(DentistState(
          selectedDentist: result, dentists: state.value!.dentists));
    } catch (e, stackTrace) {
      print(e);
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> updateDentist(Dentist dentist) async {
    try {
      final result = await _service.put(dentist.id!, dentist);
      if (result != null) {
        final dentistList = await _service.getAll();
        state = AsyncValue.data(DentistState(
            selectedDentist: result,
            dentists: dentistList ?? state.value!.dentists));
      }
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> fetchDentistById(int id) async {
    try {
      final dentist = await _service.getById(id);
      state = AsyncValue.data(DentistState(
          selectedDentist: dentist, dentists: state.value!.dentists));
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}
