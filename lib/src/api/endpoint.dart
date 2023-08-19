enum Method { get }

abstract class Endpoint {
  Endpoint();
  String get path;

  Method get method;

  Map<String, dynamic> body = {};
}
