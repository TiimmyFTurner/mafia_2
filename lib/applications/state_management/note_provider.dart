// Package imports:
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'note_provider.g.dart';

@Riverpod(keepAlive: true)
class Note extends _$Note {

  @override
  String build() {
    return '';
  }

  void update(String note) {
    state = note;
  }
}
