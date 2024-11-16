
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:taskmanager/Style/Style.dart';
import 'package:taskmanager/utility/utility.dart';

// Base URL for the API
const String BaseURL = "http://35.73.30.144:2005/api/v1";
var RequestHeader={"Content-Type":"application/json"};

// Helper function to construct headers
Future<Map<String, String>> getHeaders({bool requiresAuth = false}) async {
  Map<String, String> headers = {"Content-Type": "application/json"};
  if (requiresAuth) {
    String? token = await ReadUserData("token"); // Fetch token after login
    if (token != null) {
      headers["token"] = token;
    }
  }
  return headers;
}

// API to handle Login
Future<bool> LoginRequest(Map<String, String> formValues) async {
  final url = Uri.parse("$BaseURL/Login");
  final headers = await getHeaders();
  final response = await http.post(url, headers: headers, body: json.encode(formValues));
  final responseBody = json.decode(response.body);

  if (response.statusCode == 200 && responseBody['status'] == "success") {
    SuccessToast("Login Successful");
    await WriteUserData(responseBody); // Save token and user data
    return true;
  } else {
    ErrorToast(responseBody['data'] ?? "Login failed! Please try again.");
    return false;
  }
}

// API to handle Registration
Future<bool> RegistrationRequest(Map<String, String> formValues) async {
  final url = Uri.parse("$BaseURL/Registration");
  final headers = await getHeaders();
  final response = await http.post(url, headers: headers, body: json.encode(formValues));
  final responseBody = json.decode(response.body);

  if (response.statusCode == 200 && responseBody['status'] == "success") {
    SuccessToast("Registration Successful");
    return true;
  } else {
    ErrorToast(responseBody['data'] ?? "Registration failed! Please try again.");
    return false;
  }
}

Future<bool> VerifyEmailRequest(Email) async{
  var URL=Uri.parse("${BaseURL}/RecoverVerifyEmail/${Email}");
  var response= await http.get(URL,headers:RequestHeader);
  var ResultCode=response.statusCode;
  var ResultBody=json.decode(response.body);
  if(ResultCode==200 && ResultBody['status']=="success"){
    await WriteEmailVerification(Email);
    SuccessToast("Request Success");
    return true;
  }
  else{
    ErrorToast("Request fail ! try again");
    return false;
  }
}

Future<bool> VerifyOTPRequest(Email,OTP) async{
  var URL=Uri.parse("${BaseURL}/RecoverVerifyOTP/${Email}/${OTP}");
  var response= await  http.get(URL,headers:RequestHeader);
  var ResultCode=response.statusCode;
  var ResultBody=json.decode(response.body);
  if(ResultCode==200 && ResultBody['status']=="success"){
    await WriteOTPVerification(OTP);
    SuccessToast("Request Success");
    return true;
  }
  else{
    ErrorToast("Request fail ! try again");
    return false;
  }
}

Future<bool> SetPasswordRequest(FormValues) async{

  var URL=Uri.parse("${BaseURL}/RecoverResetPass");
  var PostBody=json.encode(FormValues);

  var response= await  http.post(URL,headers:RequestHeader,body: PostBody);

  var ResultCode=response.statusCode;
  var ResultBody=json.decode(response.body);


  if(ResultCode==200 && ResultBody['status']=="success"){
    SuccessToast("Request Success");
    return true;
  }
  else{
    ErrorToast("Request fail ! try again");
    return false;
  }
}

Future<List> TaskListRequest(Status) async {
  var URL=Uri.parse("${BaseURL}/listTaskByStatus/${Status}");
  String? token= await ReadUserData("token");
  var RequestHeaderWithToken={"Content-Type":"application/json","token":'$token'};
  var response= await http.get(URL,headers:RequestHeaderWithToken);
  var ResultCode=response.statusCode;
  var ResultBody=json.decode(response.body);
  if(ResultCode==200 && ResultBody['status']=="success"){
    SuccessToast("Request Success");
    return ResultBody['data'];
  }
  else{
    ErrorToast("Request fail ! try again");
    return [];
  }
}


// API to create a new task
Future<bool> TaskCreateRequest(FormValues) async {

  var URL=Uri.parse("${BaseURL}/createTask");
  String? token= await ReadUserData("token");
  var RequestHeaderWithToken={"Content-Type":"application/json","token":'$token'};

  var PostBody=json.encode(FormValues);

  var response= await http.post(URL,headers:RequestHeaderWithToken,body: PostBody);
  var ResultCode=response.statusCode;
  var ResultBody=json.decode(response.body);
  if(ResultCode==200 && ResultBody['status']=="success"){
    SuccessToast("Request Success");
    return true;
  }
  else{
    ErrorToast("Request fail ! try again");
    return false;
  }
}

// API to delete a task by ID
Future<bool> TaskDeleteRequest(String id) async {
  final url = Uri.parse("$BaseURL/deleteTask/$id");
  final headers = await getHeaders(requiresAuth: true);
  final response = await http.delete(url, headers: headers);
  final responseBody = json.decode(response.body);

  if (response.statusCode == 200 && responseBody['status'] == "success") {
    SuccessToast("Task Deleted Successfully.");
    return true;
  } else {
    ErrorToast(responseBody['data'] ?? "Task deletion failed!");
    return false;
  }
}

// API to update the status of a task
Future<bool> TaskUpdateRequest(id,status) async {
  var URL=Uri.parse("${BaseURL}/updateTaskStatus/${id}/${status}");
  String? token= await ReadUserData("token");
  var RequestHeaderWithToken={"Content-Type":"application/json","token":'$token'};
  var response= await http.get(URL,headers:RequestHeaderWithToken);
  var ResultCode=response.statusCode;
  var ResultBody=json.decode(response.body);
  if(ResultCode==200 && ResultBody['status']=="success"){
    SuccessToast("Request Success");
    return true;
  }
  else{
    ErrorToast("Request fail ! try again");
    return false;
  }

}
