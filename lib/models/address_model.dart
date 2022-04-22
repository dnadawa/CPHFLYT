class AddressModel {
  final String _address;
  final String _postalCode;
  final String _by;

  AddressModel(this._address, this._postalCode, this._by);


  String get address {
    return _address;
  }

  String get zip {
    return _postalCode;
  }

  String get by {
    return _by;
  }

  String getAddressAsString(){
      return "Adresse - $_address\n"
      "Postnummer - $_postalCode\n"
      "By - $_by";
  }

}