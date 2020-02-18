class Input {
  bool isAnswer;
  String text;
  List<dynamic> suggestions;
  Input({
    this.isAnswer = false,
    this.text,
    this.suggestions,
  });

  bool get hasSuggestions => suggestions != null || suggestions.isEmpty;

  factory Input.answer({String text, List<dynamic> suggestions}) {
    return Input(text: text, suggestions: suggestions, isAnswer: true);
  }

  factory Input.fromJson(Map<String, dynamic> map) {
    return Input.answer(text: map["reply"], suggestions: map["suggestions"]);
  }
}
