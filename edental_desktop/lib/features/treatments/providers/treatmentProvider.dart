import 'package:edental_desktop/features/treatments/service/treatmentService.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../common/models/treatment.dart';

class TreatmentState {
  final Treatment? treatment;
  final List<Treatment>? treatments;

  TreatmentState({this.treatment, this.treatments});
}

class TreatmentNotifier extends StateNotifier<AsyncValue<TreatmentState>> {
  final TreatmentService _service;

  TreatmentNotifier(this._service) : super(const AsyncValue.loading());

  Future<void> loadTreatments() async {
    try {
      final treatments = await _service.getAll();
      state = AsyncValue.data(
          TreatmentState(treatment: null, treatments: treatments));
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> createTreatment(Treatment treatment) async {
    try {
      final newTreatment = await _service.post(treatment);
      state = AsyncValue.data(TreatmentState(
          treatment: newTreatment, treatments: state.value!.treatments));
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> searchTreatments(String searchTerm) async {
    try {
      final req = Treatment.empty();
      req.name = searchTerm;
      final result = await _service.search(req, additionalPath: "/filtering");
      state = AsyncValue.data(TreatmentState(treatments: result));
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> updateTreatment(Treatment treatment) async {
    try {
      final updatedTreatment = await _service.put(treatment.id!, treatment);
      if (updateTreatment != null) {
        final newList = await _service.getAll();
        state = AsyncValue.data(TreatmentState(
            treatment: updatedTreatment,
            treatments: newList ?? state.value!.treatments));
      }
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
    state = AsyncValue.data(TreatmentState(
        treatment: treatment, treatments: state.value!.treatments ?? []));
  }

  Future<void> fetchTreatmentById(int id) async {
    try {
      final treatment = await _service.getById(id);
      state = AsyncValue.data(TreatmentState(
          treatment: treatment, treatments: state.value!.treatments));
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}

final treatmentServiceProvider = Provider<TreatmentService>((ref) {
  return TreatmentService();
});

final treatmentNotifierProvider =
    StateNotifierProvider<TreatmentNotifier, AsyncValue<TreatmentState>>((ref) {
  final service = ref.watch(treatmentServiceProvider);
  return TreatmentNotifier(service);
});
