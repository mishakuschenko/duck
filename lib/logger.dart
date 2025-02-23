
class Logger {
  final _redColor = '\x1B[31m';
  final _greenColor = '\x1B[32m';
  final _resetColor = '\x1B[0m'; 
  final _succes = '[SUCCES]';
  final _error = '[ERROR]';
  
  void startServer(String text) {
    final borderChar = '*';
    final textLength = text.length;
    final borderLine = borderChar * (textLength + 4);

    print(' $_greenColor$borderLine$_resetColor\n');
    print(' $_greenColor$borderChar $text $borderChar$_resetColor\n');
    print(' $_greenColor$borderLine$_resetColor');
  }

  void succesRes(String method) {
    DateTime time = DateTime.now().toLocal();
    print('$_greenColor $_succes $method $time $_resetColor');
  }

  void errorRes(String method, String text) {
    DateTime time = DateTime.now().toLocal();
    print('$_redColor $_error $method $time: $text $_resetColor');
  }
}