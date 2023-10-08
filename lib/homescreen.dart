import "package:flutter/material.dart";
import "package:studioai/imagescreen.dart";
import "package:studioai/process_prompt.dart";
import "dart:async";
// import 'package:webview_flutter/webview_flutter.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:wallpaper_manager/wallpaper_manager.dart';
// import 'package:wallpaper_manager_flutter/wallpaper_manager_flutter.dart';

StreamController<ImageData> myStreamController = StreamController<ImageData>();

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF323232),
      appBar: myAppBar(),
      body: Column(
        children: [
          myPromptBar(),
          const SizedBox(height: 5),
          const Text(
            "Previously Generated Images",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 5),
          Expanded(
            child: Container(
              // color: Colors.green,
              child: MyGridView(myStreamController.stream),
            ),
          ),
        ],
      ),
    );
  }
}

class MyGridView extends StatefulWidget {
  // const MyGridView({super.key});

  MyGridView(this.stream);
  final Stream<ImageData> stream;

  @override
  _MyGridViewState createState() => _MyGridViewState();
}

class _MyGridViewState extends State<MyGridView> {
  List<ImageData> items = [
    ImageData(
      "futuristic city",
      "https://i.imgur.com/9P5AeBZ.png",
    ),
    ImageData(
      "autumn forest landscape",
      "https://i.imgur.com/8evaUhU.png",
    ),
    ImageData(
      "technologically futuristic city",
      "https://i.imgur.com/qirietx.png",
    ),
    ImageData(
      "lions in a savannah",
      "https://i.imgur.com/QcjYOqz.png",
    ),
    ImageData(
      "alan turing",
      "https://i.imgur.com/Lf4iaVa.png",
    ),
  ];

  @override
  void initState() {
    super.initState();
    widget.stream.listen((imageData) {
      addTextCard(imageData); // needs this here to actually update the cards
    });
  }

  void addTextCard(ImageData imageData) {
    setState(() {
      items.insert(0, imageData);
    });
  }

  void removeItem(ImageData imageData) {
    int index = items.indexOf(imageData);
    if (index != -1) {
      setState(() {
        items.removeAt(index);
      });
    } else {
      print("it was -1 bruh");
    }
  }

  void onCardTap(ImageData imageData) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ImageOptionScreen(
          prompt: imageData.imagePrompt,
          url: imageData.imageURL,
          onDelete: () {
            removeItem(imageData);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: GridView.builder(
            itemCount: items.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () => onCardTap(
                    items[index]), // passes the function as an argument
                child: Card(
                  color: const Color(
                      0xFF323232), // colors the card the same as the background
                  margin: EdgeInsets.all(15),
                  child: Hero(
                    tag: "myHero_${items[index].imageURL}",
                    child: Image.network(
                      items[index].imageURL,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class ImageData {
  final String imagePrompt, imageURL;

  ImageData(this.imagePrompt, this.imageURL);
}

Container myPromptBar() {
  TextEditingController promptController = TextEditingController();

  return Container(
    margin: EdgeInsets.all(15),
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          blurRadius: 20,
          spreadRadius: 5,
        )
      ],
    ),
    child: TextField(
      controller: promptController,
      onSubmitted: (text) async {
        if (text.isNotEmpty) {
          final imageURL = await generateImage(text);
          if (imageURL != null) {
            myStreamController.add(ImageData(text, imageURL));
            promptController.clear();
            // print("text : " + text);
            // print("imageURL : " + imageURL);
          } else {
            print("Failed to generate image.");
          }
        } else {
          print("Can't use empty prompt.");
        }
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.blueGrey,
        contentPadding: EdgeInsets.all(15),
        hintText: "Enter image prompt",
        hintStyle: TextStyle(color: Colors.white, fontSize: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      style: const TextStyle(
        fontSize: 20,
      ),
    ),
  );
}

AppBar myAppBar() {
  return AppBar(
    title: const Text(
      "StudioAI",
      style: TextStyle(
          color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
    ),
    centerTitle: true,
    backgroundColor: Colors.black,
    elevation: 0,
  );
}
