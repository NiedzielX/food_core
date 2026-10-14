import 'package:food_core/food_core/model/interview_answer_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'interview_question_model.g.dart';

enum InterviewAnswerType {
  @JsonValue("single_answer")
  SINGLE_ANSWER,
  @JsonValue("search_answer")
  SEARCH_ANSWER,
  @JsonValue("multi_answer")
  MULTI_ANSWER,
}

@JsonSerializable()
class InterviewQuestionModel {
  int id;
  InterviewAnswerType interviewAnswerType;
  String question;
  @JsonKey(name: "answers", defaultValue: [])
  List<InterviewAnswerModel> answerList;
  @JsonKey(defaultValue: "")
  String description;

  InterviewQuestionModel(
      {this.id,
      this.interviewAnswerType,
      this.question,
      this.answerList,
      this.description});

  factory InterviewQuestionModel.fromJson(Map<String, dynamic> json) =>
      _$InterviewQuestionModelFromJson(json);

  Map<String, dynamic> toJson() => _$InterviewQuestionModelToJson(this);
}
