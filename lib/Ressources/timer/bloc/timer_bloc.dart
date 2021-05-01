import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:mymission/Ressources/timer/tinker.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'timer_event.dart';
part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  final Ticker _ticker;
  int duration = 0;

  StreamSubscription<int> _tickerSubscription;

  TimerBloc({@required Ticker ticker, @required this.duration})
      : _ticker = ticker,
        super(TimerInitial(duration, 0));

  @override
  void onTransition(Transition<TimerEvent, TimerState> transition) {
    print("\n${transition.currentState}");
    print("duration : $duration");
    super.onTransition(transition);
  }

  @override
  Stream<TimerState> mapEventToState(
    TimerEvent event,
  ) async* {
    if (event is TimerStarted) {
      yield* _mapTimerStartedToState(event);
    } else if (event is TimerPaused) {
      yield* _mapTimerPausedToState(event);
    } else if (event is TimerResumed) {
      yield* _mapTimerResumedToState(event);
    } else if (event is TimerReset) {
      yield* _mapTimerResetToState(event);
    } else if (event is TimerTicked) {
      yield* _mapTimerTickedToState(event);
    }
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }

  Stream<TimerState> _mapTimerStartedToState(TimerStarted start) async* {
    yield TimerRunInProgress(start.duration,
        (start.duration == 1) ? chooseCapsules(this.duration) : 0);
    _tickerSubscription?.cancel();
    _tickerSubscription = _ticker
        .tick(ticks: start.duration)
        .listen((duration) => add(TimerTicked(duration: duration)));
  }

  Stream<TimerState> _mapTimerPausedToState(TimerPaused pause) async* {
    if (state is TimerRunInProgress) {
      _tickerSubscription?.pause();
      yield TimerRunPause(state.duration,
          (state.duration < 2) ? chooseCapsules(this.duration) : 0);
    }
  }

  Stream<TimerState> _mapTimerResumedToState(TimerResumed resume) async* {
    if (state is TimerRunPause) {
      _tickerSubscription?.resume();
      yield TimerRunInProgress(state.duration,
          (state.duration < 2) ? chooseCapsules(this.duration) : 0);
    }
  }

  Stream<TimerState> _mapTimerResetToState(TimerReset reset) async* {
    _tickerSubscription?.cancel();
    duration = reset.duration.inSeconds;
    print(reset.duration.inSeconds);
    yield TimerInitial(duration, 0);
  }

  Stream<TimerState> _mapTimerTickedToState(TimerTicked tick) async* {
    yield tick.duration > 0
        ? TimerRunInProgress(tick.duration,
            (tick.duration < 2) ? chooseCapsules(this.duration) : 0)
        : TimerRunComplete(chooseCapsules(tick.duration));
  }

  int chooseCapsules(int duration) {
    switch (duration) {
      case 6000:
        return 4;
        break;
      case 4500:
        return 3;
        break;
      case 3000:
        return 2;
        break;
      case 1500:
        return 1;
        break;
    }
    return 0;
  }
}
