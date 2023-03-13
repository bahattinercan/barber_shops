import 'package:barbers/utils/colorer.dart';
import 'package:flutter/material.dart';

class Dialogs {
  static final instance = Dialogs._internal();
  Dialogs._internal();

  static void dialog({
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
        backgroundColor: Colorer.background,
        title: Center(
          child: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18,
              color: Colorer.primaryVariant,
            ),
          ),
        ),
        content: Text(
          content,
          style: const TextStyle(color: Colorer.onBackground),
        ),
        scrollable: scrollable ?? false,
        actionsPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                    style: const TextStyle(
                      color: Colorer.onBackground,
                    ),
                  ),
                ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, okButtonText);
              okFunction == null ? null : okFunction();
            },
            child: Text(
              okButtonText,
              style: const TextStyle(
                color: Colorer.onBackground,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static successDialog({required BuildContext context, Function? okFunction, String? content}) {
    dialog(
      context: context,
      title: "Bilgilendirme",
      content: content ?? "İşlem gerçekleşti",
      okButtonText: "Tamam",
      okFunction: okFunction,
    );
  }

  static failDialog({required BuildContext context, Function? okFunction, String? content}) {
    dialog(
      context: context,
      title: "Dikkat",
      content: content ?? "İşlem gerçekleştirilemedi",
      okButtonText: "Tamam",
      okFunction: okFunction,
    );
  }

  static yesNoDialog(BuildContext context, String title, String content, {Function? cancelF, Function? okF}) {
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

  static choice2Dialog(
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
      okButtonText: okBText ?? "Evet",
      cancelButtonText: cancelBText ?? "Hayır",
      okFunction: okF,
      cancelFunction: cancelF,
    );
  }

  static customDialog({
    required BuildContext context,
    required String title,
    Widget? content,
    List<Widget>? actions,
    bool? scrollable,
  }) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: Colorer.background,
        title: Center(
          child: Text(
            title,
            style: const TextStyle(
              color: Colorer.primaryVariant,
            ),
          ),
        ),
        content: content,
        actions: actions,
        scrollable: scrollable ?? false,
      ),
    );
  }
}
