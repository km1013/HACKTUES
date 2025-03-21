
class CreditCard {
  final String brand;
  final String lastDigits;
  double balance;

  CreditCard({
    required this.brand,
    required this.lastDigits,
    required this.balance,
  });
}

class CreditCardService {
  static final CreditCardService _instance = CreditCardService._internal();

  factory CreditCardService() => _instance;

  CreditCardService._internal();

  List<CreditCard> cards = [
    CreditCard(brand: 'Visa', lastDigits: '5678', balance: 750.00),
    CreditCard(brand: 'Mastercard', lastDigits: '1234', balance: 500.00),
  ];

  double savings = 10000.00;

  void addToCard(int index, double amount) {
    if (index >= 0 && index < cards.length) {
      cards[index].balance += amount;
    }
  }

  void deductFromCard(int index, double amount) {
    if (index >= 0 && index < cards.length && cards[index].balance >= amount) {
      cards[index].balance -= amount;
    }
  }

  double getCardBalance(int index) {
    if (index >= 0 && index < cards.length) {
      return cards[index].balance;
    }
    return 0.0;
  }

  void deductFromSavings(double amount) {
    if (savings >= amount) {
      savings -= amount;
    }
  }

  void addToSavings(double amount) {
    savings += amount;
  }

  double getSavingsBalance() {
    return savings;
  }
}
