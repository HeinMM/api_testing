
import 'package:api_testing/data/api_service/post_api_service.dart';
import 'package:api_testing/data/model/blog_post.dart';
import 'package:get/get.dart';

class BlogPostContoller extends GetxController {
  final PostApiService _apiService = Get.find();
  Rx<BlogPostState> blogpPostState = BlogPostState().obs;
  void getPost(int id) {
    blogpPostState.value = BlogPostLoading();
    _apiService.getPost(id).then((blogPost) {
      if (blogPost.isNotEmpty) {
        blogpPostState.value = BlogPostSuccess(blogPost[0]);
      }
    }).catchError((e) {
      blogpPostState.value = BlogPostError();
    });
  }
}

class BlogPostState {}

class BlogPostLoading extends BlogPostState {}

class BlogPostSuccess extends BlogPostState {
  final BlogPost blogpost;

  BlogPostSuccess(this.blogpost);
}

class BlogPostError extends BlogPostState {}
