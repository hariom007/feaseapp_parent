import 'dart:convert';
import 'package:http/http.dart' as http;


class CallApi{

  final String _url='https://finaltestapi.acadmin.in/api/FeesData/';
  final String _url2='https://finaltestapi.acadmin.in/api/MasterData/';

  final String _Razorpay_url='https://api.razorpay.com/v1/';

  // final String _url1='https://homexp.in/AgentApi/';


  postData(data,apiUrl) async {
    var fullUrl = _url + apiUrl;
    return await http.post(
        fullUrl,
        body: jsonEncode(data),
        headers: _setHeaders()
    );
  }


  postData2(data,apiUrl) async {
    var fullUrl = _url2 + apiUrl;
    return await http.post(
        fullUrl,
        body: jsonEncode(data),
        headers: _setHeaders()
    );
  }


  getData(apiUrl) async {
    var fullUrl =_url + apiUrl ;// await _getToken();
    return await http.get(
        fullUrl,
        headers: _setHeaders()
    );
  }

  _setHeaders()=>{
    // 'Authorization' : '4ccda7514adc0f13595a585205fb9761',
    'Content-type' : 'application/json',
    'Accept' : 'application/json',

  };
  _setHeaders2()=>{
    // 'Authorization' : '4ccda7514adc0f13595a585205fb9761',
    'Content-type' : 'application/x-www-form-urlencoded; charset=UTF-8',
    'Accept' : 'application/json',

  };

  razorPaypostData(username,password,data,apiUrl) async {
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));

    print(basicAuth);

    var fullUrl = _Razorpay_url + apiUrl;
    return await http.post(
        fullUrl,
        body: jsonEncode(data),
        headers: {
          'Content-type' : 'application/json',
          'Accept' : 'application/json',
          'authorization':basicAuth,
        }
    );
  }

}