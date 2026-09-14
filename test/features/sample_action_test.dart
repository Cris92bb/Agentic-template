import 'package:agentic_template/features/sample_action/sample_action.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CounterController (sample_action slice)', () {
    test('initial state is 0', () {
      final controller = CounterController();
      expect(controller.state.count, equals(0));
    });

    test('increment increases count', () {
      final controller = CounterController();
      controller.increment();
      expect(controller.state.count, equals(1));
      controller.increment();
      expect(controller.state.count, equals(2));
    });

    test('decrement decreases count but clamps at 0', () {
      final controller = CounterController();
      controller.increment();
      controller.increment();
      controller.decrement();
      expect(controller.state.count, equals(1));
      controller.decrement();
      expect(controller.state.count, equals(0));
      controller.decrement(); // should not go negative
      expect(controller.state.count, equals(0));
    });

    test('reset zeroes out count', () {
      final controller = CounterController();
      controller.increment();
      controller.increment();
      controller.reset();
      expect(controller.state.count, equals(0));
    });
  });
}
