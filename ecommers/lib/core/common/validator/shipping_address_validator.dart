class ShippingValidator{

  static bool isFullNameValid(String fullName) =>
      fullName != null && fullName.length > 3;

  static bool isAddressValid(String address) =>
      address != null && address.length > 2;

  static bool isCityValid(String city) =>
      city != null && city.length > 2;

  static bool isStateValid(String state) =>
      state != null && state.length > 3;

  static bool isZipCodeValid(String zipCode) =>
      zipCode != null && zipCode.length > 2;
  
  static bool  isCountryValid(String country) => 
      country != null && country.length > 3;
}