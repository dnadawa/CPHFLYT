class Document {
  final String _id;
  final Map _data;

  Document(this._id, this._data);

  String get id{
    return _id;
  }

  Map get data{
    return _data;
  }
}