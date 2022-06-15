import 'dart:convert';

import 'package:http/http.dart' as http;

class EmailService {
  sendEmail(String to, String pdfUrl) async {
    try {
      final url = Uri.parse("https://api.emailjs.com/api/v1.0/email/send");
      final response = await http.post(url,
          headers: {'origin': 'http://localhost', 'Content-Type': 'application/json'},
          body: jsonEncode({
            'service_id': 'service_0xfntjl',
            'template_id': 'template_l01irvt',
            'user_id': 'lvODb-ZGOTfbBa3Yx',
            'template_params': {'url': pdfUrl, 'to': to}
          }));
      print('email sent');
      return response.statusCode == 200;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
