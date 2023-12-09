class Message {
  String text;
  bool isLeft;
  int initbox;
  int box;
  String boxString;
  bool _isStarSelected;
  bool showTimestampAndShareIcon;
  bool showUserNameAndPhoto;

  final DateTime createdAt;

  Message(
    this.text,
    this.isLeft,
    this.initbox,
    this.box,
    this.boxString, {
    bool isStarSelected = false,
    // 새로운 속성들의 기본값 설정
    this.showTimestampAndShareIcon = true,
    this.showUserNameAndPhoto = true,
  })  : _isStarSelected = isStarSelected,
        createdAt = DateTime.now();

  String getCreatedAtString() {
    final hour = createdAt.hour >= 12 ? createdAt.hour - 12 : createdAt.hour;
    final min = createdAt.minute;
    final timeOfDay = createdAt.hour >= 12 ? '오후' : '오전';
    return '$timeOfDay ${(hour < 10) ? '0$hour' : hour}:${(min < 10) ? '0$min' : min}';
  }
}

class user {
  String name;
  String id;
  String password;

  user(this.id, this.name, this.password);
}
