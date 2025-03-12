import 'package:flutter/material.dart';
import 'package:gogo_app/design_system/component/button/gogo_icon_button.dart';
import 'package:gogo_app/design_system/component/tag/tag_component.dart';
import 'package:gogo_app/design_system/theme/icon.dart';
import '../../theme/color.dart';
import '../../theme/typography.dart';

class StageCardComponent extends StatelessWidget {
  final String stageName;
  final TextStyle stageTextStyle;
  final double height;
  final double width;
  final Color color;
  final BorderRadius borderRadius;
  final EdgeInsets tagPadding;
  final double tagSpacing;
  final double tagInsideSpacing;
  final TextStyle tagTextStyle;
  final BorderRadius tagBorderRadius;
  final double iconSize;
  final EdgeInsets padding;
  final bool official; // 공식: true, 비공식: false
  final bool recruiting; // 모집 중: true, 모집 확정: false
  final bool manager; // 관리자 태그가 보임: true, 안보임: false
  final bool broadcast; // 중계 설정 태그가 보임: true, 안보임: false
  final VoidCallback onTap;
  final String buttonText;
  final double buttonHeight;
  final double buttonWidth;
  final Widget buttonIcon;

  const StageCardComponent({
    super.key,
    this.height = 220,
    this.width = double.infinity,
    required this.stageName,
    this.stageTextStyle = GogoTypography.body1Extrabold,
    required this.color,
    this.borderRadius = const BorderRadius.all(Radius.circular(16)),
    this.tagPadding = const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    this.tagSpacing = 12,
    this.tagInsideSpacing = 6,
    this.tagTextStyle = GogoTypography.caption3Semibold,
    this.tagBorderRadius = const BorderRadius.all(Radius.circular(8)),
    this.iconSize = 12,
    this.padding = const EdgeInsets.all(16),
    required this.official,
    required this.recruiting,
    required this.manager,
    required this.broadcast,
    required this.onTap,
    required this.buttonText,
    this.buttonHeight = 60,
    this.buttonWidth = double.infinity,
    required this.buttonIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          color: color,
        ),
        height: height,
        width: width,
        child: Padding(
          padding: padding,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Row(
                  children: [
                    official
                        ? TagComponent(
                            padding: tagPadding,
                            borderRadius: tagBorderRadius,
                            spacing: tagInsideSpacing,
                            color: GogoColors.white,
                            text: '공식',
                            textStyle: tagTextStyle,
                            icon: GogoIcons.trophy(
                              width: iconSize,
                              height: iconSize,
                              color: GogoColors.white,
                            ),
                          )
                        : Container(),
                    SizedBox(
                      width: tagSpacing,
                    ),
                    TagComponent(
                      padding: tagPadding,
                      borderRadius: tagBorderRadius,
                      spacing: tagInsideSpacing,
                      color:
                          recruiting ? GogoColors.success : GogoColors.gray500,
                      text: recruiting ? '모집 중' : '모집 확정',
                      textStyle: tagTextStyle,
                      icon: GogoIcons.stage(
                        width: iconSize,
                        height: iconSize,
                        color: recruiting
                            ? GogoColors.success
                            : GogoColors.gray500,
                      ),
                    ),
                    SizedBox(
                      width: tagSpacing,
                    ),
                    manager
                        ? TagComponent(
                            padding: tagPadding,
                            borderRadius: tagBorderRadius,
                            spacing: tagInsideSpacing,
                            color: GogoColors.main500,
                            text: '관리자',
                            textStyle: tagTextStyle,
                            icon: GogoIcons.person(
                              width: iconSize,
                              height: iconSize,
                              color: GogoColors.main500,
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: broadcast
                    ? TagComponent(
                        padding: tagPadding,
                        borderRadius: tagBorderRadius,
                        spacing: tagInsideSpacing,
                        color: GogoColors.error,
                        text: '중계 설정',
                        textStyle: tagTextStyle,
                        icon: GogoIcons.play(
                          width: iconSize,
                          height: iconSize,
                          color: GogoColors.error,
                        ),
                      )
                    : Container(),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  stageName,
                  style: stageTextStyle.copyWith(color: GogoColors.white),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: buttonHeight,
                  child: GogoIconButton(
                    icon: buttonIcon,
                    onTap: onTap,
                    text: buttonText,
                    width: buttonWidth,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
