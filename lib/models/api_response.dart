class ApiResponse {
  Object? data;
  ApiError? apiError;
}

class ApiError {
  String? error;

  ApiError({String? error}) {
    this.error = error ?? '';
  }

  ApiError.fromJson(Map<String, dynamic> json) {
    error = json['error'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {'error': error};
  }
}

class ApiToken {
  String? data;

  ApiToken(this.data);

  ApiToken.fromJson(Map<String, dynamic> json) {
    data = json['token'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {'token': data};
  }
}
