import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/widgets/widgets.dart';
import 'package:flutter/material.dart';

class OverwriteView extends StatefulWidget {
  const OverwriteView({super.key});

  @override
  State<OverwriteView> createState() => _OverwriteViewState();
}

class _OverwriteViewState extends State<OverwriteView> {
  // void _setIcon() {}

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      title: '覆写',
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InfoHeader(info: Info(label: '覆写模式')),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Wrap(
                    spacing: 16,
                    children: [
                      CommonCard(
                        isSelected: false,
                        onPressed: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Flexible(child: Icon(Icons.stars)),
                              const SizedBox(width: 8),
                              Flexible(child: Text('标准')),
                            ],
                          ),
                        ),
                      ),
                      CommonCard(
                        isSelected: false,
                        onPressed: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Flexible(child: Icon(Icons.rocket)),
                              const SizedBox(width: 8),
                              Flexible(child: Text('脚本')),
                            ],
                          ),
                        ),
                      ),
                      // for (final type in OverwriteType.values)
                      //   CommonCard(
                      //     onPressed: _setIcon,
                      //     child: Padding(
                      //       padding: EdgeInsets.symmetric(
                      //         horizontal: 12,
                      //         vertical: 8,
                      //       ),
                      //       child: Text(
                      //         type.name,
                      //         style: context.textTheme.bodyMedium,
                      //       ),
                      //     ),
                      //   ),
                    ],
                  ),
                ),
                SizedBox(height: 12),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    '标准策略，覆写基本配置，提供简单追加规则能力',
                    style: context.textTheme.bodySmall?.copyWith(
                      color: context.colorScheme.onSurfaceVariant.opacity80,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 24)),
          SliverToBoxAdapter(
            child: Column(
              children: [
                InfoHeader(
                  info: Info(label: '附加规则'),
                  padding: EdgeInsets.symmetric(horizontal: 16.ap),
                  actions: [
                    CommonFilledButtonTheme(
                      child: FilledButton(
                        onPressed: () {},
                        child: Text(appLocalizations.add),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 8)),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: CommonCard(
                // type: CommonCardType.filled,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('编辑全局附加规则', style: context.textTheme.bodyLarge),
                      SizedBox(width: 4),
                      Icon(Icons.arrow_forward, size: 18),
                    ],
                  ),
                ),
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
