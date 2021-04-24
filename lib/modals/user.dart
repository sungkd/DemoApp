class UserData {
  final String uid;
  final String email;

  UserData({ this.uid , this.email});

}

class UploadData1 {

  final String uid;
  final String breed;
  final String gender;
  final String description;
  final String name;
  final String location;
  final String status;
  final int phone;
  final dynamic userId;
  final dynamic imgUrl;

  //UploadData1({this.uid, this.breed,this.gender,this.description,this.name,this.phone,
  UploadData1({this.uid, this.breed,this.gender,this.description,this.name,this.phone,
    this.location,this.status, this.userId, this.imgUrl});
}


class GetUidOfDocument {

  final String breed, gender, description, name, location, status;
  final int phone;
  final dynamic userId;
  final dynamic uid;
  final dynamic imgUrl;


  GetUidOfDocument({this.breed, this.gender, this.description, this.name,
    this.location, this.status, this.phone, this.userId, this.uid,
    this.imgUrl});

}