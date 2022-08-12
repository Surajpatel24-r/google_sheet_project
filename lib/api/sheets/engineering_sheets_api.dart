import 'package:google_sheet_project/model/user.dart';
import 'package:gsheets/gsheets.dart';

class EngineeringSheetApi {
  static const _credentials = r'''
{
  "type": "service_account",
  "project_id": "engineering-359212",
  "private_key_id": "c3f49badf237767d57edfedb4554c5895f70dd61",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQC6OGWFuO5Ywy/z\nUGqaTxwORUX/Kr6d2ywLSziu3S8IMsM+VZj4NSdNi13ZoAnvklSu58zwC0Zvm0cm\n5PHnp5JnZAzovm1VkEJdBxT2sirkrX4UP3EYfZpsd9HPn/56vlOaEm9OyeMNXPiP\n/WWsuTeFDC6nPGocl7anOY29VkluGMEPaiqRPrmpSQV3rf6ctPtr5+3nMSC3qPKj\n5apVX/uvdQW60QTym/5Lwx1Sd3ubCO0WYk8K7FDImZ32dZ++BWPSk8L3KlfZYX6+\ndZJUNSQBNcAmSKofl0znrEFkYHT+NGj04X+rrI7RLNzf8PVKPN7W3sYEGyxa9BHK\n4+mRKjBhAgMBAAECggEAAbSMVo+eVSLO4nZ8shZwUBUH0KVJpL15F06bc1uXxc2H\npOZ1Q/Pwbquo9lMFNvBT9uqe4XO93nbTMQ8utc1iOs1Qt7muBlqWv6crMvLLj9CU\nypGCRNCd26XPzMv2IyP/imC7j5gdaPeqygk1o9cUeTafmGmCoj8eMShxZ07uHLYc\nJ2a0yYvXIyLGYVBtJloeeiZcn6tH/PBNX8tBMVoY6fVHND7xGMqFsQwz1aVIN5W2\nYRI998qriOzWOg5vsQXR7neAnatn0XPHUUdDSOEYMj/REb7jQaaeHGqIrrk5aZNW\n4mVzKxZ1lL/WBbr0NxBrryPgEGGrS2ROwEGE7LWR8QKBgQDcQSbzaIL3/pK03fp3\ntzgD43u4HZK1FPyUO3cRO0oWtGF12jc8uXvH7dMxH1wGsWdMHAQ/pWP6r5lVNUTf\nSNO8E2JUc6OsgCcS+HGgxTixu+4KwuGG3LoynvH6UWmVqQNXVQl+4iPyS49wXPse\nXdNlgEjZhaHGJ8W739Ai3FxN+QKBgQDYcTxSYyeBUAhpFw13FucZ5iuiXxmw2Nqc\n2+34Q5ZzVgT0N5sR1k0Fb5QMKYfjHmPTzuODBIY33ZLE6GOJuHTY7bqh/vL2rLwp\nCel+QOSMzuPfziJgX9E/njpuWcdh5os+7fz9/JWb5lPCsohgiAQO5TxE8dsvmNCM\nWYOgN7ovqQKBgHf1jC9aJqrHHkQf+kClq36CsWlvwe2aRo69bHYYIpwHFmXHufn6\n0+3qG/JPMCH9EVOklrPLco6ggRSldKNf2OJAdHemm+hhy+ZLJif4Ao7a2iVGSurW\n4Rqc8xHwsV7vtIAmMovGwuk+OhtqqOK7G13W5taCL7/q/Yj7tzKlbiiRAoGBAK//\nrAhmXlpVZPFncGiVNAioVHTtFevq+iEw6RnGg9F3cgHQMYVYmDrCV0Vog/nX3V7/\nTZtdE3Lb9putSDtVxZYcAXX25URWg45vY/Fo/S/OkBeN/AAYCgPMO0E+OdXO7Q2X\n4e/58wHZUeTw3dp436vpFZAOhqf2gCaQJ2shxYE5AoGAE6A9JLlt/ZSawhfX2WfK\nO9NwN0VyQRqohq1HujpiYjtQ4oqoCgwigjVT6kWYZYjOG/djELsJOimSgfC7efvq\npPuZoaMnjER4L7tmid1w5MhxwwQHGCh1aI1DTU0KS1EpucaUWrqrxbMTWdhbIaUj\nbXDgTZdYHVMD511iNFMqZSI=\n-----END PRIVATE KEY-----\n",
  "client_email": "engineering@engineering-359212.iam.gserviceaccount.com",
  "client_id": "107785437437148555613",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/engineering%40engineering-359212.iam.gserviceaccount.com"
}
''';
  static final _spreadsheetId = '1v67UcD_R_EAndedoyIg3kil0hkVnAW0BKwPgkT7XFXE';
  static final _gsheets = GSheets(_credentials);
  static Worksheet? _engineeringSheet;

  static Future init() async {
    try {
      final spreadsheet = await _gsheets.spreadsheet(_spreadsheetId);
      _engineeringSheet =
          await _getWorkSheet(spreadsheet, title: 'Engineering');

      final firstRow = UserFields.getFields();
      _engineeringSheet!.values.insertRow(1, firstRow);
    } catch (e) {
      print('Init Error: $e');
    }
  }

  static Future<Worksheet> _getWorkSheet(Spreadsheet spreadsheet,
      {required String title}) async {
    try {
      return await spreadsheet.addWorksheet(title);
    } catch (e) {
      return spreadsheet.worksheetByTitle(title)!;
    }
  }

  static Future insert(List<Map<String, dynamic>> rowList) async {
    if (_engineeringSheet == null) return;

    _engineeringSheet!.values.map.appendRows(rowList);
  }
}
