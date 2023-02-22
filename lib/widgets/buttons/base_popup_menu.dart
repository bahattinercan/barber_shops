import 'package:barbers/utils/color_manager.dart';
import 'package:flutter/material.dart';

class BasePopupMenuButton extends StatelessWidget {
  final void Function(dynamic)? onSelected;
  final List<PopupMenuEntry<int>> Function(BuildContext) itemBuilder;
  const BasePopupMenuButton({
    Key? key,
    this.onSelected,
    required this.itemBuilder,
  }) : super(key: key);

  @override
  PopupMenuButton build(BuildContext context) {
    return PopupMenuButton(
      icon: Icon(
        Icons.more_vert,
        color: ColorManager.primaryVariant,
      ),
      itemBuilder: itemBuilder,
      onSelected: onSelected,
    );
  }
}