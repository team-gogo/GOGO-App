import 'package:flutter/material.dart';
import 'package:gogo_app/design_system/component/tag/gogo_tag_component.dart';
import 'package:gogo_app/design_system/theme/color.dart';
import 'package:gogo_app/presentation/community/widgets/communify_filter/community_filter_popup.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => showDialog(
          context: context,
          builder: (_) => CommunityFilterPopup(),
        ),
        child: Center(child: GogoTagComponent(color: GogoColors.main500, text: 'asdf'))
      ),
    );
  }
}
