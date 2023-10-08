import 'package:flutter/material.dart';

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
              onPressed: () {
                //
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                elevation: 0.0,
              ),
              child: Container(
                padding: EdgeInsets.all(10),
                child: const Text(
                  "Set as home screen wallpaper",
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
                //
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                elevation: 0.0,
              ),
              child: Container(
                padding: EdgeInsets.all(10),
                child: const Text(
                  "Set as lock screen wallpaper",
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
                //
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                elevation: 0.0,
              ),
              child: Container(
                padding: EdgeInsets.all(10),
                child: const Text(
                  "Set as wallpaper for both screens",
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
