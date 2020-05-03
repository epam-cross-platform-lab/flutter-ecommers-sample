class ShippingValidator{

  static bool isValidFullName(String fullName) =>
      fullName != null && fullName.length > 3;

  static bool isValidAddress(String address) =>
      address != null && address.length > 2;

  static bool isValidCity(String city) =>
      city != null && city.length > 2;

  static bool isValidState(String state) =>
      state != null && state.length > 3;

  static bool isValidZipCode(String zipCode) =>
      zipCode != null && zipCode.length > 2;
  
  static bool  isValidCountry(String country) => 
      country != null && country.length > 3;
}