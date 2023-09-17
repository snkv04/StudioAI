import "dart:async";

import "package:flutter/material.dart";

StreamController<String> myStreamController = StreamController<String>();

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
  final Stream<String> stream;

  @override
  _MyGridViewState createState() => _MyGridViewState();
}

class _MyGridViewState extends State<MyGridView> {
  List<String> items = ["Item 1", "Item 2", "ITem 3"];

  @override
  void initState() {
    super.initState();
    widget.stream.listen((text) {
      addTextCard(text); // needs this here to actually update the cards
    });
  }

  // void addItem() {
  //   setState(() {
  //     items.insert(0, "Item ${items.length + 1}");
  //   });
  // }

  void addTextCard(String text) {
    setState(() {
      items.insert(0, text);
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
                  child: Text(
                    items[index],
                    style: const TextStyle(
                      fontSize: 24.5,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 20),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     ElevatedButton(
        //       onPressed: addItem,
        //       child: Text("Add new item"),
        //     ),
        //     SizedBox(width: 20),
        //     ElevatedButton(
        //       onPressed: removeItem,
        //       child: Text("Remove the last item"),
        //     ),
        //   ],
        // ),
        // const SizedBox(height: 20),
      ],
    );
  }
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
          // borderSide: BorderSide.none
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
