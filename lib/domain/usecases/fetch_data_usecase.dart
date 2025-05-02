
import 'package:flutter_mvvm_architecture_example/data/repositories/data_repository.dart';

/// Encapsulates the business logic of fetching data.
class FetchDataUseCase {
  final DataRepository repository;
  FetchDataUseCase({required this.repository});

  Future<String> call() {
    return repository.fetchData();
  }
}