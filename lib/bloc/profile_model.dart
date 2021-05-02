class ProfileModel {
  final int creationTime;
  final String description;
  final int id;
  final String image;
  final String location;
  final String ownerEmail;
  final String ownerName;
  final String ownerPN;
  final String petName;
  final String userId;
  final List<String> hashtags;

  ProfileModel(
      {this.creationTime,
      this.description,
      this.id,
      this.image,
      this.location,
      this.ownerEmail,
      this.ownerName,
      this.ownerPN,
      this.petName,
      this.userId,
      this.hashtags});

  factory ProfileModel.fromJson(dynamic json) {
    return ProfileModel(
        creationTime: json["creationTime"],
        description: json["description"],
        id: json["id"],
        image: json["image"],
        location: json["location"],
        ownerEmail: json["ownerEmail"],
        ownerName: json["ownerName"],
        ownerPN: json["ownerPN"],
        petName: json["petName"],
        userId: json["userId"],
        hashtags: json['hashtags'] ?? []);
  }
}
