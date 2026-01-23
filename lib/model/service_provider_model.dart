class ServiceProvider {
  final String id;
  final String profileImage;
  final String username;
  final String phone;

  ServiceProvider({
    required this.id,
    required this.profileImage,
    required this.username,
    required this.phone,
  });

  factory ServiceProvider.fromJson(String id, Map<String, dynamic> json) {
    return ServiceProvider(
      id: id,
      profileImage: json["profileImage"] ?? "",
      username: json["username"] ?? "Agent",
      phone: json["phone"] ?? "",
    );
  }
}
