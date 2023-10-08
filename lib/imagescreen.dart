import 'package:flutter/material.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class ImageOptionScreen extends StatelessWidget {
  final String prompt, url;
  final VoidCallback onDelete;

  const ImageOptionScreen({
    required this.prompt,
    required this.url,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Image Details",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Color(0xFF323232),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Row(
              // the definition of inefficient code
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: 25),
                const Text(
                  "Prompt used: ",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(width: 15),
                Flexible(
                  fit: FlexFit.loose,
                  child: Text(
                    "\"" + prompt + "\"",
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
                const SizedBox(width: 25),
              ],
            ),
            // const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(20.0),
              child: Hero(
                tag: "myHero_${url}",
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(url),
                ),
              ),
            ),
            const Text(
              "Options:",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                try {
                  var imageID = await ImageDownloader.downloadImage(url);
                  // print("successfully downloaded image");
                } catch (err) {
                  print("error: $err");
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                elevation: 0.0,
              ),
              child: Container(
                padding: EdgeInsets.all(10),
                child: const Text(
                  "Download",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                try {
                  final response = await http.get((Uri.parse(url)));
                  final tempDir = await getTemporaryDirectory();
                  final filePath = "${tempDir.path}/image.png";
                  final imageFile = File(filePath);
                  await imageFile.writeAsBytes(response.bodyBytes);
                  await Share.shareXFiles(
                    [XFile(filePath)],
                    // text: "An AI-generated image based on the prompt '$prompt'",
                  );
                  // print("successfully shared image");
                } catch (err) {
                  print("error: $err");
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                elevation: 0.0,
              ),
              child: Container(
                padding: EdgeInsets.all(10),
                child: const Text(
                  "Share image",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                onDelete();
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                elevation: 0.0,
              ),
              child: Container(
                padding: EdgeInsets.all(10),
                child: const Text(
                  "Delete image",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
