import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mvvm_architecture_example/main.dart';
import 'package:flutter_mvvm_architecture_example/data/repositories/data_repository.dart';
import 'package:flutter_mvvm_architecture_example/domain/usecases/fetch_data_usecase.dart';
import 'package:flutter_mvvm_architecture_example/presentation/providers/providers.dart';
import 'package:flutter_mvvm_architecture_example/presentation/view_models/data_view_model.dart';

class MockSuccessDataRepository extends DataRepository {
  @override
  Future<String> fetchData() async => "result";
}

class MockErrorDataRepository extends DataRepository {
  @override
  Future<String> fetchData() async => Future.error(Exception("error"));
}

void main() {
  testWidgets('Clicking Fetch Data button updates text from default',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MultiProvider(
            providers: appProviders,
            child: MaterialApp(home: MyApp()),
          ),
        );

        // Ensure default text is present.
        expect(find.text('default'), findsOneWidget);

        final fetchButton = find.text('Fetch Data');
        expect(fetchButton, findsOneWidget);
        await tester.tap(fetchButton);
        await tester.pumpAndSettle(Duration(milliseconds: 1000));

        // Expect the default text to be replaced.
        expect(find.text('default'), findsNothing);
      });

  testWidgets(r'Mock DataRepository success returns "result"',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MultiProvider(
            providers: [
              Provider<DataRepository>(create: (_) => MockSuccessDataRepository()),
              Provider<FetchDataUseCase>(
                create: (context) => FetchDataUseCase(
                  repository: context.read<DataRepository>(),
                ),
              ),
              ChangeNotifierProvider<DataViewModel>(
                create: (context) => DataViewModel(
                  fetchDataUseCase: context.read<FetchDataUseCase>(),
                ),
              ),
            ],
            child: MaterialApp(home: MyApp()),
          ),
        );

        final fetchButton = find.text('Fetch Data');
        await tester.tap(fetchButton);
        await tester.pumpAndSettle();

        expect(find.text('result'), findsOneWidget);
      });

  testWidgets(r'Mock DataRepository error displays "error"',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MultiProvider(
            providers: [
              Provider<DataRepository>(create: (_) => MockErrorDataRepository()),
              Provider<FetchDataUseCase>(
                create: (context) => FetchDataUseCase(
                  repository: context.read<DataRepository>(),
                ),
              ),
              ChangeNotifierProvider<DataViewModel>(
                create: (context) => DataViewModel(
                  fetchDataUseCase: context.read<FetchDataUseCase>(),
                ),
              ),
            ],
            child: MaterialApp(home: MyApp()),
          ),
        );

        final fetchButton = find.text('Fetch Data');
        await tester.tap(fetchButton);
        await tester.pumpAndSettle();

        expect(find.text('error'), findsOneWidget);
      });
}