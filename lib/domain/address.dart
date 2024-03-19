class Address {
  final String street;
  final int number;
  final String city;
  final int zipcode;
  final String country;

  Address({
    required this.street,
    required this.number,
    required this.city,
    required this.zipcode,
    this.country = 'Belgium', // Default country
  });

  Map<String, dynamic> toMap() {
    return {
      'street': street,
      'number': number,
      'city': city,
      'zipcode': zipcode,
      'country': country,
    };
  }

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      street: map['street'],
      number: map['number'],
      city: map['city'],
      zipcode: map['zipcode'],
      country: map['country'] ?? 'Belgium', // Default to 'Belgium' if not provided
    );
  }

  // Static method to create a default address
  static Address defaultAddress() {
    return Address(
      street: 'Elfde-Liniestraat',
      number: 24, // You can set a different default value if needed
      city: 'Hasselt',
      zipcode: 3500, // You can set a different default value if needed
      country: 'Belgium', // Default country
    );
  }
}
