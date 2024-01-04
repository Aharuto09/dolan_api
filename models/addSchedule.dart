class AddSchedule {
  const AddSchedule(
      {this.id = 0,
      required this.date,
      required this.time,
      required this.location,
      required this.address,
      required this.id_group,
      required this.minMember});

  final String location, address, date, time;

  final int minMember, id, id_group;

  Map<String, Object> get toJson {
    return {
      'date': this.date,
      'time': this.time,
      'loc': this.location,
      'address': this.address,
      'id_group': this.id_group,
      'min_member': this.minMember
    };
  }

  String get value {
    return "'${this.date}','${this.time}', '${this.location}', '${this.address}', '${this.id_group}', '${this.minMember}'";
  }

  String get keys {
    return 'date_for, time_for, loc, address, id_group, min_member';
  }
}

AddSchedule toAddSchedule(List<dynamic> item) {
  // print(item);
  return AddSchedule(
      date: item[1].toString(),
      time: item[2].toString(),
      location: item[3].toString(),
      address: item[4].toString(),
      id_group: item[5] as int,
      minMember: item[6] as int);
}
