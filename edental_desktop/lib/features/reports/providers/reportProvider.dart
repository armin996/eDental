import 'package:edental_desktop/common/models/report.dart';
import 'package:edental_desktop/features/reports/services/reportService.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ReportState {
  Report? report;
  List<Report>? reports;
  ReportState({this.report, this.reports = const []});
}

final reportNotifierProvider =
    StateNotifierProvider<ReportProvider, AsyncValue<ReportState>>(
        (ref) => ReportProvider(ReportService()));

class ReportProvider extends StateNotifier<AsyncValue<ReportState>> {
  final ReportService _service;
  String searchText = "";
  ReportProvider(this._service) : super(const AsyncValue.loading()) {
    loadReports();
  }
  Future<void> loadReports() async {
    try {
      final reports = await _service.getAll();
      state = AsyncValue.data(ReportState(report: null, reports: reports));
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  void setSearchTerm(String text) {
    searchText = text;
  }

  void updateRepo(String value) {
    searchText = value;
  }

  Future<void> fetchReportById(int id) async {
    state = AsyncValue.loading();
    try {
      final report = await _service.getById(id);
      state = AsyncValue.data(ReportState(report: report, reports: null));
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}
