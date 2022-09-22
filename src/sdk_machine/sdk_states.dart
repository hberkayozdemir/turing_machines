
//  late State isNotConnected, isConnected, hasSentAuth, hasUser, hasError;


import 'package:statemachine/statemachine.dart';

class IsNotConnected extends State {
  IsNotConnected(Machine machine, identifier) : super(machine, identifier);
}

class IsConnected extends State {
  IsConnected(Machine machine, identifier) : super(machine, identifier);
}

class HasSession extends State {
  HasSession(Machine machine, identifier) : super(machine, identifier);
}

class HasError extends State {
  HasError(Machine machine, identifier) : super(machine, identifier);
}
