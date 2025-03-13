import 'package:flutter/material.dart';
import 'package:gogo_app/design_system/component/top_bar/gogo_top_bar.dart';
import 'package:gogo_app/design_system/theme/color.dart';
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
              GogoTopBar(title: '포인트 랭킹', onBackTap: () {}),
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
                child: SizedBox(
                  width: 302,
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(16),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: GogoColors.gray700,
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      spacing: 8,
                      children: List.generate(
                        20,
                        (index) => SizedBox(
                          height: 38,
                          child: RankingListItem(index: index, name: '김진원', point: 123),
                        ),
                      ),
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
