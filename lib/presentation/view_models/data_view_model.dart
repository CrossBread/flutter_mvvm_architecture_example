import 'package:flutter/foundation.dart';
import 'package:flutter_mvvm_architecture_example/domain/usecases/fetch_data_usecase.dart';

/// ViewModel for the data screen, tracks loading/result/error state.
class DataViewModel extends ChangeNotifier {
  final FetchDataUseCase fetchDataUseCase;
  DataViewModel({required this.fetchDataUseCase});

  String _state = "default";
  String get state => _state;

  /// Fetches data and updates [_state] accordingly.
  Future<void> fetch() async {
    _state = "loading";
    notifyListeners();
    try {
      final result = await fetchDataUseCase();
      _state = result;
    } catch (_) {
      _state = "error";
    }
    notifyListeners();
  }
}