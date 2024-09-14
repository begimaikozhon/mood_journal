import '../entities/diary_entry.dart';

abstract class DiaryRepository {
  /// Сохраняет запись в дневнике
  Future<void> saveDiaryEntry(DiaryEntry entry);

  /// Получает список всех записей в дневнике
  Future<List<DiaryEntry>> getDiaryEntries();
}
