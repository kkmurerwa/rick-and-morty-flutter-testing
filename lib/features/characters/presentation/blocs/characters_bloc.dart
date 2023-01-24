import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:ramft/features/characters/domain/usecases/get_characters_usecase.dart';

import '../../domain/entities/character.dart';

part 'characters_event.dart';
part 'characters_state.dart';

class CharactersBloc extends Bloc<CharactersEvent, CharactersState> {
  final GetCharactersUseCase charactersUseCase;

  CharactersBloc({
    required this.charactersUseCase
  }) : super(EmptyState()) {
    on<CharactersEvent> (charactersEventObserver);
  }

  FutureOr<void> charactersEventObserver(event, emit) async {
    if (event is GetCharactersEvent) {
      emit(LoadingState());

      final charactersOrFailure = await charactersUseCase.call(
        Params(page: event.pageNumber)
      );

      await charactersOrFailure.fold(
        (failure) => emit(const ErrorState(message: "")),
        (characters) => emit(SuccessState(characters: characters))
      );
    } else {
      emit(const ErrorState(message: 'An unexpected error occurred'));
    }
  }
}
