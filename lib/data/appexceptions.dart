class AppException implements Exception{
  final _message;
  final _prefix;
  AppException([this._message,this._prefix]);

  @override
  String toString(){
    return '$_message $_prefix';
  }
}

//invalid endpoints exception
class BadRequestException extends AppException{
  BadRequestException([String? message]):super(message,'Invalid request');
}

//timeout exception
class FetchDataException extends AppException{
  FetchDataException([String? message]):super(message,'Error during communication');
}

//unauthorized user exception
class UnauthorizedException extends AppException{
  UnauthorizedException([String? message]):super(message,'Unauthorized request');
}

//incorrect input exception
class InvalidInputException extends AppException{
  InvalidInputException([String? message]):super(message,'Inavlid input');
}