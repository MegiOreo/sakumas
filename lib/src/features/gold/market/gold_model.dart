import 'package:cloud_firestore/cloud_firestore.dart';

class GoldModel {
  final DateTime date;
  //final double price;
  final Map<String, double> prices;

  const GoldModel({
    required this.date,
    required this.prices,

  });

  // factory GoldModel.fromMap(Map<String, dynamic> map) {
  //   return GoldModel(
  //     //date: DateTime.parse(map['date'] as String),
  //     date: (map['date'] as Timestamp).toDate(),
  //     price: (map['price'] as num).toDouble(),
  //   );
  // }
  factory GoldModel.fromMap(Map<String, dynamic> map) {
    final rawPrices = map['prices'] as Map<String, dynamic>;

    return GoldModel(
      date: (map['date'] as Timestamp).toDate(),
      prices: rawPrices.map(
            (key, value) => MapEntry(
          key,
          (value as num).toDouble(),
        ),
      ),
    );
  }
}

  // Map<String, dynamic> toMap() {
  //   return {
  //     'date': Timestamp.fromDate(date)
  //     'price': price,
  //   };
  // }

  // GoldModel copyWith({
  //   DateTime? date,
  //   double? price,
  // }) {
  //   return GoldModel(
  //     date: date ?? this.date,
  //     price: price ?? this.price,
  //   );
  // }

//   @override
//   String toString() => 'GoldModel(date: $date, price: $price)';
//
//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//           other is GoldModel &&
//               runtimeType == other.runtimeType &&
//               date == other.date &&
//               price == other.price;
//
//   @override
//   int get hashCode => Object.hash(date, price);//date.hashCode ^ price.hashCode;
// }