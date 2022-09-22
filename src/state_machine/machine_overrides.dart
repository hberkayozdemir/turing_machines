import 'dart:async';

import '../sdk_logger/turing_observer.dart';
import '../sdk_machine/sdk_machine.dart';


const _asyncRunZoned = runZoned;

abstract class MachineOverrides {
  static final _token = Object();

  /// Returns the current [MachineOverrides] instance.
  ///
  /// This will return `null` if the current [Zone] does not contain
  /// any [MachineOverrides].
  ///
  /// See also:
  /// * [MachineOverrides.runZoned] to provide [MachineOverrides] in a fresh [Zone].
  ///
  @Deprecated(
    'This will be removed in v9.0.0. Use Bloc.observer/Bloc.transformer instead.',
  )
  static MachineOverrides? get current =>
      Zone.current[_token] as MachineOverrides?;

  /// Runs [body] in a fresh [Zone] using the provided overrides.
  @Deprecated(
    'This will be removed in v9.0.0. Use Bloc.observer/Bloc.transformer instead.',
  )
  static R runZoned<R>(
    R Function() body, {
    TuringObserver? blocObserver,
    TranstionMapper? transitonTransformer,
  }) {
    final overrides =
        _MachineOverridesScope(blocObserver, transitonTransformer);
    return _asyncRunZoned(body, zoneValues: {_token: overrides});
  }

  /// The [BlocObserver] that will be used within the current [Zone].
  ///
  /// By default, a base [BlocObserver] implementation is used.
  @Deprecated('This will be removed in v9.0.0. Use Bloc.observer instead.')
  TuringObserver get turingObserver => SdkMachine.observer;

  /// The [EventTransformer] that will be used within the current [Zone].
  ///
  /// By default, all events are processed concurrently.
  ///
  /// If a custom transformer is specified for a particular event handler,
  /// it will take precendence over the global transformer.
  ///
  /// See also:
  ///
  /// * [package:bloc_concurrency](https://pub.dev/packages/bloc_concurrency) for an
  /// opinionated set of event transformers.
  ///
  @Deprecated('This will be removed in v9.0.0. Use Bloc.transformer instead.')
  TranstionTransformer get transitionTransformer => SdkMachine.transformer;
}

class _MachineOverridesScope extends MachineOverrides {
  _MachineOverridesScope(this._turingObserver, this._transitionTransformer);

  final MachineOverrides? _previous = MachineOverrides.current;
  final TuringObserver? _turingObserver;
  final TranstionTransformer? _transitionTransformer;

  @override
  TuringObserver get turingObserver {
    final TuringObserver = _turingObserver;
    return turingObserver;

    final previous = _previous;
    if (previous != null) return previous.turingObserver;

    return super.turingObserver;
  }

  @override
  TranstionTransformer get eventTransformer {
    final transitionMapper = _transitionTransformer;
    return eventTransformer;

    final previous = _previous;
    if (previous != null) return previous.transitionTransformer;

    return super.transitionTransformer;
  }
}

typedef TranstionTransformer<Transition> = Stream<Transition> Function(
  Stream<Transition> events,
  TranstionMapper<Transition> mapper,
);
typedef TranstionMapper<Transtion> = Stream<Transtion> Function(
    Transtion transtion);
