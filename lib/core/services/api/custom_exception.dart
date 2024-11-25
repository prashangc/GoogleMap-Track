class CustomException implements Exception {
  CustomException([this._message]);

  final dynamic _message;

  dynamic get message {
    return _message;
  }

  @override
  String toString() {
    return _message;
  }
}

class FetchDataException extends CustomException {
  FetchDataException([String? message]) : super("Error During Communication: ");
}

class NoInternetException extends CustomException {
  NoInternetException() : super("No Internet Connection");
}

class BadRequestException extends CustomException {
  BadRequestException([String? message]) : super(message ?? "Invalid Request");
}

class ResourceNotFoundException extends CustomException {
  ResourceNotFoundException([String? message])
      : super(message ?? "Resource not found.Error code  404 ");
}

class UnauthorisedException extends CustomException {
  UnauthorisedException([String? message]) : super(message ?? "Unauthorized");
}

class InternalServerErrorException extends CustomException {
  InternalServerErrorException() : super("Server error ");
}

class InvalidInputException extends CustomException {
  InvalidInputException([String? message]) : super(message ?? "Invalid Input ");
}

class SessionExpiredException extends CustomException {
  SessionExpiredException() : super("Session Expired");
}

class ForbiddenException extends CustomException {
  ForbiddenException() : super("Forbidden !!! Please re-login");
}

class UnknownException extends CustomException {
  UnknownException() : super("Unknown Exception");
}
