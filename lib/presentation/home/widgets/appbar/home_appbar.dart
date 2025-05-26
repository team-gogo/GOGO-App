import 'package:flutter/material.dart';
import 'package:gogo_app/design_system/component/button/gogo_icon_button.dart';
import 'package:gogo_app/design_system/theme/color.dart';
import 'package:gogo_app/design_system/theme/icon.dart';
import 'package:gogo_app/design_system/theme/typography.dart';
import 'package:gogo_app/design_system/component/tag/gogo_date_tag_component.dart';

class HomeAppbar extends StatefulWidget {
  final int point;
  final DateTime selectedDate;
  final void Function(DateTime) setSelectedDate;

  const HomeAppbar({
    super.key,
    required this.point,
    required this.selectedDate,
    required this.setSelectedDate,
  });

  @override
  State<HomeAppbar> createState() => _HomeAppbarState();
}

class _HomeAppbarState extends State<HomeAppbar> {
  final now = DateTime.now();
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _scrollToSelectedDate());
  }

  void _scrollToSelectedDate() {
    final int index = widget.selectedDate.difference(now).inDays + 7;
    const double itemWidth = 68.8; // 날짜 태그의 가로 크기 + 간격
    final double scrollTo = (index * itemWidth).toDouble();
    scrollController.jumpTo(scrollTo.clamp(
      scrollController.position.minScrollExtent,
      scrollController.position.maxScrollExtent,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              spacing: 12,
              children: [
                Text(
                  '포인트',
                  style: GogoTypography.body2Semibold.copyWith(
                    color: GogoColors.gray500,
                  ),
                ),
                Text(
                  "${widget.point}P",
                  style: GogoTypography.caption1Extrabold
                      .copyWith(color: GogoColors.white),
                ),
              ],
            ),
            IconButton(
                onPressed: () => Scaffold.of(context).openEndDrawer(),
                icon: GogoIcons.drawerIcon(color: GogoColors.white))
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Stack(
                children: [
                  // 날짜 태그 스크롤
                  SingleChildScrollView(
                    controller: scrollController,
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      spacing: 7,
                      children: List.generate(
                        15,
                        (index) {
                          final DateTime dateTime =
                              now.add(Duration(days: index - 7));
                          return GestureDetector(
                            onTap: () {
                              widget.setSelectedDate(dateTime);
                            },
                            child: GogoDateTagComponent(
                              tagState: dateTime.day == widget.selectedDate.day,
                              dateTime: dateTime,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    left: -10,
                    top: 0,
                    bottom: 0,
                    width: 40,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            GogoColors.black,
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    bottom: 0,
                    width: 40,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerRight,
                          end: Alignment.centerLeft,
                          colors: [
                            GogoColors.black.withOpacity(0.8),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
