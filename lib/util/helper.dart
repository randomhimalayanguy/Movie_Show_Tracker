String dateFormatter(String date) {
  List<String> li = date.split("-");
  if (li.length != 3) return date;
  String res = "${li[2]}-${li[1]}-${li[0]}";
  return res;
}

String timeFormatter(int runtime) {
  int hr = runtime ~/ 60;
  int min = runtime % 60;
  if (hr == 0) {
    return "$min minutes";
  } else if (hr == 1) {
    return "$hr hour $min minutes";
  } else {
    return "$hr hours $min minutes";
  }
}
