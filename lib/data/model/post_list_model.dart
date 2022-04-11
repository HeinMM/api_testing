
class PostListModel {
  int? id;
  String? title;
  PostListModel({this.id, this.title});

  factory PostListModel.fromJson(Map<String, dynamic> json) {
    int? _id = json['id'];
    String? _title = json['title'];
    return PostListModel(id: _id, title: _title);
  }
}
