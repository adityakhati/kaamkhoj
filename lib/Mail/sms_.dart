import 'package:http/http.dart';

makeSmsRequest(String phoneno) async {
  // make GET request
//  String phoneno="9082768200";
  String msgText="Welcome to Kaamkhoj. We are pleased to receive your inquiry and look forward to serve you in future.\nPlease contact us on the below given numbers.\nThanks\nAlisha Rai\nCustomer Loyalty Executive\n02266661314/ 02266661323/ 02266661515\nWhatsapp 8879392064";
  String url = 'http://103.233.79.246//submitsms.jsp?user=Fitzone&key=97a7a78c99XX&mobile=' +phoneno+'&message='+msgText+'&senderid=INFOSM&accusage=1';
  Response response = await get(url);
}
