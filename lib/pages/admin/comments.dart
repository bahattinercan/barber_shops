import 'package:barbers/models/barber_shop.dart';
import 'package:barbers/models/comment.dart';
import 'package:barbers/pages/admin/barber_shop.dart';
import 'package:barbers/utils/http_req_manager.dart';
import 'package:barbers/utils/push_manager.dart';
import 'package:barbers/widgets/cards/comment.dart';
import 'package:barbers/widgets/nav_bars/admin_shop.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AdminCommentsPage extends StatefulWidget {
  BarberShop shop;
  bool canDelete;
  bool canRemoveWorker;
  AdminCommentsPage({
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
    getData.then((value) {
      setState(() {
        comments = value;
      });
    });
    super.initState();
  }

  Future<List<Comment>> get getData async {
    try {
      String datas = "";
      datas = await HttpReqManager.getReq('/comments/shop/${widget.shop.id}');

      return commentListFromJson(datas);
    } catch (e) {
      print(e);
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData media = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.shop.name!),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => PushManager.pushAndRemoveAll(context, AdminBarberPage(shop: widget.shop)),
        ),
      ),
      body: SafeArea(
        child: Container(
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
      bottomNavigationBar: AdminBarberShopBottomNB(
        selectedIndex: 0,
        shop: widget.shop,
      ),
    );
  }
}
