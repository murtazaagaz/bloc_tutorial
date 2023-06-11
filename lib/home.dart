import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_bloc/bloc/bloc/prediction_bloc.dart';

class Home extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  PredictionBloc _bloc = PredictionBloc();
  Home({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Learning Node'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(children: [
            TextField(
              decoration: const InputDecoration(hintText: 'Enter Your Name'),
              controller: _controller,
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
                onPressed: () {
                  String name = _controller.text;
                  _bloc.add(FetchAge(name));
                },
                child: const Text('Predict Age')),
            const SizedBox(
              height: 15,
            ),
            BlocConsumer<PredictionBloc, PredictionState>(
              listener: (context, state) {
                if (state is FailureState) {
                  String error = state.errorMsg;
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(error)));
                }
              },
              builder: (context, state) {
                if (state is LoadingState) {
                  return const CircularProgressIndicator();
                }
                if (state is SuccessState) {
                  return Text(
                    state.age,
                    style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  );
                }
                return Container();
              },
            )
          ]),
        ),
      ),
    );
  }
}
