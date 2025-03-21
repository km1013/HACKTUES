class TransactionService {
  static final TransactionService _instance = TransactionService._internal();
  factory TransactionService() => _instance;
  TransactionService._internal();

  double _balance = 1000;
  double _income = 1000;
  double _expenses = 0;

  double get balance => _balance;
  double get income => _income;
  double get expenses => _expenses;

  void send(double amount) {
    if (amount <= _balance) {
      _balance -= amount;
      _income -= amount;   // Deduct from income
      _expenses += amount; // Add to expenses
    }
  }

  void request(double amount) {
    _balance += amount;
    _income += amount;
  }
}