import 'dart:typed_data';

class File_Data_Model {
  String name;
  String mime;
  Uint8List bytes;
  String size;

  File_Data_Model({this.name, this.mime, this.bytes, this.size});
}
