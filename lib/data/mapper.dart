

import 'package:responsive/app/constant.dart';
import 'package:responsive/data/respones/responses.dart';

import '../domain/models/models.dart';
import 'package:responsive/app/extension.dart';

import 'network/app_api.dart';

extension CustomerResponseMapper on CustomerResponse? {
  Customer toDomain() {
    return Customer(
        this?.id.orEmpty() ?? Constant.empty,
        this?.name.orEmpty() ?? Constant.empty,
        this?.numOfNotifications.orZero() ?? Constant.zero);
  }
}

extension ContactsResponseMapper on ContactsResponse? {
  Contacts toDomain() {
    return Contacts(
        this?.phone.orEmpty() ?? Constant.empty,
        this?.email.orEmpty() ?? Constant.empty,
        this?.link.orEmpty() ?? Constant.empty);
  }
}

extension AuthenticationResponseMapper on AuthenticationResponse? {
  Authentication toDomain() {
    return Authentication(this?.customer.toDomain(), this?.contacts.toDomain());
  }
}
