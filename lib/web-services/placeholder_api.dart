import 'package:dio/dio.dart';

const _baseUrl = 'https://jsonplaceholder.typicode.com/';
const _postApi = 'posts';

Dio get _dio {
  return Dio(BaseOptions(
    connectTimeout: 5000,
    receiveTimeout: 5000,
    baseUrl: _baseUrl,
  ))
    ..interceptors.add(InterceptorsWrapper(
        onRequest: (RequestOptions requestOptions,
            RequestInterceptorHandler requestInterceptorHandler) {
          requestInterceptor(requestOptions);
          requestInterceptorHandler.next(requestOptions);
        },
        onResponse: (Response response,
                ResponseInterceptorHandler responseInterceptorHandler) {
responseInterceptorHandler.next(response);
            responseInterceptor(response);},
        onError: (DioError dioError,
                ErrorInterceptorHandler errorInterceptorHandler){
          errorInterceptorHandler.next(dioError);

          errorInterceptor(dioError);}));
}

dynamic requestInterceptor(RequestOptions options) async {

  print('requestIntercepter  ${options.uri}');
  return options;
}

dynamic responseInterceptor(Response options) async {
  // print('response intercepter ---      $options');
  // if (options.headers.value("verifyToken") != null) {
  //   //if the header is present, then compare it with the Shared Prefs key
  //   // SharedPreferences prefs = await SharedPreferences.getInstance();
  //   // var verifyToken = prefs.get("VerifyToken");
  //
  //   // if the value is the same as the header, continue with the request
  //   // if (options.headers.value("verifyToken") == verifyToken) {
  //   return options;
  //   // }
  // }

  // return DioError(requestOptions: options, error: "User is no longer active");
}

dynamic errorInterceptor(DioError dioError) {
  print('error Intercepter  ${dioError.message}');
  ///-------------all errors are detected here eg;expire token ,server error,internet connection error
  if (dioError.message.contains("Connecting timed out")) {
    // this will push a new route and remove all the routes that were present
    // navigatorKey.currentState.pushNamedAndRemoveUntil(
    //     "/login", (Route<dynamic> route) => false);
    print('No internet connection, please check your internet connection!');
  }
  return dioError;
}

Future getPost() async {
  final response = await _dio.get(_postApi);
  print('response ${response.data}');
}
