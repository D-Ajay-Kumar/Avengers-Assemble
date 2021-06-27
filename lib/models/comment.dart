class Comment {
  String name;
  String comment;
  String date;

  Comment({this.name, this.comment, this.date});

  Comment.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    comment = json['comment'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['comment'] = this.comment;
    data['date'] = this.date;
    return data;
  }
}
