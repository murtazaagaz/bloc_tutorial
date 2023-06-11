import 'dart:convert';
import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:http/http.dart' as http;
part 'prediction_event.dart';
part 'prediction_state.dart';

class PredictionBloc extends Bloc<PredictionEvent, PredictionState> {
  PredictionBloc() : super(PredictionInitial()) {
    on<PredictionEvent>((event, emit) {
    });
    on<FetchAge>(predictAge);
  }

  Future<void> predictAge(FetchAge event, Emitter emit) async {
    try {
      String name = event.name;
      String age = '';
      emit(LoadingState());
      final response =
          await http.get(Uri.parse('https://api.agify.io?name=$name'));
      final body = jsonDecode(response.body);
      if (body['age'] != null) {
        age = 'Your age is ${body['age']}';
      } else {
        age = 'We could not predict your age!';
      }

      emit(SuccessState(age));
    } catch (_) {
      emit(FailureState('Something went wrong'));
    }
  }
}
