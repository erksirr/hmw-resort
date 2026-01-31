class RoomModel {
  final int id;
  final String name;
  final String detail;
  final double pricePerNight;
  final double? discountedPricePerNight;
  final double rating;
  final int maxGuests;
  final int roomSize;
  final bool isAvailable;
  final String imageUrl;
  final String createdAt;

  const RoomModel({
    required this.id,
    required this.name,
    required this.detail,
    required this.pricePerNight,
    this.discountedPricePerNight,
    required this.rating,
    required this.maxGuests,
    required this.roomSize,
    required this.isAvailable,
    required this.imageUrl,
    required this.createdAt,
  });

  factory RoomModel.fromJson(Map<String, dynamic> json) {
    return RoomModel(
      id: json['id'] is int
          ? json['id']
          : int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      name: json['name']?.toString() ?? '',
      detail: json['detail']?.toString() ?? '',
      pricePerNight: (json['pricePerNight'] is num)
          ? (json['pricePerNight'] as num).toDouble()
          : double.tryParse(json['pricePerNight']?.toString() ?? '0') ?? 0.0,
      discountedPricePerNight: json['discountedPricePerNight'] != null
          ? (json['discountedPricePerNight'] is num)
              ? (json['discountedPricePerNight'] as num).toDouble()
              : double.tryParse(json['discountedPricePerNight']?.toString() ?? '')
          : null,
      rating: (json['rating'] is num)
          ? (json['rating'] as num).toDouble()
          : double.tryParse(json['rating']?.toString() ?? '0') ?? 0.0,
      maxGuests: json['maxGuests'] is int
          ? json['maxGuests']
          : int.tryParse(json['maxGuests']?.toString() ?? '0') ?? 0,
      roomSize: json['roomSize'] is int
          ? json['roomSize']
          : int.tryParse(json['roomSize']?.toString() ?? '0') ?? 0,
      isAvailable: json['isAvailable'] == true,
      imageUrl: json['imageUrl']?.toString() ?? '',
      createdAt: json['createdAt']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'detail': detail,
      'pricePerNight': pricePerNight,
      'discountedPricePerNight': discountedPricePerNight,
      'rating': rating,
      'maxGuests': maxGuests,
      'roomSize': roomSize,
      'isAvailable': isAvailable,
      'imageUrl': imageUrl,
      'createdAt': createdAt,
    };
  }

  // Business logic
  int? get discountPercentage {
    if (discountedPricePerNight == null ||
        discountedPricePerNight! >= pricePerNight) {
      return null;
    }
    return ((1 - discountedPricePerNight! / pricePerNight) * 100).round();
  }

  double get displayPrice => discountedPricePerNight ?? pricePerNight;
}