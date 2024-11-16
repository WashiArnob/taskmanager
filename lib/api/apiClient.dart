// import 'dart:convert';
// import 'package:taskmanager/Style/Style.dart';
// import 'package:http/http.dart' as http;
// import 'package:taskmanager/utility/utility.dart';
//
// var BaseURL="http://35.73.30.144:2005/api/v1";
// var RequestHeader={"Content-Type":"application/json"};
//
// Future<bool> LoginRequest(FormValues) async{
//   var URL=Uri.parse("${BaseURL}/login");
//   var PostBody=json.encode(FormValues);
//   var response= await http.post(URL,headers:RequestHeader,body: PostBody);
//   var ResultCode=response.statusCode;
//   var ResultBody=json.decode(response.body);
//   if(ResultCode==200 && ResultBody['status']=="success"){
//     SuccessToast("Request Success");
//     await WriteUserData(ResultBody);
//     return true;
//   }
//   else{
//     ErrorToast("Request fail ! try again");
//     return false;
//   }
// }
//
// Future<bool> RegistrationRequest(FormValues) async{
//   var URL=Uri.parse("${BaseURL}/registration");
//   var PostBody=json.encode(FormValues);
//   var response= await  http.post(URL,headers:RequestHeader,body: PostBody);
//   var ResultCode=response.statusCode;
//   var ResultBody=json.decode(response.body);
//   if(ResultCode==200 && ResultBody['status']=="success"){
//     SuccessToast("Request Success");
//     return true;
//   }
//   else{
//     ErrorToast("Request fail ! try again");
//     return false;
//   }
// }
//
// Future<bool> VerifyEmailRequest(Email) async{
//   var URL=Uri.parse("${BaseURL}/RecoverVerifyEmail/${Email}");
//   var response= await http.get(URL,headers:RequestHeader);
//   var ResultCode=response.statusCode;
//   var ResultBody=json.decode(response.body);
//   if(ResultCode==200 && ResultBody['status']=="success"){
//     await WriteEmailVerification(Email);
//     SuccessToast("Request Success");
//     return true;
//   }
//   else{
//     ErrorToast("Request fail ! try again");
//     return false;
//   }
// }
//
// Future<bool> VerifyOTPRequest(Email,OTP) async{
//   var URL=Uri.parse("${BaseURL}/RecoverVerifyOtp/${Email}/${OTP}");
//   var response= await  http.get(URL,headers:RequestHeader);
//   var ResultCode=response.statusCode;
//   var ResultBody=json.decode(response.body);
//   if(ResultCode==200 && ResultBody['status']=="success"){
//     await WriteOTPVerification(OTP);
//     SuccessToast("Request Success");
//     return true;
//   }
//   else{
//     ErrorToast("Request fail ! try again");
//     return false;
//   }
// }
//
// Future<bool> SetPasswordRequest(FormValues) async{
//
//   var URL=Uri.parse("${BaseURL}/RecoverResetPassword");
//   var PostBody=json.encode(FormValues);
//
//   var response= await  http.post(URL,headers:RequestHeader,body: PostBody);
//
//   var ResultCode=response.statusCode;
//   var ResultBody=json.decode(response.body);
//
//
//   if(ResultCode==200 && ResultBody['status']=="success"){
//     SuccessToast("Request Success");
//     return true;
//   }
//   else{
//     ErrorToast("Request fail ! try again");
//     return false;
//   }
// }
//
// Future<List> TaskListRequest(Status) async {
//   var URL=Uri.parse("${BaseURL}/listTaskByStatus/${Status}");
//   String? token= await ReadUserData("id");
//   var RequestHeaderWithToken={"Content-Type":"application/json","token":'$token'};
//   var response= await http.get(URL,headers:RequestHeaderWithToken);
//   var ResultCode=response.statusCode;
//   var ResultBody=json.decode(response.body);
//   if(ResultCode==200 && ResultBody['status']=="success"){
//     SuccessToast("Request Success");
//     return ResultBody['data'];
//   }
//   else{
//     ErrorToast("Request fail ! try again");
//     return [];
//   }
// }
//
// Future<bool> TaskCreateRequest(FormValues) async {
//
//   var URL=Uri.parse("${BaseURL}/createTask");
//   String? token= await ReadUserData("id");
//   var RequestHeaderWithToken={"Content-Type":"application/json","token":'$token'};
//
//   var PostBody=json.encode(FormValues);
//
//   var response= await http.post(URL,headers:RequestHeaderWithToken,body: PostBody);
//   var ResultCode=response.statusCode;
//   var ResultBody=json.decode(response.body);
//   if(ResultCode==200 && ResultBody['status']=="success"){
//     SuccessToast("Request Success");
//     return true;
//   }
//   else{
//     ErrorToast("Request fail ! try again");
//     return false;
//   }
// }
//
//
// Future<bool> TaskDeleteRequest(id) async {
//   var URL=Uri.parse("${BaseURL}/deleteTask/${id}");
//   String? token= await ReadUserData("id");
//   var RequestHeaderWithToken={"Content-Type":"application/json","token":'$token'};
//   var response= await http.get(URL,headers:RequestHeaderWithToken);
//   var ResultCode=response.statusCode;
//   var ResultBody=json.decode(response.body);
//   if(ResultCode==200 && ResultBody['status']=="success"){
//     SuccessToast("Request Success");
//     return true;
//   }
//   else{
//     ErrorToast("Request fail ! try again");
//     return false;
//   }
// }
//
//
// Future<bool> TaskUpdateRequest(id,status) async {
//   var URL=Uri.parse("${BaseURL}/updateTaskStatus/${id}/${status}");
//   String? token= await ReadUserData("id");
//   var RequestHeaderWithToken={"Content-Type":"application/json","token":'$token'};
//   var response= await http.get(URL,headers:RequestHeaderWithToken);
//   var ResultCode=response.statusCode;
//   var ResultBody=json.decode(response.body);
//   if(ResultCode==200 && ResultBody['status']=="success"){
//     SuccessToast("Request Success");
//     return true;
//   }
//   else{
//     ErrorToast("Request fail ! try again");
//     return false;
//   }
// }
//
// import 'dart:convert';
// import 'package:taskmanager/Style/Style.dart';
// import 'package:http/http.dart' as http;
// import 'package:taskmanager/utility/utility.dart';
//
// const String BaseURL = "http://35.73.30.144:2005/api/v1";
//
// Future<Map<String, String>> getHeaders({bool requiresAuth = false}) async {
//   Map<String, String> headers = {"Content-Type": "application/json"};
//   if (requiresAuth) {
//     String? token = await ReadUserData("token"); // Fetch token after login
//     if (token != null) {
//       headers["token"] = token;
//     }
//   }
//   return headers;
// }
//
// Future<bool> LoginRequest(Map<String, String> formValues) async {
//   final url = Uri.parse("$BaseURL/login");
//   final headers = await getHeaders();
//   final response = await http.post(url, headers: headers, body: json.encode(formValues));
//   final responseBody = json.decode(response.body);
//
//   if (response.statusCode == 200 && responseBody['status'] == "success") {
//     SuccessToast("Login Successful");
//     await WriteUserData(responseBody); // Save token and user data
//     return true;
//   } else {
//     ErrorToast(responseBody['data'] ?? "Login failed! Please try again.");
//     return false;
//   }
// }
//
// Future<bool> RegistrationRequest(Map<String, String> formValues) async {
//   final url = Uri.parse("$BaseURL/registration");
//   final headers = await getHeaders();
//   final response = await http.post(url, headers: headers, body: json.encode(formValues));
//   final responseBody = json.decode(response.body);
//
//   if (response.statusCode == 200 && responseBody['status'] == "success") {
//     SuccessToast("Registration Successful");
//     return true;
//   } else {
//     ErrorToast(responseBody['data'] ?? "Registration failed! Please try again.");
//     return false;
//   }
// }
//
// Future<bool> VerifyEmailRequest(String email) async {
//   final url = Uri.parse("$BaseURL/RecoverVerifyEmail/$email");
//   final headers = await getHeaders();
//   final response = await http.get(url, headers: headers);
//   final responseBody = json.decode(response.body);
//
//   if (response.statusCode == 200 && responseBody['status'] == "success") {
//     await WriteEmailVerification(email);
//     SuccessToast("Email Verified Successfully");
//     return true;
//   } else {
//     ErrorToast(responseBody['data'] ?? "Email verification failed!");
//     return false;
//   }
// }
//
// Future<bool> VerifyOTPRequest(String email, String otp) async {
//   final url = Uri.parse("$BaseURL/RecoverVerifyOtp/$email/$otp");
//   final headers = await getHeaders();
//   final response = await http.get(url, headers: headers);
//   final responseBody = json.decode(response.body);
//
//   if (response.statusCode == 200 && responseBody['status'] == "success") {
//     await WriteOTPVerification(otp);
//     SuccessToast("OTP Verified Successfully");
//     return true;
//   } else {
//     ErrorToast(responseBody['data'] ?? "OTP verification failed!");
//     return false;
//   }
// }
//
// Future<bool> SetPasswordRequest(Map<String, String> formValues) async {
//   final url = Uri.parse("$BaseURL/RecoverResetPassword");
//   final headers = await getHeaders();
//   final response = await http.post(url, headers: headers, body: json.encode(formValues));
//   final responseBody = json.decode(response.body);
//
//   if (response.statusCode == 200 && responseBody['status'] == "success") {
//     SuccessToast("Password Reset Successfully");
//     return true;
//   } else {
//     ErrorToast(responseBody['data'] ?? "Password reset failed!");
//     return false;
//   }
// }
//
// Future<List> TaskListRequest(String status) async {
//   final url = Uri.parse("$BaseURL/listTaskByStatus/$status");
//   final headers = await getHeaders(requiresAuth: true);
//   final response = await http.get(url, headers: headers);
//   final responseBody = json.decode(response.body);
//
//   if (response.statusCode == 200 && responseBody['status'] == "success") {
//     return responseBody['data'];
//   } else {
//     ErrorToast(responseBody['data'] ?? "Failed to fetch tasks");
//     return [];
//   }
// }
//
// Future<bool> TaskCreateRequest(Map<String, String> formValues) async {
//   final url = Uri.parse("$BaseURL/createTask");
//   final headers = await getHeaders(requiresAuth: true);
//   final response = await http.post(url, headers: headers, body: json.encode(formValues));
//   final responseBody = json.decode(response.body);
//
//   if (response.statusCode == 200 && responseBody['status'] == "success") {
//     SuccessToast("Task Created Successfully");
//     return true;
//   } else {
//     ErrorToast(responseBody['data'] ?? "Task creation failed!");
//     return false;
//   }
// }
//
// Future<bool> TaskDeleteRequest(String id) async {
//   final url = Uri.parse("$BaseURL/deleteTask/$id");
//   final headers = await getHeaders(requiresAuth: true);
//   final response = await http.delete(url, headers: headers);
//   final responseBody = json.decode(response.body);
//
//   if (response.statusCode == 200 && responseBody['status'] == "success") {
//     SuccessToast("Task Deleted Successfully");
//     return true;
//   } else {
//     ErrorToast(responseBody['data'] ?? "Task deletion failed!");
//     return false;
//   }
// }
//
// Future<bool> TaskUpdateRequest(String id, String status) async {
//   final url = Uri.parse("$BaseURL/updateTaskStatus/$id/$status");
//   final headers = await getHeaders(requiresAuth: true);
//   final response = await http.put(url, headers: headers);
//   final responseBody = json.decode(response.body);
//
//   if (response.statusCode == 200 && responseBody['status'] == "success") {
//     SuccessToast("Task Updated Successfully");
//     return true;
//   } else {
//     ErrorToast(responseBody['data'] ?? "Task update failed!");
//     return false;
//   }
// }

///main
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:taskmanager/Style/Style.dart';
// import 'package:taskmanager/utility/utility.dart';
//
// // Base URL for the API
// const String BaseURL = "http://35.73.30.144:2005/api/v1";
//
// // Helper function to construct headers
// Future<Map<String, String>> getHeaders({bool requiresAuth = false}) async {
//   Map<String, String> headers = {"Content-Type": "application/json"};
//   if (requiresAuth) {
//     String? token = await ReadUserData("token"); // Fetch token after login
//     if (token != null) {
//       headers["token"] = token;
//     }
//   }
//   return headers;
// }
//
// // API to handle Login
// Future<bool> LoginRequest(Map<String, String> formValues) async {
//   final url = Uri.parse("$BaseURL/Login");
//   final headers = await getHeaders();
//   final response =
//       await http.post(url, headers: headers, body: json.encode(formValues));
//   final responseBody = json.decode(response.body);
//
//   if (response.statusCode == 200 && responseBody['status'] == "success") {
//     SuccessToast("Login Successful");
//     await WriteUserData(responseBody); // Save token and user data
//     return true;
//   } else {
//     ErrorToast(responseBody['data'] ?? "Login failed! Please try again.");
//     return false;
//   }
// }
//
// // API to handle Registration
// Future<bool> RegistrationRequest(Map<String, String> formValues) async {
//   final url = Uri.parse("$BaseURL/Registration");
//   final headers = await getHeaders();
//   final response =
//       await http.post(url, headers: headers, body: json.encode(formValues));
//   final responseBody = json.decode(response.body);
//
//   if (response.statusCode == 200 && responseBody['status'] == "success") {
//     SuccessToast("Registration Successful");
//     return true;
//   } else {
//     ErrorToast(
//         responseBody['data'] ?? "Registration failed! Please try again.");
//     return false;
//   }
// }
//
// // API to verify email
// Future<bool> VerifyEmailRequest(String email) async {
//   final url = Uri.parse("$BaseURL/RecoverVerifyEmail/$email");
//   final headers = await getHeaders();
//   final response = await http.get(url, headers: headers);
//   final responseBody = json.decode(response.body);
//
//   if (response.statusCode == 200 && responseBody['status'] == "success") {
//     SuccessToast(responseBody['data']);
//     return true;
//   } else {
//     ErrorToast(responseBody['data'] ?? "Email verification failed!");
//     return false;
//   }
// }
//
// // API to verify OTP
// Future<bool> VerifyOTPRequest(String email, String otp) async {
//   final url = Uri.parse("$BaseURL/RecoverVerifyOtp/$email/$otp");
//   final headers = await getHeaders();
//   final response = await http.get(url, headers: headers);
//   final responseBody = json.decode(response.body);
//
//   if (response.statusCode == 200 && responseBody['status'] == "success") {
//     SuccessToast("OTP Verified Successfully");
//     return true;
//   } else {
//     ErrorToast(responseBody['data'] ?? "OTP verification failed!");
//     return false;
//   }
// }
// Future<List> TaskListRequest(String status) async {
//   final url = Uri.parse("$BaseURL/ListTaskByStatus/$status");
//   final headers = await getHeaders(requiresAuth: true);
//   final response = await http.get(url, headers: headers);
//   final responseBody = json.decode(response.body);
//
//   if (response.statusCode == 200 && responseBody['status'] == "success") {
//     return responseBody['data'] ?? [];
//   } else {
//     ErrorToast(responseBody['data'] ?? "Failed to fetch tasks.");
//     return [];
//   }
// }
//
// Future<bool> TaskCreateRequest(Map<String, String> formValues) async {
//   final url = Uri.parse("$BaseURL/CreateTask");
//   final headers = await getHeaders(requiresAuth: true);
//   final response = await http.post(url, headers: headers, body: json.encode(formValues));
//   final responseBody = json.decode(response.body);
//
//   if (response.statusCode == 200 && responseBody['status'] == "success") {
//     SuccessToast("Task Created Successfully.");
//     return true;
//   } else {
//     ErrorToast(responseBody['data'] ?? "Task creation failed!");
//     return false;
//   }
// }
//
// Future<bool> TaskDeleteRequest(String id) async {
//   final url = Uri.parse("$BaseURL/DeleteTask/$id");
//   final headers = await getHeaders(requiresAuth: true);
//   final response = await http.delete(url, headers: headers);
//   final responseBody = json.decode(response.body);
//
//   if (response.statusCode == 200 && responseBody['status'] == "success") {
//     SuccessToast("Task Deleted Successfully.");
//     return true;
//   } else {
//     ErrorToast(responseBody['data'] ?? "Task deletion failed!");
//     return false;
//   }
// }
//
// Future<bool> TaskUpdateRequest(String id, String status) async {
//   final url = Uri.parse("$BaseURL/UpdateTaskStatus/$id/$status");
//   final headers = await getHeaders(requiresAuth: true);
//   final response = await http.put(url, headers: headers);
//   final responseBody = json.decode(response.body);
//
//   if (response.statusCode == 200 && responseBody['status'] == "success") {
//     SuccessToast("Task Updated Successfully.");
//     return true;
//   } else {
//     ErrorToast(responseBody['data'] ?? "Task update failed!");
//     return false;
//   }
// }
//
// // API to reset password
// Future<bool> SetPasswordRequest(Map<String, String> formValues) async {
//   final url = Uri.parse("$BaseURL/RecoverResetPassword");
//   final headers = await getHeaders();
//   final response =
//       await http.post(url, headers: headers, body: json.encode(formValues));
//   final responseBody = json.decode(response.body);
//
//   if (response.statusCode == 200 && responseBody['status'] == "success") {
//     SuccessToast("Password Reset Successfully");
//     return true;
//   } else {
//     ErrorToast(responseBody['data'] ?? "Password reset failed!");
//     return false;
//   }
//
// }

///main2

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
