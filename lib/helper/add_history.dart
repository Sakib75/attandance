history(bool activity) {
  var now = DateTime.now().millisecondsSinceEpoch;
  String final_string =
      activity == true ? 'Y' + now.toString() : 'N' + now.toString();

  return final_string;
}
