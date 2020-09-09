class Settings{
  static const API_URL = "https://192.168.15.107:45455/api";
  static const DATABASE_NAME = "MYPASSWORD_APP.db";
  static const QUERY_DELETE_PASSWORD_TABLE = "DROP TABLE IF EXISTS passwords";
  static const QUERY_DELETE_CUSTOMER_TABLE = "DROP TABLE IF EXISTS customers";
  static const QUERY_CREATE_CUSTOMER_TABLE = "CREATE TABLE IF NOT EXISTS customers (id INTEGER PRIMARY KEY, name VARCHAR(40) NOT NULL, email VARCHAR(180) NOT NULL, password VARCHAR(180) NOT NULL, type INTEGER, remeber INTEGER, token VARCHAR(3000), tokenExpire DATETIME);";
  static const QUERY_CREATE_PASSWORD_TABLE = "CREATE TABLE IF NOT EXISTS passwords (id INTEGER PRIMARY KEY, customerId INTEGER NOT NULL, title VARCHAR(40) NOT NULL, value VARCHAR(180) NOT NULL)";
  static const QUERY_DELETE_ALL_CUSTOMERS = "DELETE FROM customers WHERE id > -1";
  static const QUERY_GET_ALL_CUSTOMERS_BY_EMAIL = "SELECT * FROM customers WHERE email = ";
  static const ERROR_API_MESSAGE = "Ocorreu algum erro ao se comunicar com a base de dados. Tente novamente.";
  static const INVALID_INPUTS_MESSAGE = "Campos inválidos, corrija e tente novamente";
  static const NOT_ACCEPT_USE_TERMS = "Você precisa aceitar os TERMOS DE USO.";
}