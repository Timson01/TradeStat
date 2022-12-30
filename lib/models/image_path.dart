
import 'package:equatable/equatable.dart';

const String dealImagesTable = 'deal_images_table';

class DealImage extends Equatable {

  final int? id;
  String? imagePath;
  int? deal_id;

  DealImage({
    this.id,
    this.imagePath,
    this.deal_id
  });


  @override
  // TODO: implement props
  List<Object?> get props => [
    id,imagePath,deal_id
  ];

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'imagePath': this.imagePath,
      'deal_id': this.deal_id,
    };
  }

  factory DealImage.fromMap(Map<String, dynamic> map) {
    return DealImage(
      id: map['id'] as int,
      imagePath: map['imagePath'] as String,
      deal_id: map['deal_id'] as int,
    );
  }

  DealImage copyWith({
    int? id,
    String? imagePath,
    int? deal_id,
  }) {
    return DealImage(
      id: id ?? this.id,
      imagePath: imagePath ?? this.imagePath,
      deal_id: deal_id ?? this.deal_id,
    );
  }
}