part of searchbar;

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  FilterBloc() : super(FilterInitial()) {
    on<FilterEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<FilterApplyEvent>((event, emit) {
      emit(FilterApply());
    });
  }
  applyFilter() {
    add(FilterApplyEvent());
  }
}
