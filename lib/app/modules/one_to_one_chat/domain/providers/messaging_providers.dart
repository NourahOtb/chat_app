import 'package:firbase_first_connect1/app/modules/one_to_one_chat/domain/providers/controller/messages_notifier.dart';
import 'package:firbase_first_connect1/app/modules/one_to_one_chat/domain/providers/state/message_chat_state.dart';
import 'package:firbase_first_connect1/app/modules/one_to_one_chat/domain/repo/messaging_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final massegingRepoProvider = Provider<MessagingRepo>(
  (ref) => MessagingRepo(),
);

final chatMessageProvider =
    StateNotifierProvider<ChatMessageStateNotifer, MessageChatState>(
  (ref) => ChatMessageStateNotifer(
    MessageChatState(),
  ),
);
//final messageRepoInstance = MessagingRepo();