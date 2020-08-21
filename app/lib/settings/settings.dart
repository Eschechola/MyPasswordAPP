class Settings{
  static const API_URL = "https://192.168.15.107:45455";
  static const DATABASE_NAME = "MYPASSWORD_APP.db";
  static const QUERY_CREATE_CUSTOMER_TABLE = "CREATE TABLE IF NOT EXISTS customers (id INTEGER PRIMARY KEY, name VARCHAR(40) NOT NULL, email VARCHAR(180) NOT NULL, password VARCHAR(180) NOT NULL, type INTEGER);";
  static const QUERY_CREATE_PASSWORD_TABLE = "CREATE TABLE IF NOT EXISTS passwords (id INTEGER PRIMARY KEY, customerId INTEGER NOT NULL, title VARCHAR(40) NOT NULL, value VARCHAR(MAX) NOT NULL)";
  static const QUERY_DELETE_ALL_CUSTOMERS = "DELETE FROM customers WHERE id > -1";
  static const ERROR_API_MESSAGE = "Ocorreu algum erro ao se comunicar com a base de dados. Tente novamente.";
  static var INVALID_INPUTS_MESSAGE = "Campos inválidos, corrija e tente novamente";
}