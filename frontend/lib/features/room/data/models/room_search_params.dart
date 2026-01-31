class RoomSearchParams {
  final double? minPrice;
  final double? maxPrice;
  final double? rating;
  final int? minGuests;
  final int? maxGuests;
  final int limit;
  final String sortBy;

  const RoomSearchParams({
    this.minPrice,
    this.maxPrice,
    this.rating,
    this.minGuests,
    this.maxGuests,
    this.limit = 10,
    this.sortBy = 'createdAt',
  });

  RoomSearchParams copyWith({
    double? minPrice,
    double? maxPrice,
    double? rating,
    int? minGuests,
    int? maxGuests,
    int? limit,
    String? sortBy,
  }) {
    return RoomSearchParams(
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      rating: rating ?? this.rating,
      minGuests: minGuests ?? this.minGuests,
      maxGuests: maxGuests ?? this.maxGuests,
      limit: limit ?? this.limit,
      sortBy: sortBy ?? this.sortBy,
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{
      'limit': limit,
      'sortBy': sortBy,
    };

    if (minPrice != null) map['minPrice'] = minPrice;
    if (maxPrice != null) map['maxPrice'] = maxPrice;
    if (rating != null) map['rating'] = rating;
    if (minGuests != null) map['minGuests'] = minGuests;
    if (maxGuests != null) map['maxGuests'] = maxGuests;

    return map;
  }
}