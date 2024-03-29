import 'package:flutter/material.dart';

class BaseAppBar extends StatelessWidget {
  final String title;
  final void Function()? onPressed;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;

  const BaseAppBar({
    super.key,
    required this.title,
    this.onPressed,
    this.actions,
    this.bottom,
  });

  @override
  AppBar build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: true,
      leading: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: onPressed ?? () => Navigator.pop(context),
        ),
      ),
      actions: actions,
      bottom: bottom,
    );
  }
}
