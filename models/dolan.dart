class Dolan {
  const Dolan({
    required this.id,
    required this.name,
    required this.min_member,
  });
  final int id, min_member;
  final String name;

  Map<String, dynamic> get toJson {
    return {"name": this.name, "min_member": this.min_member};
  }
}

Dolan toDolan(List<dynamic> item) {
  // print(item);
  return Dolan(
    id: item[0] as int,
    name: item[1] as String,
    min_member: item[2] as int,
  );
}
