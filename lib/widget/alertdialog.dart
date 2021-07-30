import 'package:flutter/material.dart';

class AlertDialogWidget extends StatelessWidget {
  final String contentText;
  final Function confimn;
  final Function decline;

  const AlertDialogWidget(
      {Key key, this.contentText, this.confimn, this.decline})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.fromLTRB(0, 10, 0, 10),
      elevation: 0,
      backgroundColor: Colors.transparent,
      content: Container(
        height: MediaQuery.of(context).size.height * .2,
        decoration: BoxDecoration(
          color: Colors.blue[100],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(100),
            bottomLeft: Radius.circular(100),
            topRight: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    Icons.warning,
                    size: 50,
                    color: Colors.red[400],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 150,
                    child: Center(
                      child: Text(
                        contentText,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    children: [
                      FlatButton(
                        onPressed: decline,
                        color: Colors.red[300],
                        child: Text('Không',
                            style: TextStyle(color: Colors.white)),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      FlatButton(
                        color: Colors.green[300],
                        onPressed: confimn,
                        child:
                            Text('Có', style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
