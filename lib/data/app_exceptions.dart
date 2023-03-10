import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';

class AppExceptions implements Exception {
  final _message;
  final _prefix;
  AppExceptions([this._message,this._prefix]);
  @override
  String toString() {
    // TODO: implement toString
    return '$_prefix$_message';
  }
}
class FetchDataException extends AppExceptions{
  FetchDataException([String? message]):super(message,'Error during Communication');
}
class BadRequestDataException extends AppExceptions{
  BadRequestDataException([String? message]):super(message,'Invalid request');
}
class UnauthorisedException extends AppExceptions{
  UnauthorisedException([String? message]):super(message,'Unauthorised request');
}
class InvalidInputException extends AppExceptions{
  InvalidInputException([String? message]):super(message,'Invalid Input request');
}