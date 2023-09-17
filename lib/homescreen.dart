import "package:flutter/material.dart";

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(),
      body: Column(
        children: [
          myPromptBar(),
          SizedBox(height: 5),
          Text(
            "Previously Generated Images",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 5),
          Expanded(
            child: Container(
              // color: Colors.green,
              child: MyGridView(),
            ),
          ),
        ],
      ),
    );
  }
}

class MyGridView extends StatefulWidget {
  // const MyGridView({super.key});

  @override
  _MyGridViewState createState() => _MyGridViewState();
}

class _MyGridViewState extends State<MyGridView> {
  List<String> items = ["Item 1", "Item 2", "ITem 3"];

  void addItem() {
    setState(() {
      items.insert(0, "Item ${items.length + 1}");
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
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemBuilder: (BuildContext context, int index) {
              return Card(
                margin: EdgeInsets.all(15),
                child: Center(
                  child: Text(
                    items[index],
                    style: TextStyle(
                      fontSize: 24.5,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: addItem,
              child: Text("Add new item"),
            ),
            SizedBox(width: 20),
            ElevatedButton(
              onPressed: removeItem,
              child: Text("Remove the last item"),
            ),
          ],
        ),
        SizedBox(height: 20),
      ],
    );
  }
}

Container myPromptBar() {
  return Container(
    margin: EdgeInsets.all(15),
    decoration: BoxDecoration(boxShadow: [
      BoxShadow(
          color: Colors.black.withOpacity(0.2), blurRadius: 20, spreadRadius: 5)
    ]),
    child: TextField(
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.blueGrey,
            contentPadding: EdgeInsets.all(15),
            hintText: "Enter image prompt",
            hintStyle: TextStyle(color: Colors.white, fontSize: 20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              // borderSide: BorderSide.none
            )),
        style: TextStyle(fontSize: 20)),
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
