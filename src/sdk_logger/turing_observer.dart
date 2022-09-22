import 'package:statemachine/statemachine.dart';
import 'machine_observer.dart';
import 'sdk_logger_impl.dart';

class TuringObserver extends MachineObserver {
  @override
  void onCreate(Machine<dynamic> machine) {
    super.onCreate(machine);
    SdkMachinelogger.log.i('onCreate(${machine.current})');
  }

  @override
  void onEvent(Machine machine, Transition? transition) {
    super.onEvent(machine, transition);
    SdkMachinelogger.log.i('onEvent(${machine.current}, $transition)');
  }

  @override
  void onError(Machine machine, Object error, StackTrace stackTrace) {
    super.onError(machine, error, stackTrace);
    SdkMachinelogger.log.e(machine.current, error, stackTrace);
  }
}
