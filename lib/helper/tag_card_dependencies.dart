
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/merchant_model.dart';
import '../models/tag_model.dart';

class TagScanHelper{

  static MerchantModel? merchantModel;
  static bool isLoading = false;
  static bool isError = false;
  static String readCardMetaData(var cardTagScanData){
    TagModel nfcModel = tagModelFromJson(jsonEncode(cardTagScanData));
    String nfcIdentifier = _getIdentifierString(nfcModel.ndefformatable.identifier.toString());
    return nfcIdentifier;
  }
  static String _getIdentifierString(String identifierString){
    var tempIdentifierString = identifierString.replaceAll(", ", "");
    var finalIdentifierString = tempIdentifierString.substring(1, tempIdentifierString.length-1);
    return finalIdentifierString;
  }

}