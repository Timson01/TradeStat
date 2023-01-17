
import 'package:equatable/equatable.dart';

const String dealTable = 'deal_table';

class dealFields {
  static final List<String> values = [
    /// Add all fields
    id, tickerName, description, dateCreated, hashtag, amount, numberOfStocks
  ];

  static const String id = 'id';
  static const String tickerName = 'tickerName';
  static const String description = 'description';
  static const String title = 'title';
  static const String dateCreated = 'dateCreated';
  static const String hashtag = 'hashtag';
  static const String amount = 'amount';
  static const String income = 'income';
  static const String numberOfStocks = 'numberOfStocks';
}

class Deal extends Equatable {

  final int? id;
  final String tickerName;
  String description;
  final int dateCreated;
  String hashtag;
  double amount;
  double income;
  int numberOfStocks;

  Deal({
    this.id,
    required this.tickerName,
    this.description = 'You didn\'t put anything here',
    required this.dateCreated,
    this.hashtag = 'You didn\'t put anything here',
    this.amount = 0.0,
    this.income = 0.0,
    this.numberOfStocks = 0,
  });


  @override
  // TODO: implement props
  List<Object?> get props => [
    id,tickerName,description,dateCreated,hashtag,amount,income,numberOfStocks,
  ];

  Deal copyWith({
    int? id,
    String? tickerName,
    String? description,
    int? dateCreated,
    String? hashtag,
    double? amount,
    double? income,
    int? numberOfStocks,
  }) {
    return Deal(
      id: id ?? this.id,
      tickerName: tickerName ?? this.tickerName,
      description: description ?? this.description,
      dateCreated: dateCreated ?? this.dateCreated,
      hashtag: hashtag ?? this.hashtag,
      amount: amount ?? this.amount,
      income: income ?? this.income,
      numberOfStocks: numberOfStocks ?? this.numberOfStocks,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'tickerName': this.tickerName,
      'description': this.description,
      'dateCreated': this.dateCreated,
      'hashtag': this.hashtag,
      'amount': this.amount,
      'income': this.income,
      'numberOfStocks': this.numberOfStocks,
    };
  }

  factory Deal.fromMap(Map<String, dynamic> map) {
    return Deal(
      id: map['id'] as int,
      tickerName: map['tickerName'] as String,
      description: map['description'] as String,
      dateCreated: map['dateCreated'] as int,
      hashtag: map['hashtag'] as String,
      amount: map['amount'] as double,
      income: map['income'] as double,
      numberOfStocks: map['numberOfStocks'] as int,
    );
  }

  static Deal fromJson(Map<String, Object?> json) => Deal(
    id: json['id'] as int,
    tickerName: json['tickerName'] as String,
    description: json['description'] as String,
    dateCreated: json['dateCreated'] as int,
    hashtag: json['hashtag'] as String,
    amount: json['amount'] as double,
    income: json['income'] as double,
    numberOfStocks: json['numberOfStocks'] as int,
  );

  Map<String, Object?> toJson() => {
    'id': this.id,
    'tickerName': this.tickerName,
    'description': this.description,
    'dateCreated': this.dateCreated,
    'hashtag': this.hashtag,
    'amount': this.amount,
    'income': this.income,
    'numberOfStocks': this.numberOfStocks,
  };

}