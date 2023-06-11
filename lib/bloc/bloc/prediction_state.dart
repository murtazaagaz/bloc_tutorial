part of 'prediction_bloc.dart';

@immutable
abstract class PredictionState {}

class PredictionInitial extends PredictionState {}

class SuccessState extends PredictionState {
  final String age;
  SuccessState(this.age);
}

class FailureState extends PredictionState {
  final String errorMsg;
  FailureState(this.errorMsg);
}

class LoadingState extends PredictionState {}
