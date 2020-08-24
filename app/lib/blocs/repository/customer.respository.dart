import 'package:mypassword/blocs/repository/base.repository.dart';
import 'package:mypassword/models/entities/customer.model.dart';
import 'package:sqflite/sqflite.dart';

class CustomerRepository extends BaseRepository{

  Future insertCustomer(Customer customer) async {
    Database _database = await getDatabase();

    await _database.insert(
      'customers',
        customer.toMap()
    );
  }

  Future updateCustomer(dynamic customer) async{
    Database _database = await getDatabase();

    var customerExists = await getByEmail(customer['email']);

    var customerUpdated = new Customer(
      id:  customerExists.first.row[0],
      name: customer['name'],
      email: customer['email'],
      password: customer['password'],
      type: customer['type'],
      token: customer['token'],
      tokenExpireDate: customer['tokenExpires']
    );

    await _database.update(
        'customers',
        customerUpdated.toMap(),
        where: "id = ?",
        whereArgs: [customerExists.first.row[0]],
    );
  }

  Future deleteCustomer(int id) async {
    final Database _database = await getDatabase();

    await _database.delete(
      'customers',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future getByEmail(String email) async{
    Database _database = await getDatabase();

    return _database.query("customers WHERE email = '${email}'");
  }

  Future getLoggedCustomer() async{
    Database _database = await getDatabase();
    return null;
  }
}