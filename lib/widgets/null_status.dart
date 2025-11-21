import 'package:fl_clash/common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class NullStatus extends StatelessWidget {
  final String label;

  const NullStatus({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(0.0, -0.25),
      child: Wrap(
        direction: Axis.vertical,
        runAlignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          ThemeAwareSvg(
            'assets/images/empty_data.svg',
            width: 200,
            height: 200,
          ),
          SizedBox(height: 16),
          Text(
            label,
            style: Theme.of(context).textTheme.titleMedium?.toBold.toLight,
          ),
        ],
      ),
    );
  }
}

class ThemeAwareSvg extends StatelessWidget {
  final String assetPath;
  final double? width;
  final double? height;

  const ThemeAwareSvg(this.assetPath, {super.key, this.width, this.height});

  String _colorToHex(Color color) {
    return color.toARGB32().toRadixString(16).substring(2);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    return Container(
      decoration: ShapeDecoration(
        color: context.colorScheme.secondaryContainer,
        shape: StarBorder(
          points: 3,
          innerRadiusRatio: 1,
          pointRounding: 0.3,
          valleyRounding: 0.5,
          squash: 0.2,
        ),
      ),
      child: FutureBuilder<String>(
        future: rootBundle.loadString(assetPath),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            String svgString = snapshot.data!;
            svgString = svgString.replaceAll(
              '#E8DEF8',
              '#${_colorToHex(colorScheme.secondaryContainer)}',
            );
            svgString = svgString.replaceAll(
              '#6750A4',
              '#${_colorToHex(colorScheme.primary)}',
            );
            svgString = svgString.replaceAll(
              '#FDF7FF',
              '#${_colorToHex(colorScheme.surface)}',
            );
            svgString = svgString.replaceAll(
              '#C4C7C5',
              '#${_colorToHex(colorScheme.outlineVariant)}',
            );
            return SvgPicture.string(svgString, width: width, height: height);
          } else if (snapshot.hasError) {
            return const Icon(Icons.error);
          }
          return SizedBox(width: width, height: height);
        },
      ),
    );
  }
}
