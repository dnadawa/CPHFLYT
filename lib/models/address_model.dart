class AddressModel {
  final String _address;
  final String _postalCode;
  final String _by;

  AddressModel(this._address, this._postalCode, this._by);

  getAddressAsString(){
      return "Adresse - $_address\n"
      "Postnummer - $_postalCode\n"
      "By - $_by";
  }

}