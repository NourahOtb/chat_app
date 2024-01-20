import 'package:firbase_first_connect1/app/config/theme/my_colors.dart';
import 'package:firbase_first_connect1/app/core/extensions/build_context_extensions.dart';
import 'package:firbase_first_connect1/app/modules/one_to_one_chat/domain/models/message.dart';
import 'package:flutter/material.dart';

class SenderMessageBubble extends StatelessWidget {
  const SenderMessageBubble({super.key, required this.messageToDisplay});

  final Message messageToDisplay;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Flexible(
          child: Container(
            decoration: BoxDecoration(
              color: MyColors.secondary_500,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
                bottomLeft: Radius.circular(15),
              ),
            ),
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.all(8),
            child: Column(
              children: [
                messageToDisplay.message.startsWith("https")
                    ? GestureDetector(
                        onTap: () {},
                        child: Image.network(
                          messageToDisplay.message,
                          height: MediaQuery.of(context).size.height * 0.2,
                          width: context.screenWidth * 0.4,
                        ),
                      )
                    : Text(
                        messageToDisplay.message.toString(),
                        style: context.textTheme.bodyMedium
                            ?.copyWith(color: MyColors.white),
                      ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  messageToDisplay.timeStamp.toString(),
                  style: context.textTheme.bodyMedium
                      ?.copyWith(color: MyColors.white),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
