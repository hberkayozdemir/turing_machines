import 'dart:async';

R runZoned<R>(R Function() body,
    {Map<Object?, Object?>? zoneValues,
    ZoneSpecification? zoneSpecification,
    @Deprecated("Use runZonedGuarded instead") Function? onError}) {
  checkNotNullable(body, "body");
  if (onError != null) {
    // TODO: Remove this when code have been migrated off using [onError].
    if (onError is! void Function(Object, StackTrace)) {
      if (onError is void Function(Object)) {
        var originalOnError = onError;
        onError = (Object error, StackTrace stack) => originalOnError(error);
      } else {
        throw ArgumentError.value(onError, "onError",
            "Must be Function(Object) or Function(Object, StackTrace)");
      }
    }
    return runZonedGuarded(body, onError,
        zoneSpecification: zoneSpecification, zoneValues: zoneValues) as R;
  }
  return _runZoned<R>(body, zoneValues, zoneSpecification);
}

T checkNotNullable<T extends Object>(T value, String name) {
  if ((value as dynamic) == null) {
    throw NotNullableError<T>(name);
  }
  return value;
}

/// A [TypeError] thrown by [checkNotNullable].
class NotNullableError<T> extends Error implements TypeError {
  final String _name;
  NotNullableError(this._name);
  @override
  String toString() => "Null is not a valid value for '$_name' of type '$T'";
}

/// Runs [body] in a new zone based on [zoneValues] and [specification].
R _runZoned<R>(R Function() body, Map<Object?, Object?>? zoneValues,
        ZoneSpecification? specification) =>
    Zone.current
        .fork(specification: specification, zoneValues: zoneValues)
        .run<R>(body);

R? runZonedGuarded<R>(
    R Function() body, void Function(Object error, StackTrace stack) onError,
    {Map<Object?, Object?>? zoneValues, ZoneSpecification? zoneSpecification}) {
  checkNotNullable(body, "body");
  checkNotNullable(onError, "onError");
  Zone parentZone = Zone.current;
  errorHandler(Zone self, ZoneDelegate parent, Zone zone, Object error,
      StackTrace stackTrace) {
    try {
      parentZone.runBinary(onError, error, stackTrace);
    } catch (e, s) {
      if (identical(e, error)) {
        parent.handleUncaughtError(zone, error, stackTrace);
      } else {
        parent.handleUncaughtError(zone, e, s);
      }
    }
  }

  if (zoneSpecification == null) {
    zoneSpecification = ZoneSpecification(handleUncaughtError: errorHandler);
  } else {
    zoneSpecification = ZoneSpecification.from(zoneSpecification,
        handleUncaughtError: errorHandler);
  }
  try {
    return _runZoned<R>(body, zoneValues, zoneSpecification);
  } catch (error, stackTrace) {
    onError(error, stackTrace);
  }
  return null;
}



class FlatMapStreamTransformer<T> extends StreamTransformerBase<Stream<T>, T> {
  const FlatMapStreamTransformer();

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
