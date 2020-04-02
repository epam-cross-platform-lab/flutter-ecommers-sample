import 'package:ecommers/core/models/data_models/index.dart';
import 'package:ecommers/core/services/dependency_service.dart';

class NoteService {
  Future<List<Note>> fetchLatestNotes() async {
    final response = await apiService.notes();

    if (!response.isSuccessful) return null;

    return response.body;
  }
}