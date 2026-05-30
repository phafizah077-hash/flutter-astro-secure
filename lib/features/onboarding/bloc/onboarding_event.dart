abstract class OnBoardingEvent {}

class PageChanged extends OnBoardingEvent {
  final int pageIndex;

  PageChanged(this.pageIndex);
}
