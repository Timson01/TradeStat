part of 'rules_bloc.dart';

abstract class RulesEvent extends Equatable {

  const RulesEvent();

  @override
  List<Object> get props => [];

}

// ------ AddRule event --------

class AddRule extends RulesEvent {
  final Rule rule;

  const AddRule({
    required this.rule});

  @override
  List<Object> get props =>
      [
        rule
      ];
}

// ------ AddRule event --------

class UpdateRule extends RulesEvent {
  final Rule rule;

  const UpdateRule({
    required this.rule});

  @override
  List<Object> get props =>
      [
        rule
      ];
}

// ------ DeleteRule event --------

class DeleteRule extends RulesEvent {
  final int id;

  const DeleteRule({
    required this.id});

  @override
  List<Object> get props =>
      [
        id
      ];
}

// ------ FetchRules event --------

class FetchRules extends RulesEvent {
  const FetchRules();

  @override
  List<Object> get props => [];
}