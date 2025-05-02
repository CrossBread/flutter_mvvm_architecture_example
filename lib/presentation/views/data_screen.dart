import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mvvm_architecture_example/presentation/view_models/data_view_model.dart';

/// Simple screen showing async data state.
class DataScreen extends StatelessWidget {
  const DataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<DataViewModel>(context);
    return Scaffold(
      appBar: AppBar(title: Text('MVVM Async Demo')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(viewModel.state),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: viewModel.fetch,
              child: Text('Fetch Data'),
            ),
          ],
        ),
      ),
    );
  }
}