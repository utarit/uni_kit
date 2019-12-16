
// import 'package:hive/hive.dart';
// import 'package:uni_kit/models/deadline.dart';

// class DeadlineProvider {
//     Future<List<Deadline>> sortedDeadlines() async {
//     await Hive.openBox("deadlines");
//     final deadlinesBox = Hive.box("deadlines");
//     List<Deadline> deadlines = [];
//     for (int i = 0; i < deadlinesBox.length; i++) {
//       final deadline = deadlinesBox.getAt(i) as Deadline;
//       deadlines.add(deadline);
//     }

//     deadlines.sort((a, b) => a.endTime.compareTo(b.endTime));
//     return deadlines;
//   }


// }