import 'package:trade_stat/database_helper/database_helper.dart';

import '../models/rule.dart';

class RulesRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  Future<Rule> addRule(Rule rule) async {
    Rule response = await _databaseHelper.createRule(rule);
    return response;
  }

  Future<List<Rule>> getRules() async {
    List<Rule> rules = await _databaseHelper.readAllRules();
    return rules;
  }

  Future<int> updateRule(Rule rule) async {
    int response = await _databaseHelper.updateRule(rule: rule);
    return response;
  }

  Future<int> deleteRule({required int id}) async {
    int response = await _databaseHelper.deleteRule(id: id);
    return response;
  }
}