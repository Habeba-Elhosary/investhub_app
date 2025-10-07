class RegistrationQuestionsResponse {
  final int status;
  final String? message;
  final List<Question> data;

  const RegistrationQuestionsResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory RegistrationQuestionsResponse.fromJson(Map<String, dynamic> json) =>
      RegistrationQuestionsResponse(
        status: json["status"],
        message: json["message"],
        data: List<Question>.from(
          json["data"].map((x) => Question.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Question {
  final int id;
  final String question;
  String? answer;

  Question({required this.id, required this.question, this.answer});

  factory Question.fromJson(Map<String, dynamic> json) =>
      Question(id: json["id"], question: json["question"]);

  Map<String, dynamic> toJson() => {"question_id": id, "answer": answer};
}
