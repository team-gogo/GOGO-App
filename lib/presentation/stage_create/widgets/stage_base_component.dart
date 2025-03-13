import 'package:flutter/cupertino.dart';
import 'package:gogo_app/design_system/theme/color.dart';
import 'package:gogo_app/design_system/theme/typography.dart';

class StageBaseComponent extends StatelessWidget {
  final String title;
  final String? description;
  final List<Widget> children;

  const StageBaseComponent({
    super.key,
    required this.title,
    this.description,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: GogoColors.black,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(
                title,
                style: GogoTypography.body2Extrabold
                    .copyWith(color: GogoColors.white),
              ),
              const SizedBox(width: 12),
              description != null
                  ? Text(
                      description!,
                      style: GogoTypography.caption2Semibold,
                    )
                  : SizedBox.shrink()
            ],
          ),
          SizedBox(height: 16),
          Column(
            spacing: 12,
            children: [
              ...children,
            ],
          )
        ],
      ),
    );
  }
}
