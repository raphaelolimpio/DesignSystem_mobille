import 'dart:async';
import 'dart:convert';

class LoginService {
  static Future<Map<String, dynamic>> fetchLogin(String usr, String pwd) async {
    // Simula um delay de 2 segundos para representar o tempo de resposta da API
    await Future.delayed(const Duration(seconds: 2));

    // Aqui você pode adicionar lógica para validar o usuário e a senha
    // Neste exemplo, vamos assumir que qualquer usuário e senha são válidos

    // Simula uma resposta da API com dados fictícios do usuário
    String jsonResponse = jsonEncode({
      'name': 'João Silva',
      'email': 'alberico.safado@example.com',
      'phone': '+55 11 91234-5678',
    });

    // Decodifica a resposta JSON em um Map<String, String>
    Map<String, dynamic> decodedResponse = jsonDecode(jsonResponse);

    // Retorna a resposta como um mapa (JSON)
    return Map<String, dynamic>.from(decodedResponse);
  }
}




