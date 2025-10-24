
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashCubit extends Cubit<bool> {
  SplashCubit() : super(false);

  void startSplash() async {
    await Future.delayed(const Duration(seconds: 3));
    emit(true); // finished splash
  }
}
