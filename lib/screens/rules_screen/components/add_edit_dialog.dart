import 'package:flutter/material.dart';
import 'package:trade_stat/blocs/bloc_exports.dart';

import '../../../models/rule.dart';
import '../../../styles/style_exports.dart';

class AddEditDialog extends StatefulWidget {
  Rule rule;

  AddEditDialog({Key? key, required this.rule}) : super(key: key);

  @override
  State<AddEditDialog> createState() => _AddEditDialogState();
}

class _AddEditDialogState extends State<AddEditDialog> {
  bool doItJustOnce = false;
  bool ruleTitleState = false;
  int ruleColor = 0;
  bool addRule = false;
  bool isRedButton = false;
  bool isYellowButton = false;
  bool isGreenButton = false;
  bool isPurpleButton = false;

  TextEditingController ruleTitleController = TextEditingController();
  TextEditingController ruleDescriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    ruleTitleController.dispose();
    ruleDescriptionController.dispose();
    super.dispose();
  }

  String? get _errorText {
    final text = ruleTitleController.value.text;
    if (text.isEmpty) {
      return 'Can\'t be empty';
    }
    // return null if the text is valid
    return null;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.rule.description == '_') {
      addRule = true;
    } else {
      if (!doItJustOnce) {
        ruleTitleController.text = widget.rule.ruleName;
        ruleDescriptionController.text = widget.rule.description;
        ruleColor = widget.rule.ruleColor;
        switch (ruleColor) {
          case 0:
            isRedButton = true;
            break;
          case 1:
            isYellowButton = true;
            break;
          case 2:
            isGreenButton = true;
            break;
          case 3:
            isPurpleButton = true;
            break;
        }
        doItJustOnce = !doItJustOnce;
      }
    }
    return SingleChildScrollView(
      child: AlertDialog(
        title: Text(
          addRule ? 'Add a new Rule' : 'Edit your Rule',
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .headline5
              ?.copyWith(letterSpacing: 0, fontSize: 16, color: colorBlue),
        ),
        content: SizedBox(
          height: 210,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: ruleTitleController,
                style: Theme.of(context).textTheme.subtitle2?.copyWith(
                    fontSize: 12, color: colorDarkGrey, letterSpacing: 1),
                decoration: InputDecoration(
                    errorText: ruleTitleState ? _errorText : null,
                    isDense: true,
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(width: 1, color: colorDarkGrey),
                    ),
                    hintText: 'Add a rule title',
                    hintStyle: Theme.of(context).textTheme.subtitle2?.copyWith(
                        fontSize: 12, color: colorDarkGrey, letterSpacing: 1)),
              ),
              const SizedBox(height: 20),
              Container(
                constraints: const BoxConstraints(maxHeight: 110),
                child: SingleChildScrollView(
                  child: TextField(
                    controller: ruleDescriptionController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    style: Theme.of(context).textTheme.subtitle2?.copyWith(
                        fontSize: 12, color: colorDarkGrey, letterSpacing: 1),
                    decoration: InputDecoration(
                        isDense: true,
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 8),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(width: 1, color: colorDarkGrey),
                        ),
                        hintText: 'Add a rule description',
                        hintStyle: Theme.of(context)
                            .textTheme
                            .subtitle2
                            ?.copyWith(
                                fontSize: 12,
                                color: colorDarkGrey,
                                letterSpacing: 1)),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        ruleColor = 0;
                        isRedButton = true;
                        isGreenButton = false;
                        isYellowButton = false;
                        isPurpleButton = false;
                      });
                    },
                    child: Container(
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                        color: colorRuleRed,
                        shape: BoxShape.circle,
                        border: isRedButton
                            ? Border.all(color: colorDarkGrey, width: 1)
                            : null,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        ruleColor = 1;
                        isRedButton = false;
                        isGreenButton = false;
                        isYellowButton = true;
                        isPurpleButton = false;
                      });
                    },
                    child: Container(
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                        color: colorRuleYellow,
                        shape: BoxShape.circle,
                        border: isYellowButton
                            ? Border.all(color: colorDarkGrey, width: 1)
                            : null,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        ruleColor = 2;
                        isRedButton = false;
                        isGreenButton = true;
                        isYellowButton = false;
                        isPurpleButton = false;
                      });
                    },
                    child: Container(
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                        color: colorRuleGreen,
                        shape: BoxShape.circle,
                        border: isGreenButton
                            ? Border.all(color: colorDarkGrey, width: 1)
                            : null,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        ruleColor = 3;
                        isRedButton = false;
                        isGreenButton = false;
                        isYellowButton = false;
                        isPurpleButton = true;
                      });
                    },
                    child: Container(
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                        color: colorRulePurple,
                        shape: BoxShape.circle,
                        border: isPurpleButton
                            ? Border.all(color: colorDarkGrey, width: 1)
                            : null,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              onPressed: ruleTitleController.text.isNotEmpty
                  ? () {
                      setState(() {
                        addRule
                            ? context.read<RulesBloc>().add(AddRule(
                                rule: Rule(
                                    ruleName: ruleTitleController.text,
                                    description:
                                        ruleDescriptionController.text == ''
                                            ? 'You didn\'t put anything here'
                                            : ruleDescriptionController.text,
                                    ruleColor: ruleColor)))
                            : context.read<RulesBloc>().add(UpdateRule(
                                rule: Rule(
                                    id: widget.rule.id,
                                    ruleName: ruleTitleController.text,
                                    description: ruleDescriptionController.text,
                                    ruleColor: ruleColor)));
                      });
                      Navigator.pop(context);
                    }
                  : () {
                      setState(() {
                        ruleTitleState = true;
                      });
                      return null;
                    },
              child: Text(
                'Save',
                style: Theme.of(context).textTheme.subtitle2?.copyWith(
                    fontSize: 15, color: colorBlue, letterSpacing: 1),
              )),
        ],
      ),
    );
  }
}
