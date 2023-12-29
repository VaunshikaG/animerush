import 'package:url_launcher/url_launcher.dart';

launchURL({required String strUrl}) async {
  final url = strUrl;
  try {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      await launch(url);
    }
  } catch (e) {
    throw 'Could not launch $url';
  }
}
