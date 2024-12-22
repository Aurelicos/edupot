import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edupot/models/learning/quiz.dart';

class LearningService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addQuiz(String userId, QuizModel quizModel) async {
    try {
      final quizDoc = QuizModel.toDoc(quizModel);
      await _db
          .collection('users')
          .doc(userId)
          .collection('quizzes')
          .add(quizDoc);
    } catch (e) {
      throw Exception('Error while adding quiz: $e');
    }
  }

  Future<void> updateQuiz(
      String userId, String quizId, QuizModel quizModel) async {
    try {
      final quizDoc = QuizModel.toDoc(quizModel);
      await _db
          .collection('users')
          .doc(userId)
          .collection('quizzes')
          .doc(quizId)
          .update(quizDoc);
    } catch (e) {
      throw Exception('Error while updating quiz: $e');
    }
  }

  Future<List<QuizModel>> fetchUserQuizzes(String userId) async {
    try {
      final snapshot =
          await _db.collection('users').doc(userId).collection('quizzes').get();

      return snapshot.docs.map((doc) => QuizModel.fromDoc(doc)!).toList();
    } catch (e) {
      throw Exception('Error while fetching user quizzes: $e');
    }
  }

  Future<QuizModel?> fetchQuizById(String userId, String quizId) async {
    try {
      final doc = await _db
          .collection('users')
          .doc(userId)
          .collection('quizzes')
          .doc(quizId)
          .get();

      return doc.exists ? QuizModel.fromDoc(doc) : null;
    } catch (e) {
      throw Exception('Error while fetching quiz by ID: $e');
    }
  }

  Future<void> deleteQuiz(String userId, String quizId) async {
    try {
      await _db
          .collection('users')
          .doc(userId)
          .collection('quizzes')
          .doc(quizId)
          .delete();
    } catch (e) {
      throw Exception('Error while deleting quiz: $e');
    }
  }
}
