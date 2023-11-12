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
      id : json['id'],
      name: json['name'],
      description: json['description'],
      cost: json['cost'].toDouble()
    );
  }
}
