// onboarding models


class SliderObject {
  String title;
  String subTitle;
  String image;

  SliderObject(this.title, this.subTitle, this.image);
}

class SliderViewObject {
  SliderObject sliderObject;
  int numOfSlides;
  int currentIndex;

  SliderViewObject(this.sliderObject, this.numOfSlides, this.currentIndex);
}

// login models

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

//login state model
class LoginStateModel {
  final bool isPasswordValid;
  final bool isUsernameValid;
  final bool isPasswordAndUserNameValid;
  final bool isUserSuccessfulLogin;

  LoginStateModel(this.isPasswordValid, this.isUsernameValid,
      this.isPasswordAndUserNameValid,this.isUserSuccessfulLogin,);

  LoginStateModel copyWith({bool? isPasswordValid,
    bool? isUsernameValid,
    bool? isPasswordAndUserNameValid,
    bool? isUserSuccessfulLogin,


  }) {
    return LoginStateModel(
        isPasswordValid ?? this.isPasswordValid,
        isUsernameValid ?? this.isUsernameValid,
        isPasswordAndUserNameValid ??this.isPasswordAndUserNameValid,
      isUserSuccessfulLogin ??this.isUserSuccessfulLogin,


    );
  }
}
