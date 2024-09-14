import 'package:mood_journal/features/journal/domain/entities/diary_entry.dart';
import 'package:mood_journal/features/journal/domain/repositories/diary_repository.dart';

class DiaryRepositoryImpl implements DiaryRepository {
  // Временно храним данные в памяти
  final List<DiaryEntry> _diaryEntries = [];

  @override
  Future<void> saveDiaryEntry(DiaryEntry entry) async {
    _diaryEntries.add(entry);
    // Здесь можно добавить сохранение в базу данных или локальное хранилище
  }

  @override
  Future<List<DiaryEntry>> getDiaryEntries() async {
    return _diaryEntries;
  }
}
