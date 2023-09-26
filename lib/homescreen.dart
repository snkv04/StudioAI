import "package:flutter/material.dart";
import "dart:async";
import 'package:webview_flutter/webview_flutter.dart';

// import 'package:wallpaper_manager/wallpaper_manager.dart';
import 'package:wallpaper_manager_flutter/wallpaper_manager_flutter.dart';

StreamController<String> myStreamController = StreamController<String>();

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
          const SizedBox(height: 40),
          const Expanded(
            child: WebView(
              initialUrl: "https://stablediffusionweb.com/",
              javascriptMode: JavascriptMode.unrestricted,
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
  final Stream<String> stream;

  @override
  _MyGridViewState createState() => _MyGridViewState();
}

class _MyGridViewState extends State<MyGridView> {
  List<ImageData> items = [
    ImageData(
        "https://upload.wikimedia.org/wikipedia/commons/3/3e/Einstein_1921_by_F_Schmutzer_-_restoration.jpg"),
    ImageData(
        "https://media.geeksforgeeks.org/wp-content/uploads/bipartitegraph-1.jpg"),
    ImageData("https://pbs.twimg.com/media/E8fPMUrVgAEyHrS?format=jpg"),
    ImageData(
        "https://static.wikia.nocookie.net/fictionalcompanies/images/b/b6/DkPepperDiet.jpg/revision/latest/scale-to-width-down/1000?cb=20170314131418"),
  ];

  @override
  void initState() {
    super.initState();
    widget.stream.listen((text) {
      addTextCard(
          ImageData(text)); // needs this here to actually update the cards
    });
  }

  void addTextCard(ImageData imageData) {
    setState(() {
      items.insert(0, imageData);
    });
  }

  void removeItem() {
    if (items.isNotEmpty) {
      setState(() {
        items.removeLast();
      });
    }
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
              return Card(
                margin: EdgeInsets.all(15),
                child: Center(
                  // child: Text(
                  //   items[index],
                  //   style: const TextStyle(
                  //     fontSize: 24.5,
                  //   ),
                  // ),
                  child: Image.network(
                    items[index].imageURL,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
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
  final String imageURL;

  ImageData(this.imageURL);
}

Container myPromptBar() {
  TextEditingController promptController = TextEditingController();

  return Container(
    margin: EdgeInsets.all(15),
    decoration: BoxDecoration(boxShadow: [
      BoxShadow(
          color: Colors.black.withOpacity(0.2), blurRadius: 20, spreadRadius: 5)
    ]),
    child: TextField(
      controller: promptController,
      onSubmitted: (text) {
        if (text.isNotEmpty) {
          myStreamController.add(text);
          promptController.clear();
          print(text);
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
      style: TextStyle(fontSize: 20),
    ),
  );
}

AppBar myAppBar() {
  return AppBar(
    title: const Text(
      "StudioAI",
      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    ),
    centerTitle: true,
    backgroundColor: Colors.black,
    elevation: 0,
  );
}
