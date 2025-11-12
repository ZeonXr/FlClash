import 'package:fl_clash/widgets/scaffold.dart';
import 'package:flutter/material.dart';

class AddedRulesView extends StatefulWidget {
  const AddedRulesView({super.key});

  @override
  State<AddedRulesView> createState() => _AddedRulesViewState();
}

class _AddedRulesViewState extends State<AddedRulesView> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(title: '追加规则', body: Container());
  }
}
