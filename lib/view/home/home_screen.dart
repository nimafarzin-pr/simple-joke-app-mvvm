import 'package:architecture_demos/data/response/status.dart';
import 'package:architecture_demos/res/constant/string_constant.dart';
import 'package:architecture_demos/view_model/joke_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final jokeViewViewModel = context.watch<JokeViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: Text(AppString.instance.textAppName),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          TextButton(
              onPressed: () {
                context.read<JokeViewModel>().fetchJoke();
              },
              child: const Text('get data')),
          Container(
            child: _ui(jokeViewViewModel),
          ),
        ],
      ),
    );
  }

  _ui(JokeViewModel jokeViewViewModel) {
    if (jokeViewViewModel.joke.status == Status.LOADING) {
      return const Text('loading');
    }
    if (jokeViewViewModel.joke.status == Status.COMPLETED) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          RichText(
            text: TextSpan(
              text: '${jokeViewViewModel.joke.data!.type} \n',
              style: const TextStyle(color: Colors.black),
              children: <TextSpan>[
                TextSpan(
                    text: '${jokeViewViewModel.joke.data!.setup} \n',
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: '${jokeViewViewModel.joke.data!.punchline} \n'),
              ],
            ),
          )
        ],
      );
    }
    if (jokeViewViewModel.joke.status == Status.ERROR) {
      return Text('${jokeViewViewModel.joke.message}');
    }
    return TextButton(
        onPressed: () {
          context.read<JokeViewModel>().fetchJoke();
        },
        child: const Text('data'));
  }
}
