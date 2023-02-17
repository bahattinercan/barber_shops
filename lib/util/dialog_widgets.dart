import 'package:barbers/util/main_colors.dart';
import 'package:flutter/material.dart';

class DialogWidgets {
  static final instance = DialogWidgets._internal();
  DialogWidgets._internal();

  void dialog({
    required BuildContext context,
    required String title,
    required String content,
    String? cancelButtonText,
    required String okButtonText,
    Function? cancelFunction,
    Function? okFunction,
    bool? scrollable,
  }) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: MainColors.white,
        title: Center(
          child: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
          ),
        ),
        content: Text(content),
        scrollable: scrollable == null ? false : scrollable,
        actionsPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        actions: <Widget>[
          cancelButtonText == null
              ? Container()
              : TextButton(
                  onPressed: () {
                    Navigator.pop(context, cancelButtonText);
                    cancelFunction == null ? null : cancelFunction();
                  },
                  child: Text(
                    cancelButtonText,
                    style: TextStyle(color: MainColors.black),
                  ),
                ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, okButtonText);
              okFunction == null ? null : okFunction();
            },
            child: Text(
              okButtonText,
              style: TextStyle(color: MainColors.black),
            ),
          ),
        ],
      ),
    );
  }

  successDialog({required BuildContext context, Function? okFunction, String? content}) {
    dialog(
        context: context,
        title: "Bilgilendirme",
        content: content == null ? "İşlem gerçekleşti" : content,
        okButtonText: "Tamam",
        okFunction: okFunction);
  }

  failDialog({required BuildContext context, Function? okFunction, String? content}) {
    dialog(
      context: context,
      title: "Dikkat",
      content: content == null ? "İşlem gerçekleştirilemedi" : content,
      okButtonText: "Tamam",
      okFunction: okFunction == null ? () {} : okFunction,
    );
  }

  yesNoDialog(BuildContext context, String title, String content, {Function? cancelF, Function? okF}) {
    dialog(
      context: context,
      title: title,
      content: content,
      okButtonText: "Evet",
      cancelButtonText: "Hayır",
      okFunction: okF,
      cancelFunction: cancelF,
    );
  }

  choice2Dialog(
    BuildContext context,
    String title,
    String content, {
    Function? cancelF,
    Function? okF,
    String? cancelBText,
    String? okBText,
  }) {
    dialog(
      context: context,
      title: title,
      content: content,
      okButtonText: okBText == null ? "Evet" : okBText,
      cancelButtonText: cancelBText == null ? "Hayır" : cancelBText,
      okFunction: okF,
      cancelFunction: cancelF,
    );
  }

  customDialog({
    required BuildContext context,
    required String title,
    Widget? content,
    List<Widget>? actions,
    bool? scrollable,
  }) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Center(child: Text(title)),
        content: content,
        actions: actions,
        scrollable: scrollable == null ? false : scrollable,
      ),
    );
  }
}
