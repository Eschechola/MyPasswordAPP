import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:mypassword/settings/settings.dart';

class BaseRepository{
  Future<Database> getDatabase() async{
    return openDatabase(
      join(await getDatabasesPath(), Settings.DATABASE_NAME),
      onCreate: (db, version) {
        db.execute(Settings.QUERY_CREATE_CUSTOMER_TABLE);
        db.execute(Settings.QUERY_CREATE_PASSWORD_TABLE);

        return;
      },
      version: 1,
    );
  }
}