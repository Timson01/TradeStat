import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ChartsModel extends Equatable{

  String name;
  final String position;
  final DateTimeRange dateTimeRange;

  ChartsModel({
    this.name = '',
    required this.position,
    required this.dateTimeRange
  });

  @override
  // TODO: implement props
  List<Object?> get props => [name, position, dateTimeRange];

}