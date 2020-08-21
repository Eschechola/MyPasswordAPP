import 'package:mypassword/blocs/repository/base.repository.dart';
import 'package:mypassword/models/entities/customer.model.dart';
import 'package:mypassword/settings/settings.dart';
import 'package:sqflite/sqflite.dart';

class CustomerRepository extends BaseRepository{
  Future registerCustomer(Customer customer) async {
    try{
      Database _database = await getDatabase();

      await _database.insert(
        'customers',
        customer.toMap()
      );

      return true;
    }
    catch(ex){
      return false; 
    }
  }

  Future deleteAllCustomers() async {
    final Database _database = await getDatabase();
    
    await _database.query(Settings.QUERY_DELETE_ALL_CUSTOMERS);

    return;
  }
}