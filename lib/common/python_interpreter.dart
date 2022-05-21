import 'dart:async';
import 'dart:convert';
import 'package:cyberkrypts/common/python_response.dart';
import 'package:cyberkrypts/log/logger.dart';
import 'package:http/http.dart' as http;

class PythonInterpreter {
  static Future<PythonResponse?> runPythonCode(
    String code,
    String stdin,
    String fileName,
  ) async {
    Logger logger = Logger('PythonInterpreter');
    var url =
        'https://1lakoh4gog.execute-api.ap-south-1.amazonaws.com/default/runPython';
    try {
      var response = await http.post(Uri.parse(url),
          body: jsonEncode({
            "fileName": fileName,
            'code': code,
            "stdin": stdin,
          }));
      Map<String, dynamic> tempData = jsonDecode(response.body);

      List<String> output = tempData['output'].cast<String>();
      List<String> stderr = tempData['stderr'].cast<String>();

      PythonResponse data = PythonResponse(output, stderr, tempData['error']);
      return data;
    } catch (e) {
      logger.logError('Error while running python code: $e');
      return null;
    }
  }
}
