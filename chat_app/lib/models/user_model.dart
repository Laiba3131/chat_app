class UserModel{
  String? userName;
  String? fullName;
  String? email;
  String? profilePic;

  UserModel({this.userName, this.fullName, this.email, this.profilePic});
// map contructor 
  UserModel.fromMap(Map<String , dynamic> map)
  {
    userName = map["userName"];
     fullName = map["fullName"];
      email = map["email"];
       profilePic = map["profilePic"];

  }

  Map<String , dynamic>  toMap()
  {
    return {
     "userName" : userName,
     "fullName" : fullName,
     "email" : email,
     "profilePic" : profilePic
    };
  }
}