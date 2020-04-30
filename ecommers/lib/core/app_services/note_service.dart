import 'package:ecommers/core/models/data_models/index.dart';
import 'package:ecommers/shared/dependency_service.dart';

class NoteService {
  Future<List<Note>> fetchLatestNotes() async =>
      appService.fetchData(apiService.notes);
}
