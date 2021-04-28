part of 'timer_bloc.dart';

abstract class TimerState extends Equatable {
  final int duration;
  final int capsules;
  const TimerState(this.duration, this.capsules);

  @override
  List<Object> get props => [duration];
}

class TimerInitial extends TimerState {
  const TimerInitial(int duration, int capsules) : super(duration, capsules);

  @override
  String toString() =>
      'TimerInitial { duration: $duration capsules : $capsules}';
}

class TimerRunPause extends TimerState {
  const TimerRunPause(int duration, int capsules) : super(duration, capsules);

  @override
  String toString() =>
      'TimerRunPause { duration: $duration capsules : $capsules}';
}

class TimerRunInProgress extends TimerState {
  const TimerRunInProgress(int duration, int capsules)
      : super(duration, capsules);

  @override
  String toString() =>
      'TimerRunInProgress { duration: $duration capsules : $capsules}';
}

class TimerRunComplete extends TimerState {
  const TimerRunComplete(int capsules) : super(0, capsules);
}
