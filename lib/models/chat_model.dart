class ChatModel {
  int? id;
  String? name;
  String? icon;
  bool isGroup;
  String? time;
  String? currentMessage;
  String? status;
  bool select = false;
  ChatModel(
      {this.id,
      this.name,
      this.icon,
      this.isGroup = false,
      this.time,
      this.currentMessage,
      this.status,
      this.select = false});
}
