 import 'package:dio/dio.dart';
import 'package:responsive/data/respones/responses.dart';
import '../../app/constant.dart';
 import 'package:retrofit/retrofit.dart';
part 'app_api.g.dart';

@RestApi(baseUrl:Constant.baseUrl)
abstract class AppServiceClient{
factory AppServiceClient(Dio dio,{ String? baseUrl ,ParseErrorLogger? errorLogger,})= _AppServiceClient;
@POST("customer/login")
Future<AuthenticationResponse> login(
    @Field("email") String email, @Field("password") String password);

}


