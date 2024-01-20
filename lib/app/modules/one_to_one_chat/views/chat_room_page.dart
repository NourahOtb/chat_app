import 'package:firbase_first_connect1/app/config/theme/my_colors.dart';
import 'package:firbase_first_connect1/app/core/extensions/build_context_extensions.dart';
import 'package:firbase_first_connect1/app/modules/chats/domain/models/user_model.dart';
import 'package:firbase_first_connect1/app/modules/one_to_one_chat/widgets/chat_room_body.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChatRoomPage extends StatelessWidget {
  const ChatRoomPage({
    super.key,
    required this.userModel,
  });

  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: MyColors.white,
            )),
        centerTitle: true,
        title: Text(
          userModel.username,
          style: context.textTheme.bodyMedium?.copyWith(
            color: MyColors.white,
          ),
        ),
        backgroundColor: MyColors.primary_500,
      ),
      body: ChatRoomPageBody(userModel: userModel),
    );
  }
}
