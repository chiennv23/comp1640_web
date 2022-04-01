// import 'dart:js';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import 'model/file_drop_item.dart';
//
// class DroppedFileWidget extends StatelessWidget {
//   final File_Data_Model file;
//
//   const DroppedFileWidget({Key key, this.file}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final style = TextStyle(fontSize: 20);
//     return Container(
//       margin: EdgeInsets.only(left: 24),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           Text(
//             'Selected File Preview ',
//             style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
//           ),
//           Text(
//             'Name: ${file?.name}',
//             style: TextStyle(fontWeight: FontWeight.w800, fontSize: 22),
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           Text('Type: ${file?.mime}', style: style),
//           const SizedBox(
//             height: 10,
//           ),
//           Text('Size: ${file?.size}', style: style),
//           SizedBox(
//             height: 20,
//           )
//         ],
//       ),
//     );
//   }
// }
