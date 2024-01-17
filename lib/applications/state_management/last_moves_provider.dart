
import 'package:mafia_2/domain/data_models/last_move_model.dart';
import 'package:mafia_2/infrastructure/data/last_moves_data.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'last_moves_provider.g.dart';

@riverpod
class LastMoves extends _$LastMoves {

  @override
  List<LastMove> build() {
    List<LastMove> cards = lastMoveCards;
    cards.shuffle();
    return cards;
  }

  LastMove pickCard() {
    final LastMove card = state.last;
    state = [
      for (final c in state)
        if (c != card) card,
    ];
    return card;
  }
}
