import 'package:get/get.dart';

 class RestApiLanguage extends Translations{
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US':{
      'home':'Home',
      'upload':'Upload',
      'setting':'Setting',
      'edit':'Edit',
      'post':'Post',
      'delete':'Delete'
    },
    'en_KR':{
      'home':'홈',
      'upload':'업로드',
      'setting':'조절',
      'edit':'편집',
      'post':'게시물',
      'delete':'삭제'
    }
  };

}