class Disciplina {
  final String id;
  final String name;
  final String code;
  final String status;
  final String icon;
  final String id_escola;

  const Disciplina(
      {required this.id,
      required this.name,
      required this.code,
      required this.status,
      required this.icon,
      required this.id_escola});

  factory Disciplina.fromJson(Map<String, dynamic> json) {
    return Disciplina(
        id: json['id'] ?? '',
        name: json['name'] ?? '',
        code: json['code'] ?? '',
        status: json['status'] ?? '',
        icon: json['icon'] ?? '',
        id_escola: json['id_escola'] ?? '');
  }
}
