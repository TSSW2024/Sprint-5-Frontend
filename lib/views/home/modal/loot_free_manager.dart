class LootConfig {
  final int hours;
  final int minutes;

  LootConfig({required this.hours, required this.minutes});
}

class LootFreeManager {
  final Map<String, LootConfig> lootConfigs;

  LootFreeManager(this.lootConfigs);

  bool isLootFreeAvailable() {
    DateTime now = DateTime.now();
    return _isLootTime(now, lootConfigs['loot1']!) || _isLootTime(now, lootConfigs['loot2']!);
  }

  Duration timeUntilNextLoot(String lootKey) {
    DateTime now = DateTime.now();
    DateTime nextLootTime = _getNextLootTime(now, lootConfigs['loot1']!, lootConfigs['loot2']!);
    return nextLootTime.difference(now);
  }

  bool _isLootTime(DateTime currentTime, LootConfig lootConfig) {
    return currentTime.hour == lootConfig.hours && currentTime.minute == lootConfig.minutes;
  }

 DateTime _getNextLootTime(DateTime currentTime, LootConfig loot1Config, LootConfig loot2Config) {
  DateTime nextLoot1Time = DateTime(currentTime.year, currentTime.month, currentTime.day, loot1Config.hours, loot1Config.minutes);
  DateTime nextLoot2Time = DateTime(currentTime.year, currentTime.month, currentTime.day, loot2Config.hours, loot2Config.minutes);

  // Ajustar los tiempos al día siguiente si están en el pasado con respecto a la hora actual
  if (nextLoot1Time.isBefore(currentTime)) {
    nextLoot1Time = nextLoot1Time.add(Duration(days: 1));
  }
  if (nextLoot2Time.isBefore(currentTime)) {
    nextLoot2Time = nextLoot2Time.add(Duration(days: 1));
  }

  // Determinar cuál es el próximo loot más cercano en el futuro con respecto al tiempo actual
  DateTime nextLootTime = nextLoot1Time.isBefore(nextLoot2Time) ? nextLoot1Time : nextLoot2Time;

  return nextLootTime;
}
}