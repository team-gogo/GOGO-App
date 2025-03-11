import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gogo_app/data/models/search_school/search_school_response.dart';
import 'package:gogo_app/design_system/theme/color.dart';
import 'package:gogo_app/design_system/theme/typography.dart';
import 'package:gogo_app/presentation/sign_up/bloc/school/school_bloc.dart';
import 'package:gogo_app/presentation/sign_up/bloc/school/school_event.dart';
import 'package:gogo_app/presentation/sign_up/bloc/school/school_state.dart';

class SchoolSearchComponent extends StatelessWidget {
  final double? height;
  final double width;
  final Color backgroundColor;
  final BorderRadius borderRadius;
  final EdgeInsets padding;

  const SchoolSearchComponent({
    super.key,
    this.height,
    this.width = double.infinity,
    this.backgroundColor = GogoColors.gray700,
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
    this.padding = const EdgeInsets.all(16),
  });

  @override
  Widget build(BuildContext context) {
    double maxHeight = MediaQuery.of(context).size.height / 4;
    var schoolList = context.read<SchoolBloc>().searchSchoolResponse;

    return BlocBuilder<SchoolBloc, SchoolState>(
      builder: (context, state) {
        if (state is EnableSchoolState && schoolList.isNotEmpty) {
          return Container(
            padding: padding,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: borderRadius,
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: maxHeight,
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: schoolList.length,
                      itemBuilder: (context, index) => _SchoolComponent(
                        searchSchoolResponse: schoolList[index],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        } else {
          return Container(
            alignment: Alignment.centerLeft,
            height: 58,
            width: double.infinity,
            padding: padding,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: borderRadius,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '검색결과가 존재하지 않습니다',
                  style: GogoTypography.caption2Semibold
                      .copyWith(color: GogoColors.error),
                ),
                Divider(
                  thickness: 0.5,
                  height: 0,
                  color: GogoColors.gray600,
                )
              ],
            ),
          );
        }
      },
    );
  }
}

class _SchoolComponent extends StatelessWidget {
  final SearchSchoolResponse searchSchoolResponse;

  const _SchoolComponent({
    required this.searchSchoolResponse,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<SchoolBloc>().add(ChooseSchoolEvent(searchSchoolResponse));
      },
      child: Container(
        alignment: Alignment.centerLeft,
        width: double.infinity,
        decoration: BoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${searchSchoolResponse.schulNm}\n${searchSchoolResponse.orgRdnma}",
              style: GogoTypography.caption2Semibold
                  .copyWith(color: GogoColors.gray400),
            ),
            Divider(
              thickness: 0.5,
              height: 8,
            ),
          ],
        ),
      ),
    );
  }
}
