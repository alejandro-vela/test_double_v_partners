import 'package:flutter/material.dart';

import '../characters/charactes.dart';
import '../characters/detail_screen.dart';
import '../episodes/detail_screen.dart';
import '../locations/detail_screen.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({
    super.key,
    required this.id,
    required this.typeCard,
  });
  static const routeName = '/detail';
  final int id;
  final TypeCard typeCard;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool showMore = true;

  @override
  Widget build(BuildContext context) {
    switch (widget.typeCard) {
      case TypeCard.character:
        return DetailCharacterScreen(
          id: widget.id,
        );
      case TypeCard.location:
        return DetailLocationScreen(
          id: widget.id,
        );
      case TypeCard.episode:
        return DetailEpisodeScreen(
          id: widget.id,
        );
    }
  }
}
