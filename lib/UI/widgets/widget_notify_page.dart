import 'package:flutter/material.dart';

import '../theme.dart';

class WidgetNotifyPage extends StatelessWidget {
  final String titleCard;
  final IconData iconCard;
  final String subTitleCard;
  const WidgetNotifyPage({Key? key, required this.titleCard, required this.iconCard, required this.subTitleCard}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(iconCard),
            const SizedBox(width: 5,),
            Text(titleCard,)
          ],
        ),
        Text(subTitleCard)
      ],
    );
  }


}
