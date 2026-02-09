class BookingRoom {
  final int id;
  final String roomType;
  final double pricePerNight;
  final int maxGuests;

  BookingRoom({
    required this.id,
    required this.roomType,
    required this.pricePerNight,
    required this.maxGuests,
  });
}