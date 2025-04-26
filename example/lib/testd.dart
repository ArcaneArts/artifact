// This is the crud model that holds the data really
class CrudModel {
  final String collection;
  final String? exclusive;
  final Type model;

  const CrudModel(this.collection, this.model, {this.exclusive});
}
