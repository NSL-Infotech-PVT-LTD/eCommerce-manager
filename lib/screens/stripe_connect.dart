import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:funfy_scanner/Helper/userData.dart';
import 'package:funfy_scanner/Models/ApiCaller.dart';
import 'package:funfy_scanner/Models/GetStripeDataModal.dart';
import 'package:webviewx/webviewx.dart';

class WebViewXPage extends StatefulWidget {
  const WebViewXPage({
    Key? key,
  }) : super(key: key);

  @override
  _WebViewXPageState createState() => _WebViewXPageState();
}

class _WebViewXPageState extends State<WebViewXPage> {
  late WebViewXController webviewController;
  String? stripeConnection;
  final initialContent =
      'https://connect.stripe.com/oauth/authorize?response_type=code&client_id=ca_K6oWF270yKqLiCZu9dKo2hS74JTku540&scope=read_write';

  bool loading = true;

  Size get screenSize => MediaQuery.of(context).size;

  @override
  void initState() {
    print("Not working ");
    getStripe();
    super.initState();
  }

  getStripe() {
    UserData.getUserToken("USERTOKEN").then((_token) {
      print("$_token");

      ApiCaller().getStripeData(_token).then((value) {
        loading = false;
        print("Stripe Afe${(value as GetStripeDataModal).data?.stripeConnect}");
        setState(() {
          stripeConnection = value.data?.stripeConnect;
        });
      });
    });
  }

  saveStripeAcctKey(accountId) {
    setState(() {
      loading = true;
    });
    UserData.getUserToken("USERTOKEN").then((_token) {
      print("$_token");

      ApiCaller().connectStripAccount(_token, accountId,context).then((value) {
        setState(() {
          loading = false;
        });
        UserData.setUserLanguage(key: "connected", value: "1");
        Navigator.pop(context);
        showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
              title: Text('SUCCESS'),
              content: Text('Sucessfully connected with stripe !'),
              actions: <Widget>[
                CupertinoDialogAction(
                    child: Text('Ok'),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ],
            );
          },
        );
      });
    });
  }

  @override
  void dispose() {
    webviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Stripe connect'),
        ),
        body: Container(
          decoration: BoxDecoration(
            border: Border.all(width: 0.2),
          ),
          child: loading
              ? Center(child: CircularProgressIndicator())
              : _buildWebViewX(),
        ),
      ),
    );
  }

  Widget _buildWebViewX() {
    return WebViewX(
      key: const ValueKey('webviewx'),
      initialContent: stripeConnection ?? "https://www.google.com/",
      onWebViewCreated: (controller) => webviewController = controller,
      onPageStarted: (src) =>
          debugPrint('A new page has started loading: $src\n'),
      onPageFinished: (src) {
        debugPrint('The page has finished loading: $src\n');

        if (src.contains("code=")) {
          setState(() {
            loading = true;
          });
          getData();
        }
      },
    );
  }

  void getData() {
    print('called.........');
    webviewController.evalRawJavascript("document.body.innerText").then((data) {
      var decodedJSON = jsonDecode(data);
      print("adaknd" + decodedJSON.toString());
      setState(() {
        loading = false;
      });
      if (decodedJSON.toString().isNotEmpty) {
        Map<String, dynamic> responseJSON = jsonDecode(decodedJSON);
        if (responseJSON["status"] == true) {
          var accountId = responseJSON["data"]["stripe_user_id"];
          saveStripeAcctKey(accountId);
        }
      }
    });
  }
}
