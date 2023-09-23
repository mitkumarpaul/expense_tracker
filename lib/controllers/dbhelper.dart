import 'package:hive/hive.dart';

class DBHelper {
  late Box box;

  DBHelper() {
    openBox();
  }

  openBox() {
    box = Hive.box("money");
  }

  Future addData(int amt, DateTime dt, String note, String type) async {
    var val = {"amount": amt, "date": dt, "note": note, "type": type};
    box.add(val);
  }

  Future<Map> fetch() {
    if (box.values.isEmpty) {
      return Future.value({});
    } else {
      return Future.value(box.toMap());
    }
  }
}
