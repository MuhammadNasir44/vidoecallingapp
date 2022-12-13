class Conversation{
  String? messageText;
  String? sentAt;
  bool? isMessageRead;
  String? sender;

  Conversation({this.sentAt,this.isMessageRead,this.messageText,this.sender});

  Conversation.formJson(json, id){
    this.messageText = json['messageText'];
    this.sentAt = json['sentAt'];
    this.isMessageRead = json['isMessageRead'];
    this.sender = json['sender'];
  }

  toJson(){
    return {
      'messageText' : this.messageText,
      'sentAt' : this.sentAt,
      'isMessageRead' : this.isMessageRead,
      'sender' : this.sender,
    };
  }

}