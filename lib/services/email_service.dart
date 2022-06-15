import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class EmailService {
  sendEmail(String to, String pdfUrl) async {
    try {
      final url = Uri.parse("https://api.emailjs.com/api/v1.0/email/send");
      final response = await http.post(url,
          headers: {'origin': 'http://localhost', 'Content-Type': 'application/json'},
          body: jsonEncode({
            'service_id': dotenv.env['SERVICE_ID'],
            'template_id': dotenv.env['TEMPLATE_ID'],
            'user_id': dotenv.env['USER_ID'],
            'template_params': {'url': pdfUrl, 'to': to}
          }));
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}
