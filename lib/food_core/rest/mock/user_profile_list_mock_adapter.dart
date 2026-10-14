import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:food_core/food_core/model/user.dart';
import 'package:food_core/food_core/model/user_profile_list_response_model.dart';
import 'package:food_core/food_core/rest/mock/mock_adapter.dart';

class UserProfileListMockAdapter extends MockAdapter {
  @override
  Future<ResponseBody> fetch(RequestOptions options,
      Stream<List<int>> requestStream, Future cancelFuture) async {
    await Future.delayed(Duration(milliseconds: 400));
    var responseModel = UserProfileListResponseModel();
    var user = User();
    user.id = 99;
    user.email = "test@test.pl";
    user.name = "Jan Kowalski";
    user.avatar = "https://i.kinja-img.com/gawker-media/image/upload/t_original/ijsi5fzb1nbkbhxa2gc1.png";

    var user1 = User();
    user1.id = 98;
    user1.email = "test4@test.pl";
    user1.name = "Mariusz Nowy";
    user1.avatar = "https://i.kinja-img.com/gawker-media/image/upload/t_original/ijsi5fzb1nbkbhxa2gc1.png";

    var user2 = User();
    user2.id = 97;
    user2.email = "test3@test.pl";
    user2.name = "Bartek Olech";
    user2.avatar = "https://i.kinja-img.com/gawker-media/image/upload/t_original/ijsi5fzb1nbkbhxa2gc1.png";

    var user3 = User();
    user3.id = 96;
    user3.email = "test2@test.pl";
    user3.name = "Jan Nowak";
    user3.avatar = "https://i.kinja-img.com/gawker-media/image/upload/t_original/ijsi5fzb1nbkbhxa2gc1.png";


    responseModel.profiles = [user, user1, user2, user3];
  print(responseModel.profiles);
    String response = jsonEncode(responseModel);
    return ResponseBody.fromString(response, 200, headers: responseHeaders);
  }
}