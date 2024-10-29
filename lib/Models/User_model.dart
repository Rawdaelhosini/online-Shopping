//for show data profile

class UserModel {
  String? name;
  String? email;
  String? phone;
  String? image;
  String? token;

//constructor
  UserModel(this.name,this.email,this.phone,this.image,this.token);

  //Named Constructor
  UserModel.fromJson({required Map<String,dynamic> data}){
    //Refactoring Map | Json
     name = data['name'];
     email = data['email'];
     phone = data['phone'];
     image = data['image'];
     token = data['token'];
     
  }

  // to map
  Map<String,dynamic> toMap(){
    return {
      'name' :name,
      'email' :email,
      'phone' :phone,
      'image' :image,
      'token' :token,
    };
  }



}