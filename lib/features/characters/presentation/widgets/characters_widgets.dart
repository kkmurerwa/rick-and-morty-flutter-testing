import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/character.dart';

class CharactersDisplay extends StatelessWidget {
  final List<Character> characters;

  const CharactersDisplay({Key? key, required this.characters}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: characters.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(characters[index].name),
          subtitle: Text(characters[index].status),
          leading: SizedBox(
            width: 50,
            height: 50,
            child: CachedNetworkImage(
              progressIndicatorBuilder: (context, url, progress) => Center(
                child: CircularProgressIndicator(
                  value: progress.progress,
                ),
              ),
              imageUrl: characters[index].image,
            ),
          ),
        );
      },
    );
  }
}
