import 'dart:io';

import 'dart:typed_data';

class LinkItem {
  final  Future<Uint8List> image;
  final String name;

  LinkItem({this.name, this.image});

  LinkItem.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        image = json['image'];

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
    };
  }
  
}
dynamic myDateSerializer(dynamic object) {
  if (object is File) {
    return object.readAsBytes();
  }
  return object;
}