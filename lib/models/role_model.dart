class Role {
  int? id;
  int accessFlags;

  Role({
    required this.id,
    required this.accessFlags,
  });

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      id: json['roleId'] ?? 0,
      accessFlags: json['accessFlags'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      //'roleId': id,
      'accessFlags': accessFlags,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      //'roleId': this.id,
      'accessFlags': this.accessFlags,
    };
  }
}
