import 'dart:io';

import 'package:dio/dio.dart';
import 'package:food_core/food_core/model/avatar_response_model.dart';
import 'package:food_core/food_core/model/category_response_model.dart';
import 'package:food_core/food_core/model/favorite_product_response_model.dart';
import 'package:food_core/food_core/model/interview_answer_response_model.dart';
import 'package:food_core/food_core/model/interview_question_response_model.dart';
import 'package:food_core/food_core/model/interview_save_answer_response_model.dart';
import 'package:food_core/food_core/model/interview_summary_response_model.dart';
import 'package:food_core/food_core/model/login_response_model.dart';
import 'package:food_core/food_core/model/product_all_response_model.dart';
import 'package:food_core/food_core/model/product_details_response_model.dart';
import 'package:food_core/food_core/model/product_list_response_model.dart';
import 'package:food_core/food_core/model/recovery_password_response_model.dart';
import 'package:food_core/food_core/model/register_response_model.dart';
import 'package:food_core/food_core/model/scan_response_model.dart';
import 'package:food_core/food_core/model/suggestion_response_model.dart';
import 'package:food_core/food_core/model/user_add_response_model.dart';
import 'package:food_core/food_core/model/user_delete_response_model.dart';
import 'package:food_core/food_core/model/user_edit_response_model.dart';
import 'package:food_core/food_core/model/user_profile_list_response_model.dart';
import 'package:food_core/food_core/model/user_response_model.dart';
import 'package:http_parser/http_parser.dart';
import 'package:retrofit/retrofit.dart';

part 'rest_client.g.dart';

//flutter pub run build_runner build --delete-conflicting-outputs

//TODO update base url
@RestApi(baseUrl: 'https://')
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @POST("/recovery_password")
  @FormUrlEncoded()
  Future<RecoveryPasswordResponseModel> recoveryPassword(
      @CancelRequest() CancelToken cancelToken, @Field() String email);

  @GET("/product_details/{id}")
  Future<ProductDetailsResponseModel> fetchProductDetails(
      @CancelRequest() CancelToken cancelToken, @Path("id") int id);

  @POST("/login")
  @FormUrlEncoded()
  Future<LoginResponseModel> login(@CancelRequest() CancelToken cancelToken,
      @Field() String email, @Field() String password);

  @GET("/me")
  @FormUrlEncoded()
  Future<UserResponseModel> me(
      @CancelRequest() CancelToken cancelToken, @Field() String token);

  @POST("/register")
  @FormUrlEncoded()
  Future<RegisterResponseModel> register(
      @CancelRequest() CancelToken cancelToken,
      @Field() String email,
      @Field() String name,
      @Field() String password);

  @GET("/products_home")
  Future<ProductListResponseModel> fetchProductHome(
      @CancelRequest() CancelToken cancelToken);

  @GET("/products/all")
  Future<ProductsAllResponseModel> fetchAllProducts(
      @CancelRequest() CancelToken cancelToken);

  @POST("/edit/{id}")
  @FormUrlEncoded()
  Future<UserEditResponseModel> edit(@CancelRequest() CancelToken cancelToken,
      @Path("id") int id, @Field() String email, @Field() String name);

  @GET("/user_delete/{id}")
  Future<UserDeleteResponseModel> deleteProfile(
      @CancelRequest() CancelToken cancelToken, @Path("id") int id);

  @GET("/favorites_products")
  Future<FavoriteProductResponseModel> fetchFavoritesProducts(
      @CancelRequest() CancelToken cancelToken,
      @Query('searchValue') String searchValue);

  @POST("/favorites_products/add")
  @FormUrlEncoded()
  Future<HttpResponse> addFavoriteProduct(
      @CancelRequest() CancelToken cancelToken,
      @Field("productId") int productId);

  @POST("/favorites_products/remove")
  @FormUrlEncoded()
  Future<HttpResponse> removeFavoriteProduct(
      @CancelRequest() CancelToken cancelToken,
      @Field("productId") int productId);

  @GET("/interview_questions")
  Future<InterviewQuestionResponseModel> fetchInterviewQuestions(
      @CancelRequest() CancelToken cancelToken);

  @GET("/interview_answers/{questionId}")
  Future<InterviewAnswerResponseModel> fetchInterviewAnswers(
      @CancelRequest() CancelToken cancelToken,
      @Path("questionId") int questionId,
      @Query('searchValue') String searchValue);

  @POST("/interview_save")
  @FormUrlEncoded()
  Future<InterviewSaveAnswerResponseModel> saveInterviewAnswer(
      @CancelRequest() CancelToken cancelToken,
      @Field("questionId") int questionId,
      @Field('answers') List<int> answers);

  @GET("/interview_summary")
  Future<InterviewSummaryResponseModel> fetchInterviewSummary(
      @CancelRequest() CancelToken cancelToken,
      @Query('questionId') int questionId);

  @GET("/user_profiles")
  Future<UserProfileListResponseModel> fetchProfiles(
      @CancelRequest() CancelToken cancelToken);

  @GET("/categories")
  Future<CategoryResponseModel> fetchCategories(
      @CancelRequest() CancelToken cancelToken);

  @GET("/suggestions/{phrase}")
  Future<SuggestionResponseModel> fetchSuggestion(
      @CancelRequest() CancelToken cancelToken, @Path("phrase") String phrase);

  @POST("/add_profile")
  @MultiPart()
  Future<UserAddResponseModel> addProfile(
      @CancelRequest()
          CancelToken cancelToken,
      @Part(name: "email")
          String email,
      @Part(name: "name")
          String name,
      {@Part(name: "avatar", contentType: 'image/jpg', fileName: 'image.jpg')
          File file});

  @GET("/scan/{code}")
  Future<ScanResponseModel> fetchScan(
      @CancelRequest() CancelToken cancelToken, @Path("code") String code);

  @POST("/avatar/{id}")
  @MultiPart()
  Future<AvatarResponseModel> updateAvatar(
      @CancelRequest() CancelToken cancelToken,
      @Path("id") int id,
      {@Part(name: "avatar", contentType: 'image/jpg', fileName: 'image.jpg') File file});
}
