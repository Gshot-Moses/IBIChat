import 'package:chopper/chopper.dart';

part 'api_client.chopper.dart';

@ChopperApi()
abstract class APIClient extends ChopperService {
  //static const String API_URL = "http://localhost:5000/";
  static const String API_URL = "http://cf6b-129-0-76-205.ngrok.io";

  @Get(path: "users")
  Future<Response> getUsers();

  @Get(path: "get_user/{id}")
  Future<Response> getUserFromApi(@Path("id") int id);

  @Post(path: "login")
  Future<Response> login(@Body() String data);

  @Get(path: "chats/history/{id}")
  Future<Response> getHistory(@Path("id") int id);

  @Post(path: "tickets/create")
  Future<Response> createTicket(@Body() String data);

  @Get(path: "tickets/get_for_user/{user_id}")
  Future<Response> getTicketsForUser(@Path("user_id") int user_id);

  static APIClient create() {
    final client = ChopperClient(
      baseUrl: API_URL,
      interceptors: [_addHeaders, HttpLoggingInterceptor()],
      services: [_$APIClient()]
    );
    return _$APIClient(client);
  }
}

Request _addHeaders(Request req) {
  var request = applyHeader(req, "Authorization", "Token e7OFXYTXRAWoS4ZGcbpLTLMyvkYFsv327NXv4if");
  var request2 = applyHeader(request, "Content-Type", "application/json");
  //var request3 = applyHeader(request2, "Access-Control-Allow-Origin", "*");
  return request2;
}
