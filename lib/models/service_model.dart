class Service {
  final double cost;
  final String name;
  final String description;
  final int id;

  Service({
    required this.cost,
    required this.name,
    required this.description,
    required this.id
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      cost: json['cost'].toDouble(),
      name: json['name'],
      description: json['description'],
      id : json['id']
    );
  }
}
