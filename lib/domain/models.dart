class SliderObject {
  String title;
  String subTitle;
  String image;
  SliderObject(this.title, this.subTitle, this.image);
}

class SliderViewObject {
  SliderObject sliderObject;
  int numSlides;
  int currentIndex;
  SliderViewObject(this.sliderObject, this.currentIndex, this.numSlides);
}

// -- Login Model
class Customer {
  String id;
  String name;
  int numOfNotifications;
  Customer(this.id, this.name, this.numOfNotifications);
}

class Contacts {
  String phone;
  String email;
  String link;
  Contacts(this.phone, this.email, this.link);
}

class Authentication {
  Customer? customer;
  Contacts? contacts;
  Authentication(this.customer, this.contacts);
}

// -- ForgetPasswordModel --

class ForgetPassword {
  String support;
  ForgetPassword(this.support);
}

// -- HomeModels --

class Services {
  int id;

  String title;

  String image;

  Services(this.id, this.title, this.image);
}

class BannersAdd {
  int id;

  String link;

  String title;

  String image;

  BannersAdd(this.id, this.link, this.title, this.image);
}

class Stores {
  int id;

  String title;

  String image;

  Stores(this.id, this.title, this.image);
}

class HomeData {
  List<Services> services;

  List<BannersAdd> bannersAdd;

  List<Stores> stores;

  HomeData(this.services, this.bannersAdd, this.stores);
}

class HomeObject {
  HomeData? data;
  HomeObject(this.data);
}

// -- StoreDetails Models --
class StoreDetails {
  String image;

  int id;

  String title;

  String details;

  String services;

  String about;

  StoreDetails(
      this.image, this.id, this.title, this.details, this.services, this.about);
}
