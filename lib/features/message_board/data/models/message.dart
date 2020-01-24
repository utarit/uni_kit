class Message {
  int id;
  String content;
  List<String> tags;
  DateTime postedTime;
  String postedBy;

  Message({this.id, this.content, this.tags, this.postedBy, this.postedTime});
}

List messages = [
  Message(
    id: 0,
    content: "This is my first message",
    tags: ["kayıp", "topluluk", "test"],
    postedTime: DateTime.now(),
    postedBy: "anonim"
  ),
  Message(
    id: 0,
    content: "This is my first message",
    tags: ["kayıp", "topluluk", "test"],
    postedTime: DateTime.now(),
    postedBy: "anonim"
  ),
  Message(
    id: 0,
    content: "This is my first message",
    tags: ["kayıp", "topluluk", "test"],
    postedTime: DateTime.now(),
    postedBy: "anonim"
  ),
  Message(
    id: 0,
    content: "This is my first message",
    tags: ["kayıp", "topluluk", "test"],
    postedTime: DateTime.now(),
    postedBy: "anonim"
  ),
];