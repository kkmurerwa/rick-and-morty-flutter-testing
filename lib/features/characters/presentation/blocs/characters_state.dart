part of 'characters_bloc.dart';

@immutable
abstract class CharactersState extends Equatable {
  const CharactersState();

  @override
  List<Object> get props => [];
}

class EmptyState extends CharactersState {}

class LoadingState extends CharactersState {}

class SuccessState extends CharactersState {
  final List<Character> characters;

  const SuccessState({required this.characters});

  @override
  List<Object> get props => [characters];
}

class ErrorState extends CharactersState {
  final String message;

  const ErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
