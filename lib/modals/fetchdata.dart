class DispData {

  final String breed , gender, description, name, location, status, days,area;
  final String userName;
  final int phone,age,pin;
  final bool neutered;
  final dynamic userId;
  final dynamic uid;
  final dynamic imgUrl;
  final dynamic imgUrl1;
  final dynamic imgUrl2;
  final dynamic dateTime;

  DispData({
    this.breed, this.gender, this.description,
    this.name, this.phone, this.location,this.age,this.days,
    this.area,this.pin, this.neutered,
    this.status, this.userId, this.uid, this.imgUrl,
    this.imgUrl1, this.imgUrl2,this.userName, this.dateTime
  });
}

class UserName {
  final String userName;
  final dynamic userUid;

  UserName({this.userName, this.userUid});
}

class DisplayUserName {
  final String userName;
  final dynamic userUid;

  DisplayUserName({this.userName, this.userUid});
}
