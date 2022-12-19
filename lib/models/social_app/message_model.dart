class MessageModel {
  String? senderId;
  String? receiverId;
  String? dateTime;
  String? text;


  //constructor
  MessageModel({
    this.receiverId,
    this.senderId,
    this.dateTime,
    this.text,

  });

  //named constructor
  MessageModel.fromJson(Map<String, dynamic> json) {
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    dateTime = json['dateTime'];
    text = json['text'];

  }

  //toMap method
  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'dateTime': dateTime,
      'text': text,
    };
  }
}
