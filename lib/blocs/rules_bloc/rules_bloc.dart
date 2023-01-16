import 'dart:async';


import 'package:equatable/equatable.dart';
import 'package:trade_stat/blocs/bloc_exports.dart';

import '../../models/rule.dart';
import '../../repository/rules_repository.dart';

part 'rules_event.dart';
part 'rules_state.dart';

class RulesBloc extends HydratedBloc<RulesEvent, RulesState> {
  final RulesRepository rulesRepository;
  
  RulesBloc({required this.rulesRepository}) : super(RulesInitial()) {
    
    on<AddRule>(_onAddRule);
    on<DeleteRule>(_onDeleteRule);
    on<UpdateRule>(_onUpdateRule);
    on<FetchRules>(_onFetchRules);
    
  }

  @override
  RulesState? fromJson(Map<String, dynamic> json) {
    try{
      return RulesLoaded.fromMap(json);
    } catch(_){
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(RulesState state) {
    if(state is RulesLoaded){
      return state.toMap();
    }else{
      return null;
    }
  }

  FutureOr<void> _onDeleteRule(DeleteRule event, Emitter<RulesState> emit) async {
    await rulesRepository.deleteRule(id: event.id);
    add(const FetchRules());
  }

  FutureOr<void> _onUpdateRule(UpdateRule event, Emitter<RulesState> emit) async {
    await rulesRepository.updateRule(event.rule);
    add(const FetchRules());
  }

  FutureOr<void> _onFetchRules(FetchRules event, Emitter<RulesState> emit) async {
    final List<Rule> rules = await rulesRepository.getRules();
    emit(RulesLoaded(rules: rules));
  }

  FutureOr<void> _onAddRule(AddRule event, Emitter<RulesState> emit) async {
    await rulesRepository.addRule(event.rule);
    add(const FetchRules());
  }
}
