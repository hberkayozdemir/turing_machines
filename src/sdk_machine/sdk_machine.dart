import 'dart:async';

import 'package:statemachine/statemachine.dart';

import '../sdk_logger/turing_observer.dart';


class _DefaultTuringObserver extends TuringObserver {}

class SdkMachine implements Machine<String> {
  
  static TuringObserver observer = _DefaultTuringObserver();
  static TransitionTransformer<dynamic> transformer = (transitions, mapper) {
    return transitions
        .map(mapper)
        .transform<dynamic>(const _FlatMapStreamTransformer<dynamic>());
  };
  @override
  State<String>? current;

  @override
  State<String> operator [](String identifier) {
    // TODO: implement []
    throw UnimplementedError();
  }

  @override
  State<String> createState(String identifier) {
    // TODO: implement createState
    throw UnimplementedError();
  }

  @override
  State<String> newStartState(String identifier) {
    // TODO: implement newStartState
    throw UnimplementedError();
  }

  @override
  State<String> newState(String identifier) {
    // TODO: implement newState
    throw UnimplementedError();
  }

  @override
  State<String> newStopState(String identifier) {
    // TODO: implement newStopState
    throw UnimplementedError();
  }

  @override
  // TODO: implement onAfterTransition
  Stream<AfterTransitionEvent<String>> get onAfterTransition =>
      throw UnimplementedError();

  @override
  // TODO: implement onBeforeTransition
  Stream<BeforeTransitionEvent<String>> get onBeforeTransition =>
      throw UnimplementedError();

  @override
  void start() {
    // TODO: implement start
  }

  @override
  // TODO: implement states
  Iterable<State<String>> get states => throw UnimplementedError();

  @override
  void stop() {
    // TODO: implement stop
  }
}


class _FlatMapStreamTransformer<T> extends StreamTransformerBase<Stream<T>, T> {
  const _FlatMapStreamTransformer();

  @override
  Stream<T> bind(Stream<Stream<T>> stream) {
    final controller = StreamController<T>.broadcast(sync: true);

    controller.onListen = () {
      final subscriptions = <StreamSubscription<dynamic>>[];

      final outerSubscription = stream.listen(
        (inner) {
          final subscription = inner.listen(
            controller.add,
            onError: controller.addError,
          );

          subscription.onDone(() {
            subscriptions.remove(subscription);
            if (subscriptions.isEmpty) controller.close();
          });

          subscriptions.add(subscription);
        },
        onError: controller.addError,
      );

      outerSubscription.onDone(() {
        subscriptions.remove(outerSubscription);
        if (subscriptions.isEmpty) controller.close();
      });

      subscriptions.add(outerSubscription);

      controller.onCancel = () {
        if (subscriptions.isEmpty) return null;
        final cancels = [for (final s in subscriptions) s.cancel()];
        return Future.wait(cancels).then((_) {});
      };
    };

    return controller.stream;
  }
}
typedef TranstionMapper<Transtion> = Stream<Transtion> Function(
    Transtion transtion);
