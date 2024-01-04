class Join {
  const Join({
    required this.id,
    required this.id_user,
    required this.id_group,
  });
  final int id, id_user, id_group;

  Map<String, dynamic> get toJson {
    return {"id": this.id, "id_user": this.id_user, "id_group": this.id_group};
  }
}

Join toUser(List<dynamic> item) {
  // print(item);
  return Join(
      id: item[0] as int, id_user: item[1] as int, id_group: item[2] as int);
}
