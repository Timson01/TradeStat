part of 'rules_bloc.dart';

abstract class RulesState extends Equatable {
  const RulesState();

  @override
  List<Object> get props => [];
}

class RulesInitial extends RulesState {}

class RulesLoaded extends RulesState {
  List<Rule> rules;

  RulesLoaded({
    required this.rules
  });

  Map<String, dynamic> toMap() {
    return {
      'rules': rules,
    };
  }

  factory RulesLoaded.fromMap(Map<String, dynamic> map) {
    return RulesLoaded(
      rules:
      List<Rule>.from(map['rules']),
    );
  }

  @override
  List<Object> get props => [ rules ];
}
