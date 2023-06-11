part of 'prediction_bloc.dart';

@immutable
abstract class PredictionEvent {}

class FetchAge extends PredictionEvent {
  final String name;
  FetchAge(this.name);
}
