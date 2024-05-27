class Criptomoneda {
  final String symbol;
  final double lastPrice;

  Criptomoneda({
    required this.symbol,
    required this.lastPrice,
  });

  factory Criptomoneda.fromJson(String symbol, Map<String, dynamic> json) {
    return Criptomoneda(
      symbol: symbol,
      lastPrice:
          (json[symbol] as num).toDouble(), // Asegúrate de convertir a double
    );
  }
}
