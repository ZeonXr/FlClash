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
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.all(12),
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
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            sliver: SliverToBoxAdapter(
              child: Text(
                '标准策略，仅覆写基础配置',
                style: context.textTheme.labelLarge?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
