class Service {
  final double cost;
  final String name;
  final String description;
  final int id;

  Service({
    required this.id,
    required this.name,
    required this.description,
    required this.cost
  });

 factory Service.fromJson(Map<String, dynamic> json) {
  return Service(
    id: json['id'],
    name: json['name'] ?? '',
    description: json['description'] ?? '',
    cost: json['cost'] != null ? json['cost'].toDouble() : 0.0,
  );
}

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'cost': cost
    };
  }
}
