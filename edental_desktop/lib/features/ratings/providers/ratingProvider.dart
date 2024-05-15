import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../common/models/Rating.dart';
import '../services/RatingService.dart';

final RatingNotifierProvider =
    StateNotifierProvider<RatingNotifier, AsyncValue<dynamic>>((ref) {
  return RatingNotifier(RatingService());
});

class RatingNotifier extends StateNotifier<AsyncValue<dynamic>> {
  final RatingService _service;

  RatingNotifier(this._service) : super(AsyncValue.loading()) {
    loadRatings();
  }

  Future<void> loadRatings() async {
    try {
      final ratings = await _service.getAll();
      state = AsyncValue.data(ratings);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> fetchRatingById(int id) async {
    state = AsyncValue.loading();
    try {
      final rating = await _service.getById(id);
      state = AsyncValue.data(rating);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  // Add methods for create, update, and delete as needed
}
