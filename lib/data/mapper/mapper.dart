import 'package:flutter_clean_arch_revision2/app/constants.dart';
import 'package:flutter_clean_arch_revision2/data/response/response.dart';
import 'package:flutter_clean_arch_revision2/domain/models.dart';
import 'package:flutter_clean_arch_revision2/app/extintion.dart';

extension CustomerResponseMapper on CustomerResponse? {
  Customer toDomain() {
    return Customer(
      this?.id.orEmpty() ?? Constants.empty,
      this?.name.orEmpty() ?? Constants.empty,
      this?.numOfNotifications.orZero() ?? Constants.zero,
    );
  }
}

extension ContactsResponseMapper on ContactsResponse? {
  Contacts toDomain() {
    return Contacts(
      this?.phone.orEmpty() ?? Constants.empty,
      this?.email.orEmpty() ?? Constants.empty,
      this?.link.orEmpty() ?? Constants.empty,
    );
  }
}

extension AuthenticationResponseMapper on AuthenticationResponse? {
  Authentication toDomain() {
    return Authentication(
      this?.customer.toDomain(),
      this?.contacts.toDomain(),
    );
  }
}

extension ForgetPasswordResponseMapper on ForgetPasswordResponse? {
  ForgetPassword toDomain() {
    return ForgetPassword(this?.support.orEmpty() ?? Constants.empty);
  }
}

extension ServicesResponseMapper on ServicesResponse? {
  Services toDmain() {
    return Services(
      this?.id.orZero() ?? Constants.zero,
      this?.title.orEmpty() ?? Constants.empty,
      this?.image.orEmpty() ?? Constants.empty,
    );
  }
}

extension BannersResponseMapper on BannersResponse? {
  BannersAdd toDmain() {
    return BannersAdd(
      this?.id.orZero() ?? Constants.zero,
      this?.link.orEmpty() ?? Constants.empty,
      this?.title.orEmpty() ?? Constants.empty,
      this?.image.orEmpty() ?? Constants.empty,
    );
  }
}

extension StoresResponseMapper on StoresResponse? {
  Stores toDmain() {
    return Stores(
      this?.id.orZero() ?? Constants.zero,
      this?.title.orEmpty() ?? Constants.empty,
      this?.image.orEmpty() ?? Constants.empty,
    );
  }
}

extension HomeResponseMapper on HomeResponse? {
  HomeObject toDomain() {
    List<Services> services = (this
                ?.data
                ?.services
                ?.map((servicesResponse) => servicesResponse.toDmain()) ??
            const Iterable.empty())
        .cast<Services>()
        .toList();

    List<BannersAdd> bannersAdd = (this
                ?.data
                ?.banners
                ?.map((storesResponse) => storesResponse.toDmain()) ??
            const Iterable.empty())
        .cast<BannersAdd>()
        .toList();

    List<Stores> stores = (this
                ?.data
                ?.stores
                ?.map((storesResponse) => storesResponse.toDmain()) ??
            const Iterable.empty())
        .cast<Stores>()
        .toList();
    var data = HomeData(services, bannersAdd, stores);
    return HomeObject(data);
  }
}

extension StoreDetailsResponseMapper on StoreDetailsResponse? {
  StoreDetails toDomain() {
    return StoreDetails(
      this?.image.orEmpty() ?? Constants.empty,
      this?.id.orZero() ?? Constants.zero,
      this?.title.orEmpty() ?? Constants.empty,
      this?.details.orEmpty() ?? Constants.empty,
      this?.services.orEmpty() ?? Constants.empty,
      this?.about.orEmpty() ?? Constants.empty,
    );
  }
}
