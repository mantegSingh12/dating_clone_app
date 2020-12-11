class User {
  final String name;
  final String designation;
  final int age;
  final String imgUrl;
  final String bio;
  final String location;
  bool isLiked;
  bool isSwipedOff;

  User(
      {this.name,
      this.designation,
      this.age,
      this.imgUrl,
      this.bio,
      this.location,
      this.isLiked = false,
      this.isSwipedOff = false});
}
