class BannerModel {
  int? id;
  String? url;

  //Refactoring data for api
  BannerModel.fromjson({required Map<String,dynamic>data}){
    id= data['id'];
    url= data['image'];
  }
}