import 'package:flutter_bloc/flutter_bloc.dart';
import 'onboarding_event.dart';
import 'onboarding_state.dart';

class OnBoardingBloc extends Bloc<OnBoardingEvent, OnBoardingState> {
  OnBoardingBloc() : super(OnBoardingState(currentPage: 0)) {
    on<PageChanged>((event, emit) {
      emit(OnBoardingState(currentPage: event.pageIndex));
    });
  }
}
