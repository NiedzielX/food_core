import 'dart:io';

import 'package:dio/dio.dart';
import 'package:food_core/food_core/model/avatar_response_model.dart';
import 'package:food_core/food_core/model/user_add_response_model.dart';
import 'package:food_core/food_core/model/user_delete_response_model.dart';
import 'package:food_core/food_core/model/user_edit_response_model.dart';
import 'package:food_core/food_core/model/user_profile_list_response_model.dart';
import 'package:food_core/food_core/rest/dio_provider.dart';
import 'package:food_core/food_core/rest/mock/avatar_mock_adapter.dart';
import 'package:food_core/food_core/rest/mock/user_add_mock_adapter.dart';
import 'package:food_core/food_core/rest/mock/user_delete_mock_adapter.dart';
import 'package:food_core/food_core/rest/mock/user_edit_mock_adapter.dart';
import 'package:food_core/food_core/rest/mock/user_profile_list_mock_adapter.dart';
import 'package:food_core/food_core/rest/rest_client.dart';

class UserRepository {
  final CancelToken _cancelToken = CancelToken();

  Future<UserEditResponseModel> editProfile(int id, String email, String name) async {
    Dio dio = await DioProvider.get(mockAdapter: UserEditMockAdapter());
    return RestClient(dio).edit(_cancelToken, id, email, name);
  }

  Future<UserDeleteResponseModel> deleteProfile(int id) async {
    Dio dio = await DioProvider.get(mockAdapter: UserDeleteMockAdapter());
    return RestClient(dio).deleteProfile(_cancelToken, id);
  }

  Future<UserProfileListResponseModel> fetchProfiles() async {
    Dio dio = await DioProvider.get(mockAdapter: UserProfileListMockAdapter());
    return RestClient(dio).fetchProfiles(_cancelToken);
  }

  Future<UserAddResponseModel> addProfile(String email, String name, {File avatar}) async {
    Dio dio = await DioProvider.get(mockAdapter: UserAddMockAdapter());
    return RestClient(dio).addProfile(_cancelToken, email, name, file: avatar);
  }

  Future<AvatarResponseModel> updateAvatar(int id, File avatar) async {
    Dio dio = await DioProvider.get(mockAdapter: AvatarMockAdapter());
    return RestClient(dio).updateAvatar(_cancelToken, id, file: avatar);
  }

  dispose() {
    _cancelToken.cancel();
  }
}