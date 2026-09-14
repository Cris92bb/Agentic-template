import 'package:flutter_riverpod/flutter_riverpod.dart';

/// State for the sample action feature.
class CounterState {
  final int count;
  final DateTime lastUpdated;

  CounterState({
    this.count = 0,
    DateTime? lastUpdated,
  }) : lastUpdated = lastUpdated ?? DateTime.now();

  CounterState copyWith({
    int? count,
    DateTime? lastUpdated,
  }) {
    return CounterState(
      count: count ?? this.count,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }
}

/// StateNotifier managing sample action interactions.
class CounterController extends StateNotifier<CounterState> {
  CounterController() : super(CounterState());

  void increment() {
    state = state.copyWith(
      count: state.count + 1,
      lastUpdated: DateTime.now(),
    );
  }

  void decrement() {
    if (state.count > 0) {
      state = state.copyWith(
        count: state.count - 1,
        lastUpdated: DateTime.now(),
      );
    }
  }

  void reset() {
    state = CounterState(count: 0, lastUpdated: DateTime.now());
  }
}

/// Provider for CounterController.
final counterProvider =
    StateNotifierProvider<CounterController, CounterState>((ref) {
  return CounterController();
});
