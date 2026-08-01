import '../models/question.dart';
import '../models/practice_filter.dart';
import 'incorrect_questions_service.dart';
import 'favorite_questions_service.dart';
import 'question_filter_service.dart';
import 'question_data_service.dart';




class QuestionService {

  QuestionService({
    IncorrectQuestionsService? incorrectQuestionsService,
    FavoriteQuestionsService? favoriteQuestionsService,
    QuestionFilterService? questionFilterService,
    QuestionDataService? questionDataService,
  })  : _incorrectQuestionsService =
      incorrectQuestionsService ?? IncorrectQuestionsService(),
        _favoriteQuestionsService =
            favoriteQuestionsService ?? FavoriteQuestionsService(),
        _questionFilterService =
            questionFilterService ?? QuestionFilterService(),
        _questionDataService =
            questionDataService ?? QuestionDataService();

  final IncorrectQuestionsService _incorrectQuestionsService;
  final FavoriteQuestionsService _favoriteQuestionsService;
  final QuestionFilterService _questionFilterService;
  final QuestionDataService _questionDataService;

  Future<List<Question>> loadQuestions({
    PracticeFilter? practiceFilter,
  }) async {


    final List<dynamic> data =
    await _questionDataService.loadQuestionsForCurrentUser();

    if (practiceFilter?.mode == "Incorrect Questions") {
      return await _incorrectQuestionsService.getQuestions();
    }

    if (practiceFilter?.mode == "Favorite Questions") {
      return await _favoriteQuestionsService.getQuestions();
    }

    List<dynamic> filteredData = _questionFilterService.applyFilter(
      data,
      practiceFilter,
    );



    filteredData.shuffle();

    return filteredData
        .map((json) => Question.fromJson(json))
        .toList();


  }

}