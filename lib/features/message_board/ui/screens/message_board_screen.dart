import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uni_kit/core/utils/common_functions.dart';
import 'package:uni_kit/features/message_board/ui/widgets/message_form.dart';
import 'package:uni_kit/features/message_board/ui/widgets/message_tile.dart';

List<String> mostUsedTags = [
  "kayıp",
  "topluluklar",
  "hazırlık",
  "hayvanlar",
  "tanışma",
  "unikit",
  "odtü"
];

class MessageBoardScreen extends StatefulWidget {
  @override
  _MessageBoardScreenState createState() => _MessageBoardScreenState();
}

class _MessageBoardScreenState extends State<MessageBoardScreen>
    with SingleTickerProviderStateMixin {
  Set<String> filters = Set();
  TextEditingController textController = TextEditingController();
  AnimationController _sizeFactor;
  bool showFilter = false;

  _showBottomSheet(context) {
    showBottomSheet(
        context: context,
        builder: (context) {
          return MessageForm();
        });
  }

  bool applyFilter(List<dynamic> tags) {
    if (filters.isEmpty) return true;
    for (var filter in filters) {
      if (tags.contains(filter)) return true;
    }
    return false;
  }

  @override
  void initState() {
    _sizeFactor = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey[900],
        child: Icon(Icons.create),
        onPressed: () {
          _showBottomSheet(context);
        },
      ),
      body: Container(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 45.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Message Board (beta)",
                  style: TextStyle(
                      fontFamily: "Galano",
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  child: AnimatedIcon(
                    icon: AnimatedIcons.menu_close,
                    progress: _sizeFactor,
                  ),
                  onTap: () {
                    showFilter = !showFilter;
                    if (showFilter) {
                      _sizeFactor.forward();
                    } else {
                      _sizeFactor.reverse();
                    }
                  },
                ),
              ],
            ),
          ),
          SizeTransition(
            sizeFactor: _sizeFactor,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: mostUsedTags.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            filters.add(mostUsedTags[index]);
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.all(4.0),
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color(colorPalette[
                                index > colorPalette.length
                                    ? colorPalette.length % index
                                    : index]),
                          ),
                          child: Text("#" + mostUsedTags[index],
                              style: TextStyle(color: Colors.white
                                  // Color(colorPalette[index > colorPalette.length ? colorPalette.length % index: index]),
                                  )),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  height: 60,
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
                  child: TextField(
                    controller: textController,
                    maxLength: 20,
                    maxLines: 1,
                    maxLengthEnforced: true,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          if (textController.text.length > 0) {
                            setState(() {
                              filters.add(textController.text);
                            });
                          }
                          Future.delayed(Duration(milliseconds: 50)).then((_) {
                            textController.clear();
                            FocusScope.of(context).unfocus();
                          });
                        },
                      ),
                      labelText: "Add Filter",
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Active Filters",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          if (filters.length > 0)
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: filters.length,
                itemBuilder: (context, index) {
                  return Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(4.0),
                    // padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      // color: Color(colorPalette[index > colorPalette.length
                      //     ? colorPalette.length % index
                      //     : index],
                      //     ),
                    ),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "#" + filters.elementAt(index),
                            // style: TextStyle(color: Colors.white),
                          ),
                        ),
                        IconButton(
                          iconSize: 16,
                          icon: Icon(
                            Icons.clear,
                            // color: Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              filters.remove(filters.elementAt(index));
                            });
                          },
                        )
                      ],
                    ),
                  );
                },
              ),
            )
          else
            Padding(
              padding: const EdgeInsets.only(left: 8.0, bottom: 8),
              child: Text("No filter"),
            ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance
                  .collection('messages')
                  .orderBy('postedTime', descending: true)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError)
                  return Center(child: Text('Error: ${snapshot.error}'));
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Center(child: CircularProgressIndicator());
                  default:
                    var filteredData = snapshot.data.documents
                        .where((doc) => applyFilter(doc["tags"]));
                    if (filteredData.isEmpty) {
                      return Center(
                        child: Text(
                          "Entry not Found",
                          // style: TextStyle(
                          //     fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                      );
                    }
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: ListView(
                        children: filteredData.map((DocumentSnapshot document) {
                          return MessageTile(
                              content: document["content"],
                              postedTime: document["postedTime"],
                              tags: document["tags"]);
                        }).toList(),
                      ),
                    );
                }
              },
            ),
          ),
        ],
      )),
    );
  }
}
