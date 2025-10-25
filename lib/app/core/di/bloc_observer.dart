import 'package:flutter_bloc/flutter_bloc.dart';
import '../utils/utils_exporter.dart';

class AppBlocObserver extends BlocObserver {
  @override
  Future<void> onEvent(Bloc bloc, Object? event) async {
    super.onEvent(bloc, event);
    printI('[BlocObserver] onEvent: $event');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    printW('[BlocObserver][Transition] ${transition.event} => ${transition.nextState}');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    printE('[BlocObserver] onError: $error');
    super.onError(bloc, error, stackTrace);
  }
}
