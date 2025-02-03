class Product {
    int id;
    String name;
    double price;
    Currency currency;
    String makingTime;
    double rating;
    int ratingCount;
    String imageUrl;

    Product({
        required this.id,
        required this.name,
        required this.price,
        required this.currency,
        required this.makingTime,
        required this.rating,
        required this.ratingCount,
        required this.imageUrl,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        price: json["price"]?.toDouble(),
        currency: currencyValues.map[json["currency"]]!,
        makingTime: json["making_time"],
        rating: json["rating"]?.toDouble(),
        ratingCount: json["rating_count"],
        imageUrl: json["image_url"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "currency": currencyValues.reverse[currency],
        "making_time": makingTime,
        "rating": rating,
        "rating_count": ratingCount,
        "image_url": imageUrl,
    };
}

enum Currency {
    BHD
}

final currencyValues = EnumValues({
    "BHD": Currency.BHD
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
