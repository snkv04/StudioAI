import "package:http/http.dart" as http;
import "dart:convert";

Future<String?> generateImage(String promptText) async {
  try {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:5000/api/generate_image'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'text': promptText}),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      // print(responseData["imageURL"]);
      return responseData['imageURL'];
    } else {
      return null;
    }
  } catch (e) {
    print("Exception: $e");
    return null;
  }
}
