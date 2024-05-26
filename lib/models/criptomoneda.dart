class Criptomoneda {
  final String symbol;
  final double priceChange;
  final double priceChangePercent;
  final double lastPrice;

  Criptomoneda({
    required this.symbol,
    required this.priceChange,
    required this.priceChangePercent,
    required this.lastPrice,
  });

  factory Criptomoneda.fromJson(Map<String, dynamic> json) {
    return Criptomoneda(
      symbol: json['symbol'],
      priceChange: double.parse(json['priceChange']),
      priceChangePercent: double.parse(json['priceChangePercent']),
      lastPrice: double.parse(json['lastPrice']),
    );
  }
}
