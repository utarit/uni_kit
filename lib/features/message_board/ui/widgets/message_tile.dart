// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class MessageTile extends StatelessWidget {
//   final String content;
//   final List<dynamic> tags;
//   final Timestamp postedTime;

//   MessageTile(
//       {@required this.content, @required this.tags, @required this.postedTime});
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: Container(
//         padding: const EdgeInsets.all(8),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             SizedBox(
//               height: 20,
//               child: ListView(
//                 scrollDirection: Axis.horizontal,
//                 children: List.generate(tags.length, (i) {
//                   return Text(
//                     "#" + tags[i] + " ",
//                     style: TextStyle(
//                       // color: Colors.grey,
//                       fontSize: 15,
//                     ),
//                   );
//                 }),
//               ),
//             ),
//             SizedBox(
//               height: 8,
//             ),
//             SelectableText(content),
//             SizedBox(
//               height: 8,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: <Widget>[
//                 Text(
//                   _formattedDate(postedTime.toDate()),
//                   style: TextStyle(
//                     color: Colors.grey,
//                     fontSize: 12,
//                   ),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   String _formattedDate(DateTime date) {
//     return "${date.day >= 10 ? '' : 0}${date.day}.${date.month >= 10 ? '' : 0}${date.month}.${date.year} ${date.hour >= 10 ? '' : 0}${date.hour}:${date.minute >= 10 ? '' : 0}${date.minute}";
//   }
// }
