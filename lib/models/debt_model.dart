class DebtModel {
  String? userID;
  int? total;
  DateTime? date;
  String? title;
  String? uuid;

  DebtModel({this.userID, this.date, this.total, this.title, this.uuid});

  factory DebtModel.fromJson(Map<String, dynamic> json) {
    return DebtModel(
      uuid: json['uuid'],
      title: json['title'],
      userID: json['user_id'],
      total: json['total'],
      date: DateTime.parse(json["date"]),
    );
  }

  Map<String, dynamic> toJson() => {
        'uuid': uuid,
        'title': title,
        'user_id': userID,
        'date': date.toString(),
        'total': total,
      };
}
