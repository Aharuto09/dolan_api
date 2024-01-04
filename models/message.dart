class Message {
  const Message(
      {required this.sender_name,
      required this.content,
      required this.date,
      required this.time,
      required this.id_group});

  final String sender_name, content, date, time;
  final int id_group;

  Map<String, Object> get toJson {
    return {
      'name_sender': sender_name,
      'content': content,
      'create_date': date,
      'create_time': time,
      'id_group': id_group
    };
  }
}

Message toMessage(List<dynamic> item) {
  // print(item);
  return Message(
      content: item[0].toString(),
      date: item[1].toString(),
      time: item[2].toString(),
      sender_name: item[3].toString(),
      id_group: item[4] as int);
}
