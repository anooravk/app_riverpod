import 'package:mvvm/data/response/status.dart';

class ApiResponse<T>{
  String? message;
  T? data;
  Status? status;
  ApiResponse(this.status,this.data,this.message);

  ApiResponse.loading() : status = Status.LOADING;
  ApiResponse.completed(this.data) : status = Status.SUCESS;
  ApiResponse.error(this.message) : status = Status.ERROR;

  @override
  String toString(){
    return "Status: $status,  \nMessage: $message, \nData: $data";
  }
}