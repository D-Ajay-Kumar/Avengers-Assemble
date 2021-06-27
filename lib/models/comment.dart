class Comment {
  String name;
  String comment;
  String date;
  String id;

  Comment({this.name, this.comment, this.date, this.id});

  Comment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    comment = json['comment'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['comment'] = this.comment;
    data['date'] = this.date;
    return data;
  }
}
