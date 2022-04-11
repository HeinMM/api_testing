import 'package:api_testing/data/model/blog_post.dart';
import 'package:api_testing/data/model/delete_response.dart';
import 'package:api_testing/data/model/edit_response.dart';
import 'package:api_testing/data/model/post_list_model.dart';
import 'package:api_testing/data/model/upload_respose.dart';
import 'package:dio/dio.dart';

class PostApiService {
  static const baseUrl = "http://rubylearner.herokuapp.com";
  final Dio _dio = Dio();

  Future<List<PostListModel>> getAllPost() async {
    var result = await _dio.get('$baseUrl/posts');
    List postList = result.data as List;
    return postList.map((post) {
      return PostListModel.fromJson(post);
    }).toList();
  }

  Future<List<BlogPost>> getPost(int id) async {
    var result = await _dio.get("$baseUrl/post?id=$id");
    List postList = result.data as List;
    return postList.map((post) {
      return BlogPost.fromJson(post);
    }).toList();
  }

  Future<UploadResponse> uploadPost(
      {required String title,
      required String body,
      required FormData? photo,
      required Function(int, int) uploadProgress}) async {
    var result = await _dio.post("$baseUrl/post?title=$title&body=$body",
        data: photo, onSendProgress: uploadProgress);
    UploadResponse response = UploadResponse.fromJson(result.data);
    return response;
  }

  Future<EditResponse> editPost(
      {required int id, required String title, required String body}) async {
    var result = await _dio.put("$baseUrl/post?id=$id&title=$title&body=$body");
    EditResponse editResponse = EditResponse.fromJson(result.data);
    return editResponse;
  }

  Future<DeleteResponse> deletePost({required int id}) async {
    var result = await _dio.delete("$baseUrl/post?id=$id");
    DeleteResponse deleteResponse = DeleteResponse.fromJson(result.data);
    return deleteResponse;
  }
}
