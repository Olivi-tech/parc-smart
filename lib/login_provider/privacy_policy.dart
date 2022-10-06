import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  bool isLoading = true;
  final _key = UniqueKey();
  final String _url = 'https://parcsmart.com/privacy.jsp';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Enable virtual display.
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    print('/////////////////////////////$width//////////////////////////');
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
          padding: const EdgeInsets.only(top: 13.0),
          color: Colors.white,
          width: width,
          height: height,
          child: Stack(
            children: [
              WebView(
                key: _key,
                initialUrl: _url,
                javascriptMode: JavascriptMode.unrestricted,
                onPageFinished: (finish) {
                  setState(() {
                    isLoading = false;
                  });
                },
              ),
              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : const SizedBox()
            ],
          )),
    );
  }
}
