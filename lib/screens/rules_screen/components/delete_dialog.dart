import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../blocs/bloc_exports.dart';
import '../../../generated/locale_keys.g.dart';
import '../../../models/rule.dart';
import '../../../styles/style_exports.dart';

class DeleteDialog extends StatefulWidget {
  Rule rule;
  DeleteDialog({Key? key, required this.rule}) : super(key: key);

  @override
  State<DeleteDialog> createState() => _DeleteDialogState();
}

class _DeleteDialogState extends State<DeleteDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        context.locale == Locale('ru') ? 'Вы уверены, что хотите удалить ${widget.rule.ruleName}?'
            : 'Do you want to delete ${widget.rule.ruleName}?',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headline5?.copyWith(
          letterSpacing: 0,
          fontSize: 16,
        ),
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: Text(
                LocaleKeys.cancel.tr(),
                style: Theme.of(context).textTheme.subtitle2?.copyWith(
                    fontSize: 15, color: colorBlue,
                    letterSpacing: context.locale == Locale('ru') ? 0 : 1
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: Text(
                LocaleKeys.delete.tr(),
                style: Theme.of(context).textTheme.subtitle2?.copyWith(
                    fontSize: 15, color: colorBlue,
                    letterSpacing: context.locale == Locale('ru') ? 0 : 1
                ),
              ),
              onPressed: () {
                setState(() {
                  context.read<RulesBloc>().add(DeleteRule(id: widget.rule.id!));
                });
                Navigator.pop(context);
              },
            ),
          ],
        )
      ],
    );
  }
}
