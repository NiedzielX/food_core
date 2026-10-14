// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rest_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _RestClient implements RestClient {
  _RestClient(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'https://';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<RecoveryPasswordResponseModel> recoveryPassword(
      cancelToken, email) async {
    ArgumentError.checkNotNull(cancelToken, 'cancelToken');
    ArgumentError.checkNotNull(email, 'email');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = {'email': email};
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>(
        '/recovery_password',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            contentType: 'application/x-www-form-urlencoded',
            baseUrl: baseUrl),
        data: _data,
        cancelToken: cancelToken);
    final value = RecoveryPasswordResponseModel.fromJson(_result.data);
    return value;
  }

  @override
  Future<ProductDetailsResponseModel> fetchProductDetails(
      cancelToken, id) async {
    ArgumentError.checkNotNull(cancelToken, 'cancelToken');
    ArgumentError.checkNotNull(id, 'id');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/product_details/$id',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data,
        cancelToken: cancelToken);
    final value = ProductDetailsResponseModel.fromJson(_result.data);
    return value;
  }

  @override
  Future<LoginResponseModel> login(cancelToken, email, password) async {
    ArgumentError.checkNotNull(cancelToken, 'cancelToken');
    ArgumentError.checkNotNull(email, 'email');
    ArgumentError.checkNotNull(password, 'password');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = {'email': email, 'password': password};
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>('/login',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            contentType: 'application/x-www-form-urlencoded',
            baseUrl: baseUrl),
        data: _data,
        cancelToken: cancelToken);
    final value = LoginResponseModel.fromJson(_result.data);
    return value;
  }

  @override
  Future<UserResponseModel> me(cancelToken, token) async {
    ArgumentError.checkNotNull(cancelToken, 'cancelToken');
    ArgumentError.checkNotNull(token, 'token');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = {'token': token};
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>('/me',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            contentType: 'application/x-www-form-urlencoded',
            baseUrl: baseUrl),
        data: _data,
        cancelToken: cancelToken);
    final value = UserResponseModel.fromJson(_result.data);
    return value;
  }

  @override
  Future<RegisterResponseModel> register(
      cancelToken, email, name, password) async {
    ArgumentError.checkNotNull(cancelToken, 'cancelToken');
    ArgumentError.checkNotNull(email, 'email');
    ArgumentError.checkNotNull(name, 'name');
    ArgumentError.checkNotNull(password, 'password');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = {'email': email, 'name': name, 'password': password};
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>('/register',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            contentType: 'application/x-www-form-urlencoded',
            baseUrl: baseUrl),
        data: _data,
        cancelToken: cancelToken);
    final value = RegisterResponseModel.fromJson(_result.data);
    return value;
  }

  @override
  Future<ProductListResponseModel> fetchProductHome(cancelToken) async {
    ArgumentError.checkNotNull(cancelToken, 'cancelToken');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('/products_home',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data,
        cancelToken: cancelToken);
    final value = ProductListResponseModel.fromJson(_result.data);
    return value;
  }

  @override
  Future<ProductsAllResponseModel> fetchAllProducts(cancelToken) async {
    ArgumentError.checkNotNull(cancelToken, 'cancelToken');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('/products/all',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data,
        cancelToken: cancelToken);
    final value = ProductsAllResponseModel.fromJson(_result.data);
    return value;
  }

  @override
  Future<UserEditResponseModel> edit(cancelToken, id, email, name) async {
    ArgumentError.checkNotNull(cancelToken, 'cancelToken');
    ArgumentError.checkNotNull(id, 'id');
    ArgumentError.checkNotNull(email, 'email');
    ArgumentError.checkNotNull(name, 'name');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = {'email': email, 'name': name};
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>('/edit/$id',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            contentType: 'application/x-www-form-urlencoded',
            baseUrl: baseUrl),
        data: _data,
        cancelToken: cancelToken);
    final value = UserEditResponseModel.fromJson(_result.data);
    return value;
  }

  @override
  Future<UserDeleteResponseModel> deleteProfile(cancelToken, id) async {
    ArgumentError.checkNotNull(cancelToken, 'cancelToken');
    ArgumentError.checkNotNull(id, 'id');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('/user_delete/$id',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data,
        cancelToken: cancelToken);
    final value = UserDeleteResponseModel.fromJson(_result.data);
    return value;
  }

  @override
  Future<FavoriteProductResponseModel> fetchFavoritesProducts(
      cancelToken, searchValue) async {
    ArgumentError.checkNotNull(cancelToken, 'cancelToken');
    ArgumentError.checkNotNull(searchValue, 'searchValue');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'searchValue': searchValue};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/favorites_products',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data,
        cancelToken: cancelToken);
    final value = FavoriteProductResponseModel.fromJson(_result.data);
    return value;
  }

  @override
  Future<HttpResponse<dynamic>> addFavoriteProduct(
      cancelToken, productId) async {
    ArgumentError.checkNotNull(cancelToken, 'cancelToken');
    ArgumentError.checkNotNull(productId, 'productId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = {'productId': productId};
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request('/favorites_products/add',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            contentType: 'application/x-www-form-urlencoded',
            baseUrl: baseUrl),
        data: _data,
        cancelToken: cancelToken);
    final value = _result.data;
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<dynamic>> removeFavoriteProduct(
      cancelToken, productId) async {
    ArgumentError.checkNotNull(cancelToken, 'cancelToken');
    ArgumentError.checkNotNull(productId, 'productId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = {'productId': productId};
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request('/favorites_products/remove',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            contentType: 'application/x-www-form-urlencoded',
            baseUrl: baseUrl),
        data: _data,
        cancelToken: cancelToken);
    final value = _result.data;
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  @override
  Future<InterviewQuestionResponseModel> fetchInterviewQuestions(
      cancelToken) async {
    ArgumentError.checkNotNull(cancelToken, 'cancelToken');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/interview_questions',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data,
        cancelToken: cancelToken);
    final value = InterviewQuestionResponseModel.fromJson(_result.data);
    return value;
  }

  @override
  Future<InterviewAnswerResponseModel> fetchInterviewAnswers(
      cancelToken, questionId, searchValue) async {
    ArgumentError.checkNotNull(cancelToken, 'cancelToken');
    ArgumentError.checkNotNull(questionId, 'questionId');
    ArgumentError.checkNotNull(searchValue, 'searchValue');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'searchValue': searchValue};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/interview_answers/$questionId',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data,
        cancelToken: cancelToken);
    final value = InterviewAnswerResponseModel.fromJson(_result.data);
    return value;
  }

  @override
  Future<InterviewSaveAnswerResponseModel> saveInterviewAnswer(
      cancelToken, questionId, answers) async {
    ArgumentError.checkNotNull(cancelToken, 'cancelToken');
    ArgumentError.checkNotNull(questionId, 'questionId');
    ArgumentError.checkNotNull(answers, 'answers');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = {'questionId': questionId, 'answers': answers};
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>('/interview_save',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            contentType: 'application/x-www-form-urlencoded',
            baseUrl: baseUrl),
        data: _data,
        cancelToken: cancelToken);
    final value = InterviewSaveAnswerResponseModel.fromJson(_result.data);
    return value;
  }

  @override
  Future<InterviewSummaryResponseModel> fetchInterviewSummary(
      cancelToken, questionId) async {
    ArgumentError.checkNotNull(cancelToken, 'cancelToken');
    ArgumentError.checkNotNull(questionId, 'questionId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'questionId': questionId};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/interview_summary',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data,
        cancelToken: cancelToken);
    final value = InterviewSummaryResponseModel.fromJson(_result.data);
    return value;
  }

  @override
  Future<UserProfileListResponseModel> fetchProfiles(cancelToken) async {
    ArgumentError.checkNotNull(cancelToken, 'cancelToken');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('/user_profiles',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data,
        cancelToken: cancelToken);
    final value = UserProfileListResponseModel.fromJson(_result.data);
    return value;
  }

  @override
  Future<CategoryResponseModel> fetchCategories(cancelToken) async {
    ArgumentError.checkNotNull(cancelToken, 'cancelToken');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('/categories',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data,
        cancelToken: cancelToken);
    final value = CategoryResponseModel.fromJson(_result.data);
    return value;
  }

  @override
  Future<SuggestionResponseModel> fetchSuggestion(cancelToken, phrase) async {
    ArgumentError.checkNotNull(cancelToken, 'cancelToken');
    ArgumentError.checkNotNull(phrase, 'phrase');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/suggestions/$phrase',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data,
        cancelToken: cancelToken);
    final value = SuggestionResponseModel.fromJson(_result.data);
    return value;
  }

  @override
  Future<UserAddResponseModel> addProfile(cancelToken, email, name,
      {file}) async {
    ArgumentError.checkNotNull(cancelToken, 'cancelToken');
    ArgumentError.checkNotNull(email, 'email');
    ArgumentError.checkNotNull(name, 'name');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _data = FormData();
    if (email != null) {
      _data.fields.add(MapEntry('email', email));
    }
    if (name != null) {
      _data.fields.add(MapEntry('name', name));
    }
    if (file != null) {
      _data.files.add(MapEntry(
          'avatar',
          MultipartFile.fromFileSync(file.path,
              filename: 'image.jpg',
              contentType: MediaType.parse('image/jpg'))));
    }
    final _result = await _dio.request<Map<String, dynamic>>('/add_profile',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data,
        cancelToken: cancelToken);
    final value = UserAddResponseModel.fromJson(_result.data);
    return value;
  }

  @override
  Future<ScanResponseModel> fetchScan(cancelToken, code) async {
    ArgumentError.checkNotNull(cancelToken, 'cancelToken');
    ArgumentError.checkNotNull(code, 'code');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('/scan/$code',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data,
        cancelToken: cancelToken);
    final value = ScanResponseModel.fromJson(_result.data);
    return value;
  }

  @override
  Future<AvatarResponseModel> updateAvatar(cancelToken, id, {file}) async {
    ArgumentError.checkNotNull(cancelToken, 'cancelToken');
    ArgumentError.checkNotNull(id, 'id');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _data = FormData();
    if (file != null) {
      _data.files.add(MapEntry(
          'avatar',
          MultipartFile.fromFileSync(file.path,
              filename: 'image.jpg',
              contentType: MediaType.parse('image/jpg'))));
    }
    final _result = await _dio.request<Map<String, dynamic>>('/avatar/$id',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data,
        cancelToken: cancelToken);
    final value = AvatarResponseModel.fromJson(_result.data);
    return value;
  }
}
