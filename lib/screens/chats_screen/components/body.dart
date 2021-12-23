import 'package:flutter/material.dart';

import 'package:chat_app/constants.dart';
import 'package:chat_app/models/Chat.dart';
import 'package:chat_app/components/filled_outline_button.dart';
import 'chat_card.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(
              kDefaultPadding, 0, kDefaultPadding, kDefaultPadding),
          color: kPrimaryColor,
          child: Row(
            children: [
              FillOutlineButton(press: () {}, text: "Recent Messages"),
              const SizedBox(width: kDefaultPadding),
              FillOutlineButton(press: () {}, text: "Active", isFilled: false),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: chatsData.length,
            itemBuilder: (context, index) => ChatCard(
              chat: chatsData[index],
              press: () {},
            ),
          ),
        ),
      ],
    );
  }
}
