import 'package:barbers/models/barber_shop.dart';
import 'package:barbers/models/comment.dart';
import 'package:barbers/utils/app_manager.dart';
import 'package:barbers/widgets/app_bars/base.dart';
import 'package:barbers/widgets/cards/comment.dart';
import 'package:barbers/widgets/nav_bars/admin_shop.dart';
import 'package:flutter/material.dart';

class AdminCommentsPage extends StatefulWidget {
  final BarberShop shop;
  final bool canDelete;
  final bool canRemoveWorker;
  const AdminCommentsPage({
    super.key,
    required this.shop,
    this.canDelete = false,
    this.canRemoveWorker = false,
  });

  @override
  State<AdminCommentsPage> createState() => _AdminCommentsPageState();
}

class _AdminCommentsPageState extends State<AdminCommentsPage> {
  List<Comment> comments = [];

  @override
  initState() {
    Comment.getShops(shopId: widget.shop.id!).then((value) {
      setState(() {
        comments = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData media = MediaQuery.of(context);
    return Scaffold(
      appBar: BaseAppBar(
        title: AppManager.stringToTitle('yorum'),
        onPressed: () => Navigator.pop(context),
      ).build(context),
      body: SafeArea(
        child: SizedBox(
          width: media.size.width,
          child: Column(children: [
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return CommentCard(comment: comments[index]);
                },
                itemCount: comments.length,
              ),
            ),
          ]),
        ),
      ),
      bottomNavigationBar: AdminShopBottomNav(
        selectedIndex: 0,
        shop: widget.shop,
      ),
    );
  }
}
