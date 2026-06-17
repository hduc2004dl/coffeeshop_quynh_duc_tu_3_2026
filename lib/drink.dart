class Drink {
  final String id;
  final String name;
  final String emoji;
  final String category;
  final String caffeine;
  final String description;
  final int price;
  final bool isBestSeller;
  final bool isAvailable;

  const Drink({
    required this.id,
    required this.name,
    required this.emoji,
    required this.category,
    required this.caffeine,
    required this.description,
    required this.price,
    this.isBestSeller = false,
    this.isAvailable = true,
  });

  String get formattedPrice => '${price ~/ 1000}K';

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'emoji': emoji,
      'category': category,
      'caffeine': caffeine,
      'description': description,
      'price': price,
      'isBestSeller': isBestSeller,
      'isAvailable': isAvailable,
    };
  }

  factory Drink.fromMap(Map<dynamic, dynamic> map) {
    return Drink(
      id: map['id']?.toString() ?? '',
      name: map['name']?.toString() ?? '',
      emoji: map['emoji']?.toString() ?? '☕',
      category: map['category']?.toString() ?? 'Khác',
      caffeine: map['caffeine']?.toString() ?? 'Không rõ',
      description: map['description']?.toString() ?? '',
      price: int.tryParse(map['price']?.toString() ?? '') ?? 0,
      isBestSeller: map['isBestSeller'] == true,
      isAvailable: map['isAvailable'] != false,
    );
  }

  Drink copyWith({
    String? id,
    String? name,
    String? emoji,
    String? category,
    String? caffeine,
    String? description,
    int? price,
    bool? isBestSeller,
    bool? isAvailable,
  }) {
    return Drink(
      id: id ?? this.id,
      name: name ?? this.name,
      emoji: emoji ?? this.emoji,
      category: category ?? this.category,
      caffeine: caffeine ?? this.caffeine,
      description: description ?? this.description,
      price: price ?? this.price,
      isBestSeller: isBestSeller ?? this.isBestSeller,
      isAvailable: isAvailable ?? this.isAvailable,
    );
  }

  static const String storeName = 'Starbucks Vietnam';
  static const int maxOrderQuantity = 20;
}
