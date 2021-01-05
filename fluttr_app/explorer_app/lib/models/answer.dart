
class AnswerTypes{
  static const int text = 0;
  static const int number = 1;
  static const int option = 2;
}

class Answer
{
  final int type; //which type of quest?

  //Ergebnisse
  final String note;
  final double number;
  final int option;

  Answer(this.type, {this.note = '', this.number = -1, this.option = -1});
  Answer.FromScratch(this.type, this.note , this.number , this.option);

  bool hasValue()
  {
    return note.isNotEmpty;
  }

  String toString(){
    switch(type)
    {
      case AnswerTypes.text:
        return note;
        break;
      case AnswerTypes.number:
        return number.toString();
        break;
      case AnswerTypes.option:
        return option.toString();
        break;
    }
    return '';
  }

  Map<String, Object> toJson() {
    return {
      'type': type,
      'note': note,
      'number': number,
      'option': option,
    };
  }

  static Answer fromJson(Map<String, dynamic> json) {
    return Answer.FromScratch(
        json['type'] as int,
        json['note'] as String,
        json['number'] as double,
        json['option'] as int,
    );
  }

}