import 'package:demofirst/rest/rest_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app_interceptor.dart';
import 'logging_interceptor.dart';
export 'rest_client.dart';

final appInterceptorProvider = StateProvider<AppInterceptor>(
      (ref) => AppInterceptor(ref),
);

final restClientProvider = StateProvider(
      (ref) {
    String? baseurl = "https://demo.azinova.me/machine-test/api/";
    // String? baseurl = HiveRepo.instance.getBaseUrl();
    return RestClient(
      Dio(
        BaseOptions(
          baseUrl: baseurl.toString(),
          connectTimeout: const Duration(seconds: 120),
          receiveTimeout: const Duration(seconds: 120),
        ),
      )
        ..interceptors.add(ref.read(appInterceptorProvider))
        ..interceptors.add(const LoggingInterceptor(
          log: true,
          logResponseBody: true,
          logRequestHeader: true,
          logResponseHeader: false,
        )),
      baseUrl: baseurl.toString(),
    );
  },
);
