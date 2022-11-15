import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:kasrzero_flutter/constants.dart';
import 'package:webview_flutter/webview_flutter.dart';

class paypalWIdget extends StatefulWidget {
  int totalprise;
  paypalWIdget({
    required this.totalprise
  });

  @override
  State<paypalWIdget> createState() => _paypalWIdgetState();
}


class _paypalWIdgetState extends State<paypalWIdget> {
  String _loadHTML() {
    return '''
      <html>
        <body onload="document.f.submit();">
          <form id="f" name="f" method="post" action="http://${KLocalhost}/product/paypal">
            <input type="hidden" name="price" value="${widget.totalprise}" />
          </form>
        </body>
      </html>
    ''';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: WebView(
      onPageFinished: (page) {
        if (page.contains('/success')) {
          Navigator.pop(context);
        }
      },
      javascriptMode: JavascriptMode.unrestricted,
      initialUrl:
          new Uri.dataFromString(_loadHTML(), mimeType: 'text/html').toString(),
    ));
  }
}
