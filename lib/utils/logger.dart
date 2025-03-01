/// A utility class for logging server events and errors with colored output.
///
/// This class provides methods to log server startup information, successful responses,
/// and errors with timestamps and colored text for better visibility in the console.
class Logger {
  final _redColor = '\x1B[31m'; // ANSI color code for red text
  final _greenColor = '\x1B[32m'; // ANSI color code for green text
  final _resetColor = '\x1B[0m'; // ANSI color code to reset text color
  final _succes = '[SUCCES]'; // Success log prefix
  final _error = '[ERROR]'; // Error log prefix

  /// Logs the server startup information, including the host and port.
  ///
  /// [info] - a message to display as part of the startup log.
  /// [host] - the hostname where the server is running.
  /// [port] - the port number where the server is listening.
  void startServer({required String info, required String host, required int port}) {
    print('\n|!');
    print('| $info');
    print('| http://$host:$port/');
    print('| ');
    print('|      o_O');
    print('|!');
  }

  /// Logs a successful response with a timestamp and green-colored text.
  ///
  /// [method] - the HTTP method (e.g., GET, POST) associated with the successful response.
  void succesRes(String method) {
    DateTime time = DateTime.now().toLocal();
    print('$_greenColor$_succes $method $time $_resetColor');
  }

  /// Logs an error with a timestamp and red-colored text.
  ///
  /// [method] - the HTTP method (e.g., GET, POST) associated with the error.
  void errorRes(String method) {
    DateTime time = DateTime.now().toLocal();
    print('$_redColor$_error $method $time$_resetColor');
  }
}