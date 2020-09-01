

class MessageModel{
  final String userId, userChatId, name, image;
  String lastMessage;
  final int unreadMessagesCount;

  MessageModel({
    this.userId,
    this.name,
    this.image,
    this.unreadMessagesCount,
    this.userChatId,
    this.lastMessage
  });
}