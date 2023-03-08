// ignore_for_file: use_build_context_synchronously

import 'package:barbers/models/comment.dart';
import 'package:barbers/utils/app_manager.dart';
import 'package:barbers/utils/colorer.dart';
import 'package:barbers/utils/formatter.dart';
import 'package:barbers/utils/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CommentCard extends StatefulWidget {
  final Comment comment;
  final Function(Comment comment)? removeComment;
  const CommentCard({
    super.key,
    required this.comment,
    this.removeComment,
  });

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  bool isVisible = true;
  Uint8List? image;
  // Uint8List? image = comment.getImage();

  /// her satır 38 harf içeriyor ve satırlar 18 yüksekliğinde
  double getHeight() {
    int length = widget.comment.comment!.length;

    if (length <= 76) {
      // 2 line
      return 62;
    } else if (length <= 114) {
      // 3 line
      return 80;
    } else if (length <= 152) {
      // 4 line
      return 98;
    } else if (length <= 190) {
      // 5 line
      return 116;
    }
    // 6 line
    return 134;
  }

  get canDelete {
    if (AppManager.user.id == widget.comment.userId) {
      return true;
    } else {
      return false;
    }
  }

  deleteButton() {
    Dialogs.yesNoDialog(
      context,
      "Yorum sil?",
      "Yorum silinsin mi?",
      okF: delete,
    );
  }

  delete() async {
    bool res = await Comment.delete(id: widget.comment.id!);
    if (!res) {
      Dialogs.failDialog(context: context);
      return;
    }
    if (widget.removeComment != null) widget.removeComment!(widget.comment);
    setState(() => isVisible = false);
    Dialogs.successDialog(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible,
      child: SizedBox(
        height: getHeight(),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2.5,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 4,
                      ),
                      child: SizedBox(
                        width: 50,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: image == null
                              ? Image.asset(
                                  "assets/images/test.png",
                                  fit: BoxFit.cover,
                                  height: 50,
                                  width: 50,
                                )
                              : Image.memory(
                                  image!,
                                  fit: BoxFit.cover,
                                  height: 50,
                                  width: 50,
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                widget.comment.fullname!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colorer.onSurface,
                                ),
                              ),
                              const SizedBox(
                                width: 2,
                              ),
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 18,
                              ),
                              Text(
                                widget.comment.stars!.toString(),
                                style: const TextStyle(color: Colors.amber),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Visibility(
                                visible: canDelete,
                                child: GestureDetector(
                                  onTap: deleteButton,
                                  child: const Icon(
                                    Icons.delete_rounded,
                                    size: 16,
                                    color: Colorer.secondary,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 2),
                              Text(
                                Formatter.dateFormatter.format(widget.comment.time!),
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: Colorer.onSurface,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      Text(widget.comment.comment!),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
