class NetworkResponse<T> {
  bool success;
  T? data;
  String? error;
  dynamic extras;

  NetworkResponse(this.success, {this.data, this.error, this.extras});
}
