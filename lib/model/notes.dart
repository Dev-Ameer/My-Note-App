//import 'dart:ffi';

class Notes {
  int _id;
  String _titel, _detals;
  int _imp;

  Notes(dynamic obj) {
    _id = obj['id'];
    _titel = obj['titel'];
    _detals = obj['detals'];
    _imp = obj['import'];
  }
  Notes.fromMap(Map<String, dynamic> data) {
    _id = data['id'];
    _titel = data['titel'];
    _detals = data['detals'];
    _imp = data['import'];
  }
  Map<String, dynamic> toMap() =>
      {'id': _id, 'titel': _titel, 'detals': _detals, 'import': _imp};
  int get id => _id;
  String get titel => _titel;
  String get detals => _detals;
  int get import => _imp;
  void set import(int import) {
    this.import = import;
  }
}
