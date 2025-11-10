import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/widgets/widgets.dart';
import 'package:flutter/material.dart';

class OverwriteView extends StatefulWidget {
  const OverwriteView({super.key});

  @override
  State<OverwriteView> createState() => _OverwriteViewState();
}

class _OverwriteViewState extends State<OverwriteView> {
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
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final type in OverwriteType.values)
                    CommonCard(
                      onPressed: () {},
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        child: Text(
                          type.name,
                          style: context.textTheme.bodyMedium,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            sliver: SliverToBoxAdapter(child: Text('标准策略，仅覆写基础配置')),
          ),
        ],
      ),
    );
  }
}
