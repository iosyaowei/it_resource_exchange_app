import 'package:flutter/cupertino.dart';

class CustomAlertDialog extends CupertinoAlertDialog {
  final String desc;
  final ValueChanged<bool> onChanged;

  CustomAlertDialog({Key key, this.desc, this.onChanged}) : super(key: key);

  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text('提示'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(this.desc),
          ],
        ),
      ),
      actions: <Widget>[
        CupertinoDialogAction(
          child: Text('取消'),
          onPressed: () {
            Navigator.of(context).pop();
            this.onChanged(false);
          },
        ),
        CupertinoDialogAction(
          child: Text('确定'),
          onPressed: () {
            Navigator.of(context).pop();
            this.onChanged(true);

          },
        ),
      ],
    );
  }
}
