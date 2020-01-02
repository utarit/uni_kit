String formattedNum(int number) => number < 10 ? "0$number" : "$number";
DateTime schoolStarted = DateTime.now().isBefore(DateTime.utc(2020, 2, 3))
    ? DateTime.utc(2019, 9, 23)
    : DateTime.utc(2020, 2, 3);
String capitalizeFirst(String s) => s[0].toUpperCase() + s.substring(1);

String capitalizeFirstLetter(String str) {
  var arr = str.split(" ");
  var result = [];
  for (String s in arr) {
    result.add((s?.isNotEmpty ?? false)
        ? '${s[0].toUpperCase()}${s.substring(1).toLowerCase()}'
        : s);
  }
  return result.join(" ");
}

int totalMin(int hour, int min) => hour * 60 + min;
const int UPPER_LIMIT = 4294967295;
const List<String> months = [
  "",
  "Jan",
  "Feb",
  "Mar",
  "Apr",
  "May",
  "Jun",
  "Jul",
  "Aug",
  "Sep",
  "Oct",
  "Nov",
  "Dec"
];

List<GroupModel> days = [
  GroupModel(
    text: "Monday",
    index: 1,
  ),
  GroupModel(
    text: "Tuesday",
    index: 2,
  ),
  GroupModel(
    text: "Wednesday",
    index: 3,
  ),
  GroupModel(
    text: "Thursday",
    index: 4,
  ),
  GroupModel(
    text: "Friday",
    index: 5,
  ),
];

List<GroupModel> hours = [
  GroupModel(
    text: "8.40",
    index: 0,
  ),
  GroupModel(
    text: "9.40",
    index: 1,
  ),
  GroupModel(
    text: "10.40",
    index: 2,
  ),
  GroupModel(
    text: "11.40",
    index: 3,
  ),
  GroupModel(
    text: "12.40",
    index: 4,
  ),
  GroupModel(
    text: "13.40",
    index: 5,
  ),
  GroupModel(
    text: "14.40",
    index: 6,
  ),
  GroupModel(
    text: "15.40",
    index: 7,
  ),
  GroupModel(
    text: "16.40",
    index: 8,
  ),
];

class GroupModel {
  String text;
  int index;
  GroupModel({this.text, this.index});
}
