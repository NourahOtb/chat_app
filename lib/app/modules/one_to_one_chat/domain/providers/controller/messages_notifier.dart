import 'dart:io';

import 'package:firbase_first_connect1/app/modules/one_to_one_chat/domain/providers/state/message_chat_state.dart';
import 'package:firbase_first_connect1/app/modules/one_to_one_chat/domain/repo/messaging_repo.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class ChatMessageStateNotifer extends StateNotifier<MessageChatState> {
  ChatMessageStateNotifer(super.state);

  final MessagingRepo _messagingRepo = MessagingRepo();
  final picker = ImagePicker();

  Future<void> sendMessage({
    required String senderId,
    required String recieverId,
    required String message,
  }) async {
    try {
      state = state.copyWith(isLoading: true);

      await _messagingRepo.sendMessage(
          senderId: senderId, recieverId: recieverId, message: message);
      state = state.copyWith(isLoading: false, message: "");
    } catch (e) {
      state =
          state.copyWith(error: e.toString(), isLoading: false, message: "");
    }
  }

  Future upLoadFile({
    required File file,
    required String senderId,
    required String recieverId,
  }) async {
    final fileName = basename(file.path);
    final destination = "file/$fileName";

    try {
      state = state.copyWith(isLoading: true);
      final reference = FirebaseStorage.instance.ref(destination);
      reference.putFile(file).then((recievedFile) async {
        final downloadedUrl = await recievedFile.ref.getDownloadURL();
        //state = state.copyWith(isLoading: false);
        /// http file
        await sendMessage(
            senderId: senderId, recieverId: recieverId, message: downloadedUrl);
      });
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  Future getImageFromGallery({
    required String senderId,
    required String recieverId,
  }) async {
    try {
      state = state.copyWith(isLoading: true);
      XFile? pickedFile = await picker.pickMedia();

      if (pickedFile != null) {
        upLoadFile(
            file: File(pickedFile.path),
            senderId: senderId,
            recieverId: recieverId);
      }
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(
        error: e.toString(),
        isLoading: false,
      );
    }
  }

  Future getImageFromCamera({
    // named arguments
    required String senderId,
    required String recieverId,
  }) async {
    try {
      state = state.copyWith(isLoading: true);
      XFile? pickedFile = await picker.pickImage(
        source: ImageSource.camera,
        maxHeight: 480,
        maxWidth: 640,
        imageQuality: 50,
      );

      if (pickedFile != null) {
        upLoadFile(
            file: File(pickedFile.path),
            senderId: senderId,
            recieverId: recieverId);
      }
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  cancel() {
    state = state.copyWith(message: "", isLoading: false);
  }
}
