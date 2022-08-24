// part of 'filter_bloc.dart';
part of searchbar;

@immutable
abstract class FilterState {}

class FilterInitial extends FilterState {}

class FilterApply extends FilterState {}
