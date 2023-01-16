import 'package:equatable/equatable.dart';

const String ruleTable = 'rule_table';

class RuleFields {
  static final List<String> values = [
    /// Add all fields
    id, ruleName, description, ruleColor
  ];

  static const String id = 'id';
  static const String ruleName = 'ruleName';
  static const String description = 'description';
  static const String ruleColor = 'ruleColor';
}

class Rule extends Equatable {

  final int? id;
  final String ruleName;
  String description;
  int ruleColor;

  Rule({
    this.id,
    required this.ruleName,
    this.description = 'You didn\'t put anything here',
    this.ruleColor = 1,
  });


  @override
  // TODO: implement props
  List<Object?> get props => [
    id,ruleName,description,ruleColor
  ];

  Rule copyWith({
    int? id,
    String? ruleName,
    String? description,
    int? ruleColor,
  }) {
    return Rule(
      id: id ?? this.id,
      ruleName: ruleName ?? this.ruleName,
      description: description ?? this.description,
      ruleColor: ruleColor ?? this.ruleColor,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ruleName': ruleName,
      'description': description,
      'ruleColor': ruleColor,
    };
  }

  factory Rule.fromMap(Map<String, dynamic> map) {
    return Rule(
      id: map['id'] as int,
      ruleName: map['ruleName'] as String,
      description: map['description'] as String,
      ruleColor: map['ruleColor'] as int,
    );
  }

  static Rule fromJson(Map<String, Object?> json) => Rule(
    id: json['id'] as int,
    ruleName: json['ruleName'] as String,
    description: json['description'] as String,
    ruleColor: json['ruleColor'] as int,
  );

  Map<String, Object?> toJson() => {
    'id': id,
    'ruleName': ruleName,
    'description': description,
    'ruleColor': ruleColor,
  };

}