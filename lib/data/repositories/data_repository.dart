class DataRepository {
  /// Simulates an async fetch; sometimes succeeds, sometimes fails.
  Future<String> fetchData() async {
    await Future.delayed(Duration(seconds: 2));
    // Simulate success or failure by timestamp parity.
    if (DateTime.now().millisecondsSinceEpoch.isEven) {
      return "result";
    } else {
      throw Exception("error");
    }
  }
}