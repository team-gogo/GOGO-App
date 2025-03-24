import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gogo_app/design_system/component/top_bar/gogo_top_bar.dart';
import 'package:gogo_app/design_system/theme/color.dart';
import 'package:gogo_app/design_system/theme/typography.dart';
import 'package:gogo_app/presentation/ranking/widgets/ranking_component.dart';
import 'package:gogo_app/presentation/ranking/widgets/ranking_list_item.dart';

class RankingPage extends StatelessWidget {
  const RankingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GogoColors.black,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            spacing: 24,
            children: [
              GogoTopBar(title: '포인트 랭킹', onBackTap: () => context.pop(context)),
              Container(
                padding: EdgeInsets.all(20),
                width: double.infinity,
                height: 256,
                decoration: BoxDecoration(
                  color: GogoColors.gray700,
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'TOP 3',
                      style: GogoTypography.body2Extrabold
                          .copyWith(color: Colors.white),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RankingComponent(
                          points: 1500,
                          name: '나현욱',
                          colors: [
                            Color(0xFF989898),
                            Color(0xFFD5D5D5),
                            Color(0xFF676767),
                          ],
                          circleSize: 70,
                          iconSize: 24,
                        ),
                        RankingComponent(
                          points: 2000,
                          name: '나현욱',
                          colors: [
                            Color(0xFFA07102),
                            Color(0xFFFADC73),
                            Color(0xFF9F812E),
                          ],
                          circleSize: 90,
                          iconSize: 40,
                        ),
                        RankingComponent(
                          points: 1000,
                          name: '나현욱',
                          colors: [
                            Color(0xFFAE5C43),
                            Color(0xFFF4A98C),
                            Color(0xFF763920),
                          ],
                          circleSize: 70,
                          iconSize: 24,
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    spacing: 8,
                    children: List.generate(
                      20,
                      (index) => RankingListItem(
                          index: index , name: '김진원', point: 123),
                    ),
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
