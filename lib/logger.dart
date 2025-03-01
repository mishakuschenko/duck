class Logger {
  final _redColor = '\x1B[31m';
  final _greenColor = '\x1B[32m';
  final _resetColor = '\x1B[0m'; 
  final _succes = '[SUCCES]';
  final _error = '[ERROR]';
  
  void startServer({required String info, 
                    required String host,
                    required int port}) {
    print('\n|!');
    print('| $info');
    print('| http://$host:$port/');
    print('| ');
    print('|      o_O');
    print('|!');
    
  }

  void succesRes(String method) {
    DateTime time = DateTime.now().toLocal();
    print('$_greenColor$_succes $method $time $_resetColor');
  }

  void errorRes(String method) {
    DateTime time = DateTime.now().toLocal();
    print('$_redColor$_error $method $time$_resetColor');
  }
}