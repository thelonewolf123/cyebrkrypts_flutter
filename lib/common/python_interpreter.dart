import 'dart:async';
import 'dart:convert';
import 'package:cyberkrypts/common/python_response.dart';
import 'package:cyberkrypts/log/logger.dart';
import 'package:http/http.dart' as http;

class PythonInterpreter {
  static Future<PythonResponse?> runPythonCode(
      String code, String stdin, List<String> args) async {
    Logger logger = Logger('PythonInterpreter');
    try {
      var response =
          await http.post(Uri.parse('https://emkc.org/api/v2/piston/execute'),
              body: jsonEncode({
                "language": "python",
                "version": "3.10.0",
                "files": [
                  {"name": "main.py", "content": code}
                ],
                "stdin": stdin,
                "args": args,
                "compile_timeout": 10000,
                "run_timeout": 3000
              }));
      Map<String, dynamic> tempData = jsonDecode(response.body);
      Map<String, dynamic> runMap = tempData['run'];
      PythonResponse data =
          PythonResponse(tempData['language'], tempData["version"], runMap);
      return data;
    } catch (e) {
      logger.logError('Error while running python code: $e');
      return null;
    }
  }
}
