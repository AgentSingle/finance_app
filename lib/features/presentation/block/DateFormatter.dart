String getCurrentDate(){
  DateTime currentDate = DateTime.now();
  String currentDateString = "${currentDate.day}-${currentDate.month}-${currentDate.year}";
  return currentDateString;
}

String getPreviousDate(int difference){
  DateTime currentDate = DateTime.now();
  DateTime previousDate = currentDate.subtract(Duration(days: difference));
  String previousDateString = "${previousDate.day}-${previousDate.month}-${previousDate.year}";
  return previousDateString;
}

Map<String, int> mapAsDate(String dateString){
  List<String> parts = dateString.split('-');
  int day = int.tryParse(parts[0]) ?? 0;
  int month = int.tryParse(parts[1]) ?? 0;
  int year = int.tryParse(parts[2]) ?? 0;
  return {'year':year, 'month':month, 'day':day};
}

String formatDate(String dateString){
  Map dateMap = mapAsDate(dateString);
  String monthName = getMonthName(dateMap['month']);
  String yearShort = dateMap['year'].toString().substring(2);
  return '${dateMap['day']}-$monthName-$yearShort';
}

String getMonthName(int month) {
  switch (month) {
    case 1:
      return 'Jan';
    case 2:
      return 'Feb';
    case 3:
      return 'Mar';
    case 4:
      return 'Apr';
    case 5:
      return 'May';
    case 6:
      return 'Jun';
    case 7:
      return 'Jul';
    case 8:
      return 'Aug';
    case 9:
      return 'Sep';
    case 10:
      return 'Oct';
    case 11:
      return 'Nov';
    case 12:
      return 'Dec';
    default:
      return '';
  }
}

String convertDateFormat(String date) {
  final parts = date.split('-');
  if (parts.length == 3) {
    final day = parts[0].padLeft(2, '0');
    final month = parts[1].padLeft(2, '0');
    final year = parts[2];
    return '$year-$month-$day';
  }
  return date;
}