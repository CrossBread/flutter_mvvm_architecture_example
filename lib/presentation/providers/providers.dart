import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:flutter_mvvm_architecture_example/data/repositories/data_repository.dart';
import 'package:flutter_mvvm_architecture_example/domain/usecases/fetch_data_usecase.dart';
import 'package:flutter_mvvm_architecture_example/presentation/view_models/data_view_model.dart';

/// App-wide providers for DI.
final List<SingleChildWidget> appProviders = [
  // Data layer
  Provider<DataRepository>(
    create: (_) => DataRepository(),
  ),

  // Domain layer
  Provider<FetchDataUseCase>(
    create: (context) => FetchDataUseCase(
      repository: context.read<DataRepository>(),
    ),
  ),

  // Presentation layer
  ChangeNotifierProvider<DataViewModel>(
    create: (context) => DataViewModel(
      fetchDataUseCase: context.read<FetchDataUseCase>(),
    ),
  ),
];