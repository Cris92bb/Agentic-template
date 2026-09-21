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

/// Notifier managing sample action interactions.
class CounterController extends Notifier<CounterState> {
  CounterState? _standaloneState;

  @override
  CounterState build() {
    final initial = CounterState();
    _standaloneState = initial;
    return initial;
  }

  @override
  CounterState get state {
    try {
      return super.state;
    } catch (_) {
      return _standaloneState ??= CounterState();
    }
  }

  @override
  set state(CounterState value) {
    try {
      super.state = value;
    } catch (_) {
      _standaloneState = value;
    }
  }

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
    NotifierProvider<CounterController, CounterState>(CounterController.new);
