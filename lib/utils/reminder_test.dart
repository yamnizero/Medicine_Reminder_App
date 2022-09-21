// import 'package:flutter/material.dart';
//
// class IntervalSelection extends StatefulWidget {
//   @override
//   _IntervalSelectionState createState() => _IntervalSelectionState();
// }
//
// class _IntervalSelectionState extends State<IntervalSelection> {
//   var _intervals = [
//     6,
//     8,
//     12,
//     24,
//   ];
//   var _selected = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 8.0),
//       child: Container(
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               "Remind me every  ",
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 18,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//             DropdownButton<int>(
//               iconEnabledColor: Color(0xFF3EB16F),
//               hint: _selected == 0
//                   ? const Text(
//                 "Select an Interval",
//                 style: TextStyle(
//                     fontSize: 10,
//                     color: Colors.black,
//                     fontWeight: FontWeight.w400),
//               )
//                   : null,
//               elevation: 4,
//               value: _selected == 0 ? null : _selected,
//               items: _intervals.map((int value) {
//                 return DropdownMenuItem<int>(
//                   value: value,
//                   child: Text(
//                     value.toString(),
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 18,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 );
//               }).toList(),
//               onChanged: (newVal) {
//                 setState(() {
//                   _selected = newVal!;
//                   updateInterval(newVal);
//                 });
//               },
//             ),
//             Text(
//               _selected == 1 ? " hour" : " hours",
//               style: const TextStyle(
//                 color: Colors.black,
//                 fontSize: 18,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//
// }