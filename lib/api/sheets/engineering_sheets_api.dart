import 'package:google_sheet_project/model/user.dart';
import 'package:gsheets/gsheets.dart';

class EngineeringSheetApi {
  static const _credentials = //r''' <Enter your Google Cloud Credential Account json file> ''';
  static final _spreadsheetId = // Enter your Google Sheet file link;
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
