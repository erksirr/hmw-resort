class RoomSearchParams {
  final String? query;
  final double? minPrice;
  final double? maxPrice;
  final double? rating;
  final int? minGuests;
  final int? maxGuests;
  final String sortBy;

  const RoomSearchParams({
    this.query,
    this.minPrice,
    this.maxPrice,
    this.rating,
    this.minGuests,
    this.maxGuests,
    this.sortBy = 'createdAt',
  });

  RoomSearchParams copyWith({
    String? query,
    double? minPrice,
    double? maxPrice,
    double? rating,
    int? minGuests,
    int? maxGuests,
    String? sortBy,
  }) {
    return RoomSearchParams(
      query: query ?? this.query,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      rating: rating ?? this.rating,
      minGuests: minGuests ?? this.minGuests,
      maxGuests: maxGuests ?? this.maxGuests,
      sortBy: sortBy ?? this.sortBy,
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{
      'sortBy': sortBy,
    };

    if (query != null && query!.isNotEmpty) map['query'] = query;
    if (minPrice != null) map['minPrice'] = minPrice;
    if (maxPrice != null) map['maxPrice'] = maxPrice;
    if (rating != null) map['rating'] = rating;
    if (minGuests != null) map['minGuests'] = minGuests;
    if (maxGuests != null) map['maxGuests'] = maxGuests;

    return map;
  }
}