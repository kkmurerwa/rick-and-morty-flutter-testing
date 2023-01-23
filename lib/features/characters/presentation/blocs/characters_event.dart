part of 'characters_bloc.dart';

@immutable
abstract class CharactersEvent extends Equatable {
  const CharactersEvent();
}

class GetCharactersEvent extends CharactersEvent {
  final int pageNumber;
  
  const GetCharactersEvent({required this.pageNumber});

  @override
  List<Object?> get props => [pageNumber];
}

