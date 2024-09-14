import 'package:mood_journal/features/journal/domain/entities/diary_entry.dart';
import 'package:mood_journal/features/journal/domain/repositories/diary_repository.dart';

class SaveDiaryEntry {
  final DiaryRepository repository;

  SaveDiaryEntry(this.repository);

  Future<void> call(DiaryEntry entry) async {
    if (_validateEntry(entry)) {
      await repository.saveDiaryEntry(entry);
    } else {
      throw Exception('All fields must be filled.');
    }
  }

  bool _validateEntry(DiaryEntry entry) {
    return entry.mood.isNotEmpty &&
        entry.notes.isNotEmpty &&
        entry.stressLevel > 0 &&
        entry.selfRating > 0;
  }
}
