import 'package:flutter/material.dart';
import 'package:excel/excel.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io' as io;
import 'package:share_plus/share_plus.dart';


class GenerateXlsx extends StatefulWidget {
  final List<Map<String, dynamic>> transactionData;
  final Map<String, dynamic> transactionSum;
  final VoidCallback action;

  const GenerateXlsx({
    super.key,
    required this.transactionData,
    required this.transactionSum,
    required this.action,
  });

  @override
  State<GenerateXlsx> createState() => _GenerateXlsxState();
}

class _GenerateXlsxState extends State<GenerateXlsx> {
  String message = '';

  void initState(){
    super.initState();
    GenerateExcel();
  }

  void GenerateExcel() async{
    // print(widget.transactionData);
    List<Map<String, dynamic>> excelData = widget.transactionData;
    var excel = Excel.createExcel();
    final sheet = excel['Sheet1'];
    CellStyle cellStyle = CellStyle(
      fontFamily :getFontFamily(FontFamily.Calibri),
      fontColorHex: ExcelColor.green,
    );


    var status = await Permission.storage.status;
    if (!status.isGranted){
      await Permission.manageExternalStorage.request();
    }
    var status1 = await Permission.storage.status;

    if(!status1.isGranted){
      await Permission.storage.request();
    }
    try {
      // CHECK IF THE DIRECTORY PRESENT (IF NOT PRESENT THEN CREATE)
      io.Directory documentDirectory = await getApplicationDocumentsDirectory();
      io.Directory ? folderStorage = io.Directory("/storage/emulated/0/FinanceStorage/");
      await folderStorage.create();
      io.Directory ? folderPathForShare = io.Directory("/storage/emulated/0/FinanceStorage/Share/");
      await folderPathForShare.create();

      // MAKING EXCEL SHEET [ HEADER ]
      var cellOne = sheet.cell(CellIndex.indexByColumnRow(columnIndex:0, rowIndex: 0));
      cellOne.value = TextCellValue('Date');
      cellOne.cellStyle = cellStyle;

      var cellTwo = sheet.cell(CellIndex.indexByColumnRow(columnIndex:1, rowIndex: 0));
      cellTwo.value = TextCellValue('Debit');
      cellTwo.cellStyle = cellStyle;

      var cellThree = sheet.cell(CellIndex.indexByColumnRow(columnIndex:2, rowIndex: 0));
      cellThree.value = TextCellValue('Credit');
      cellThree.cellStyle = cellStyle;

      var cellFour = sheet.cell(CellIndex.indexByColumnRow(columnIndex:3, rowIndex: 0));
      cellFour.value = TextCellValue('Balance');
      cellFour.cellStyle = cellStyle;

      // MAKING EXCEL SHEET [ BODY ]
      for(var row = 0; row< excelData.length; row++){
        String debit = "${(excelData[row]['amount']>=0)? excelData[row]['amount']: ''}";
        String credit = "${(excelData[row]['amount']<0)? excelData[row]['amount']: ''}";

        sheet
            .cell(CellIndex.indexByColumnRow(columnIndex:0, rowIndex: row+1))
            .value = TextCellValue('${excelData[row]['date']}');

        sheet
            .cell(CellIndex.indexByColumnRow(columnIndex:1, rowIndex: row+1))
            .value = TextCellValue(debit);

        sheet
            .cell(CellIndex.indexByColumnRow(columnIndex:2, rowIndex: row+1))
            .value = TextCellValue(credit);

        sheet
            .cell(CellIndex.indexByColumnRow(columnIndex:3, rowIndex: row+1))
            .value = TextCellValue("${excelData[row]['balance']}");
      }

      // MAKING EXCEL SHEET [ FOOTER ]
      var footerCellOne = sheet.cell(CellIndex.indexByColumnRow(columnIndex:0, rowIndex: excelData.length+1));
      footerCellOne.value = TextCellValue('Over All');
      footerCellOne.cellStyle = cellStyle;

      var footerCellTwo = sheet.cell(CellIndex.indexByColumnRow(columnIndex:1, rowIndex: excelData.length+1));
      footerCellTwo.value = TextCellValue('${widget.transactionSum['debit']}');
      footerCellTwo.cellStyle = cellStyle;

      var footerCellThree = sheet.cell(CellIndex.indexByColumnRow(columnIndex:2, rowIndex: excelData.length+1));
      footerCellThree.value = TextCellValue('${widget.transactionSum['credit']}');
      footerCellThree.cellStyle = cellStyle;

      var footerCellFour = sheet.cell(CellIndex.indexByColumnRow(columnIndex:3, rowIndex: excelData.length+1));
      footerCellFour.value = TextCellValue('${widget.transactionSum['balance']}');
      footerCellFour.cellStyle = cellStyle;



      excel.save(fileName: 'financeData.xlsx');
      var fileBytes = excel.save();
      final filePath = '${documentDirectory.path}/financeData.xlsx';

      // Write the file
      if (fileBytes != null) {
        io.File(filePath)
          ..createSync(recursive: true)
          ..writeAsBytesSync(fileBytes);
        String path = join(documentDirectory.path, '$filePath');


        io.File ourXlsxFile = io.File(path);
        await ourXlsxFile.copy("/storage/emulated/0/FinanceStorage/Share/financeData.xlsx");
        setState(() {
          message='Save Success';
        });

        // ========[ IF FILE SAVE SUCCESS THAN WE SHARE THIS FILE USING SHARE-PLUS ]========
        // final result = await Share.shareXFiles([XFile('${documentDirectory.path}financeData.xlsx')], text: 'Great picture');
        final result = await Share.shareXFiles([XFile('/storage/emulated/0/FinanceStorage/Share/financeData.xlsx')]);

        if (result.status == ShareResultStatus.success) {
          setState(() {
            message='Share Success.';
            return widget.action();
          });
        }

      } else {
        setState(() {
          message='Error saving Excel file: fileBytes is null';
        });
      }
    }
    catch(e){
      setState(() {
        message = "File Path Error: ${e.toString()}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      child: Center(
          child: Text('$message')
      ),
    );
  }
}
