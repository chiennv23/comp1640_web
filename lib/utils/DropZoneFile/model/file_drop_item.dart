import 'dart:typed_data';

class File_Data_Model {
  final String name;
  final String mime;
  final Uint8List bytes;
  final String url;

  File_Data_Model({this.name, this.mime, this.bytes, this.url});

}
