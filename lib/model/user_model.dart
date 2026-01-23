class AppUser {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String photoUrl;

  AppUser({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.photoUrl,
  });

  factory AppUser.fromMap(Map<String, dynamic> data, String id) {
    return AppUser(
      id: id,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      phone: data['phone'] ?? '',
      photoUrl: data['profileImage'] ?? '',
    );
  }
}
