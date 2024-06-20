import 'dart:convert';
import 'dart:io';


import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class Impact {
  static String baseUrl = 'https://impact.dei.unipd.it/bwthw/';
  static String pingEndpoint = 'gate/v1/ping/';
  static String tokenEndpoint = 'gate/v1/token/';
  static String refreshEndpoint = 'gate/v1/refresh/';
  static String heartRateEndpoint = 'data/v1/heart_rate/patients/';

  static String patientUsername = 'Jpefaq6m58';

  Future<int> getAndStoreToken(String username, String password) async{
    final url= baseUrl + tokenEndpoint;
    final body= {'username': username,'password': password};

    final response = await http.post(Uri.parse(url),body: body) ;

    if (response.statusCode == 200) {
      final decodedResponse = jsonDecode(response.body);
      final sp = await SharedPreferences.getInstance();
      sp.setString('accessToken', decodedResponse['access']);
      sp.setString('refreshToken', decodedResponse['refresh']);
      
    }
    return response.statusCode;
  }

   Future<int> refreshToken () async{
    // quando faccio la chiamata post al server questo mi ritorna dei nuovi token se e solo se il refresh che ho inserito è ancora attivo?
     
    final url= baseUrl + refreshEndpoint;
    final sp = await SharedPreferences.getInstance();
    final refresh= sp.getString('refreshToken');
    if (refresh != null) {
      final body= {'refresh' : refresh};
      final response = await http.post(Uri.parse(url),body: body);
      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        final sp = await SharedPreferences.getInstance();
        await sp.setString('accessToken', decodedResponse['access']);
        await sp.setString('refreshToken', decodedResponse['refresh']);
      } //if

      //Just return the status code
      return response.statusCode;
    }
    return 401;

    
  }
  
  
   Future<dynamic> fetchHeartRateData(String day) async {

    //Get the stored access token (Note that this code does not work if the tokens are null)
    final sp = await SharedPreferences.getInstance();
    var access = sp.getString('accessToken');
    //If access token is expired, refresh it
    if(JwtDecoder.isExpired(access!)){
      await Impact().refreshToken();
      access = sp.getString('accessToken');
    }
    
    //NO REFRESH CHECK 

    //Create the (representative) request
    final url = '${Impact.baseUrl}${Impact.heartRateEndpoint}${Impact.patientUsername}/day/$day/';
    final headers = {HttpHeaders.authorizationHeader: 'Bearer $access'};

    //Get the response
    print('Calling: $url');
    final response = await http.get(Uri.parse(url), headers: headers);
    
    //if OK parse the response, otherwise return null
    var result = null;
    if (response.statusCode == 200) {
      print('ok');
      result = jsonDecode(response.body);
    } //if

    if (response.statusCode != 200){
      print('CHIAMATA NON RIUSCITA ${response.statusCode}');
    }

    //Return the result
    return result;

  } //_requestData









}






