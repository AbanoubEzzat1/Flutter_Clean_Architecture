import 'package:dio/dio.dart';
import 'package:flutter_clean_arch_revision2/app/constants.dart';
import 'package:flutter_clean_arch_revision2/data/response/response.dart';
import 'package:retrofit/http.dart';
part 'app_api.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;

  @POST("/customers/login")
  Future<AuthenticationResponse> login(
    @Field("email") String email,
    @Field("password") String password,
  );
  @POST("/customers/register")
  Future<AuthenticationResponse> register(
    @Field("user_name") String userName,
    @Field("country_mobile_code") String countryMobileCode,
    @Field("mobile_number") String mobileNumber,
    @Field("email") String email,
    @Field("password") String password,
    @Field("profile_picture") String profilePicture,
  );

  @POST("/customers/forgotPassword")
  Future<ForgetPasswordResponse> forgetPassword(
    @Field("email") String email,
  );

  @GET("/home")
  Future<HomeResponse> getHomeData();

  @GET("/storeDitals/1")
  Future<StoreDetailsResponse> getStoreDetails();
}
