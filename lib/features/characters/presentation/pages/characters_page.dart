import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ramft/features/characters/presentation/blocs/characters_bloc.dart';
import 'package:ramft/features/characters/presentation/widgets/loading_widget.dart';

import '../../../../injection_container.dart';
import '../widgets/characters_widgets.dart';
import '../widgets/message_display_widget.dart';

class CharactersPage extends StatelessWidget {
  const CharactersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Characters"),
      ),
      body: SingleChildScrollView(
        child: buildBody(context)
      ),
    );
  }

  void dispatchEvent(BuildContext context) {
    BlocProvider.of<CharactersBloc>(context).add(
        const GetCharactersEvent(pageNumber: 1)
    );
  }

  BlocProvider<CharactersBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<CharactersBloc>(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(children: [
            const SizedBox(height: 10),
            BlocBuilder<CharactersBloc, CharactersState>(
              builder: (context, state) {
                if (state is EmptyState) {
                  dispatchEvent(context);
                }

                if (state is LoadingState) {
                  return const LoadingWidget();
                } else if (state is SuccessState) {
                  return CharactersDisplay(
                    characters: state.characters
                  );
                } else if (state is ErrorState) {
                  return MessageDisplay(
                    message: state.message
                  );
                } else {
                  return const MessageDisplay(
                    message: "Unexpected error encountered"
                  );
                }
              },
            ),
          ]),
        ),
      ),
    );
  }
}
