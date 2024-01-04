class Schedule {
  const Schedule(
      {this.id = 0,
      required this.date,
      required this.time,
      required this.location,
      required this.address,
      required this.group_name,
      required this.minMember});

  final String location, address, group_name, date, time;

  final int minMember, id;

  Map<String, Object> get toJson {
    return {
      'id': this.id,
      'date': this.date,
      'time': this.time,
      'loc': this.location,
      'address': this.address,
      'group_name': this.group_name,
      'min_member': this.minMember
    };
  }

  String get value {
    return "'${this.date}','${this.time}', '${this.location}', '${this.address}', '${this.group_name}', '${this.minMember}'";
  }

  String get keys {
    return 'date_for, time_for, loc, address, group_name, min_member';
  }
}

Schedule toSchedule(List<dynamic> item) {
  // print(item);
  return Schedule(
      id: item[0] as int,
      date: item[1].toString(),
      time: item[2].toString(),
      location: item[3].toString(),
      address: item[4].toString(),
      group_name: item[5].toString(),
      minMember: item[6] as int);
}
