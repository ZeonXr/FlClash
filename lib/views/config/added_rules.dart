import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/models/clash_config.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:fl_clash/state.dart';
import 'package:fl_clash/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddedRulesView extends ConsumerStatefulWidget {
  const AddedRulesView({super.key});

  @override
  ConsumerState<AddedRulesView> createState() => _AddedRulesViewState();
}

class _AddedRulesViewState extends ConsumerState<AddedRulesView> {
  @override
  void initState() {
    super.initState();
    globalState.appState = globalState.appState.copyWith(selectedRules: {});
  }

  Future<void> _handleAddOrUpdate([Rule? rule]) async {
    final res = await globalState.showCommonDialog<Rule>(
      child: _AddRuleDialog(rule: rule),
    );
    if (res == null) {
      return;
    }
    ref.read(rulesProvider.notifier).set(res);
  }

  void _handleSelect(String ruleId) {
    ref.read(selectedRulesProvider.notifier).update((selectedRules) {
      final newSelectedRules = Set<String>.from(selectedRules);
      if (newSelectedRules.contains(ruleId)) {
        newSelectedRules.remove(ruleId);
      } else {
        newSelectedRules.add(ruleId);
      }
      return newSelectedRules;
    });
  }

  Widget _buildItem({
    required Rule rule,
    required bool isSelected,
    required VoidCallback onTab,
    required BuildContext context,
  }) {
    return Material(
      color: Colors.transparent,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        child: CommonCard(
          padding: EdgeInsets.zero,
          radius: 18,
          type: CommonCardType.filled,
          isSelected: isSelected,
          onPressed: () {
            onTab();
          },
          child: ListTile(
            minTileHeight: 0,
            minVerticalPadding: 0,
            titleTextStyle: context.textTheme.bodyMedium?.toJetBrainsMono,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            trailing: SizedBox(
              width: 24,
              height: 24,
              child: CommonCheckBox(
                value: isSelected,
                isCircle: true,
                onChanged: (_) {
                  onTab();
                },
              ),
            ),
            title: Text(rule.value),
          ),
        ),
      ),
    );
  }

  void _handleSelectAll() {
    final ids = ref.read(rulesProvider).map((item) => item.id).toSet();
    ref.read(selectedRulesProvider.notifier).update((selected) {
      return selected.containsAll(ids) ? {} : ids;
    });
  }

  Future<void> _handleDelete() async {
    final res = await globalState.showMessage(
      title: appLocalizations.tip,
      message: TextSpan(
        text: appLocalizations.deleteMultipTip(appLocalizations.rule),
      ),
    );
    if (res != true) {
      return;
    }
    final selectedRules = ref.read(selectedRulesProvider);
    ref.read(rulesProvider.notifier).update((rules) {
      final newRules = List<Rule>.from(
        rules.where((item) => !selectedRules.contains(item.id)),
      );
      return newRules;
    });
    ref.read(selectedRulesProvider.notifier).value = {};
  }

  @override
  Widget build(BuildContext context) {
    final vm2 = ref.watch(addedRulesStateProvider);
    final selectedRules = vm2.a;
    final rules = vm2.b;
    return BaseScaffold(
      title: '附加规则',
      actions: [
        if (selectedRules.isNotEmpty) ...[
          IconButton.filledTonal(
            style: IconButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 8),
              visualDensity: VisualDensity.compact,
            ),
            onPressed: _handleDelete,
            icon: Icon(Icons.delete),
          ),
          SizedBox(width: 2),
        ],
        CommonFilledButtonTheme(
          child: selectedRules.isNotEmpty
              ? FilledButton(
                  onPressed: _handleSelectAll,
                  child: Text(appLocalizations.selectAll),
                )
              : FilledButton.tonal(
                  onPressed: () {
                    _handleAddOrUpdate();
                  },
                  child: Text(appLocalizations.add),
                ),
        ),
        SizedBox(width: 8),
      ],
      body: ReorderableList(
        padding: EdgeInsets.all(16),
        itemBuilder: (context, index) {
          final rule = rules[index];
          return ReorderableDelayedDragStartListener(
            key: ObjectKey(rule),
            index: index,
            child: _buildItem(
              rule: rule,
              isSelected: selectedRules.contains(rule.id),
              onTab: () {
                _handleSelect(rule.id);
              },
              context: context,
            ),
          );
        },
        itemCount: rules.length,
        onReorder: (int oldIndex, int newIndex) {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
          final newRules = List<Rule>.from(rules);
          final item = newRules.removeAt(oldIndex);
          newRules.insert(newIndex, item);
          ref.read(rulesProvider.notifier).value = newRules;
        },
      ),
    );
  }
}

class _AddRuleDialog extends StatefulWidget {
  final Rule? rule;

  const _AddRuleDialog({this.rule});

  @override
  State<_AddRuleDialog> createState() => _AddRuleDialogState();
}

class _AddRuleDialogState extends State<_AddRuleDialog> {
  late RuleAction _ruleAction;
  final _ruleTargetController = TextEditingController();
  final _contentController = TextEditingController();
  bool _noResolve = false;
  bool _src = false;
  List<DropdownMenuEntry> _targetItems = [];
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _initState();
    super.initState();
  }

  void _initState() {
    _targetItems = [
      ...RuleTarget.values.map(
        (item) => DropdownMenuEntry(value: item.name, label: item.name),
      ),
    ];
    if (widget.rule != null) {
      final parsedRule = ParsedRule.parseString(widget.rule!.value);
      _ruleAction = parsedRule.ruleAction;
      _contentController.text = parsedRule.content ?? '';
      _ruleTargetController.text = parsedRule.ruleTarget ?? '';
      _noResolve = parsedRule.noResolve;
      _src = parsedRule.src;
      return;
    }
    _ruleAction = RuleAction.addedRuleActions.first;
    if (_targetItems.isNotEmpty) {
      _ruleTargetController.text = _targetItems.first.value;
    }
  }

  @override
  void didUpdateWidget(_AddRuleDialog oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.rule != widget.rule) {
      _initState();
    }
  }

  void _handleSubmit() {
    final res = _formKey.currentState?.validate();
    if (res == false) {
      return;
    }
    final parsedRule = ParsedRule(
      ruleAction: _ruleAction,
      content: _contentController.text,
      ruleTarget: _ruleTargetController.text,
      noResolve: _noResolve,
      src: _src,
    );
    final rule = widget.rule != null
        ? widget.rule!.copyWith(value: parsedRule.value)
        : Rule.value(parsedRule.value);
    Navigator.of(context).pop(rule);
  }

  @override
  Widget build(BuildContext context) {
    return CommonDialog(
      title: appLocalizations.addRule,
      actions: [
        TextButton(
          onPressed: _handleSubmit,
          child: Text(appLocalizations.confirm),
        ),
      ],
      child: DropdownMenuTheme(
        data: DropdownMenuThemeData(
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(),
            labelStyle: context.textTheme.bodyLarge?.copyWith(
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        child: Form(
          key: _formKey,
          child: LayoutBuilder(
            builder: (_, constraints) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FilledButton.tonal(
                    onPressed: () async {
                      _ruleAction =
                          await globalState.showCommonDialog<RuleAction>(
                            filter: false,
                            child: OptionsDialog<RuleAction>(
                              title: appLocalizations.ruleName,
                              options: RuleAction.addedRuleActions,
                              textBuilder: (item) => item.value,
                              value: _ruleAction,
                            ),
                          ) ??
                          _ruleAction;
                      setState(() {});
                    },
                    child: Text(_ruleAction.value),
                  ),
                  SizedBox(height: 24),
                  TextFormField(
                    controller: _contentController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: appLocalizations.content,
                    ),
                    validator: (_) {
                      if (_contentController.text.isEmpty) {
                        return appLocalizations.emptyTip(
                          appLocalizations.content,
                        );
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 24),
                  FormField<String>(
                    validator: (_) {
                      if (_ruleTargetController.text.isEmpty) {
                        return appLocalizations.emptyTip(
                          appLocalizations.ruleTarget,
                        );
                      }
                      return null;
                    },
                    builder: (filed) {
                      return DropdownMenu(
                        controller: _ruleTargetController,
                        label: Text(appLocalizations.ruleTarget),
                        width: 200,
                        menuHeight: 250,
                        enableFilter: false,
                        enableSearch: false,
                        dropdownMenuEntries: _targetItems,
                        errorText: filed.errorText,
                      );
                    },
                  ),
                  if (_ruleAction.hasParams) ...[
                    SizedBox(height: 20),
                    Wrap(
                      spacing: 8,
                      children: [
                        CommonCard(
                          radius: 8,
                          isSelected: _src,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 8,
                            ),
                            child: Text(
                              appLocalizations.sourceIp,
                              style: context.textTheme.bodyMedium,
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              _src = !_src;
                            });
                          },
                        ),
                        CommonCard(
                          radius: 8,
                          isSelected: _noResolve,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 8,
                            ),
                            child: Text(
                              appLocalizations.noResolve,
                              style: context.textTheme.bodyMedium,
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              _noResolve = !_noResolve;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                  SizedBox(height: 20),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
