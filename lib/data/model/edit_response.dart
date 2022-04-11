class EditResponse {
  String? result;

  EditResponse({this.result});

  EditResponse.fromJson(Map<String, dynamic> json) {
    result = json['result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = result;
    return data;
  }
}