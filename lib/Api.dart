
class Product {
  final int id;
  final String title;
  final String description;
  final String category;
  final double price;
  final double discountPercentage;
  final double rating;
  final int stock;
  final List<String> tags;
  final String brand;
  final String sku;
  final int weight;
  final Map<String, double> dimensions;
  final String warrantyInformation;
  final String shippingInformation;
  final String availabilityStatus;
  final List<Review> reviews;
  final String returnPolicy;
  final int minimumOrderQuantity;
  final Meta meta;
  final List<String> images;
  final String thumbnail;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.tags,
    required this.brand,
    required this.sku,
    required this.weight,
    required this.dimensions,
    required this.warrantyInformation,
    required this.shippingInformation,
    required this.availabilityStatus,
    required this.reviews,
    required this.returnPolicy,
    required this.minimumOrderQuantity,
    required this.meta,
    required this.images,
    required this.thumbnail,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      title: json['title'] ?? 'No title',
      description: json['description'] ?? 'No description available',
      category: json['category'] ?? 'No category',
      price: (json['price'] ?? 0).toDouble(),
      discountPercentage: (json['discountPercentage'] ?? 0).toDouble(),
      rating: (json['rating'] ?? 0).toDouble(),
      stock: json['stock'] ?? 0,
      tags: List<String>.from(json['tags'] ?? []),
      brand: json['brand'] ?? 'No brand',
      sku: json['sku'] ?? 'No SKU',
      weight: json['weight'] ?? 0,
      dimensions: {
        "width": (json['dimensions']?['width'] ?? 0).toDouble(),
        "height": (json['dimensions']?['height'] ?? 0).toDouble(),
        "depth": (json['dimensions']?['depth'] ?? 0).toDouble(),
      },
      warrantyInformation: json['warrantyInformation'] ?? 'No warranty info',
      shippingInformation: json['shippingInformation'] ?? 'No shipping info',
      availabilityStatus: json['availabilityStatus'] ?? 'No status',
      reviews: (json['reviews'] as List?)
              ?.map((review) => Review.fromJson(review))
              .toList() ??
          [],
      returnPolicy: json['returnPolicy'] ?? 'No return policy',
      minimumOrderQuantity: json['minimumOrderQuantity'] ?? 0,
      meta: Meta.fromJson(json['meta'] ?? {}),
      images: List<String>.from(json['images'] ?? []),
      thumbnail: json['thumbnail'] ?? '',
    );
  }
}

class Review {
  final double rating;
  final String comment;
  final String date;
  final String reviewerName;
  final String reviewerEmail;

  Review({
    required this.rating,
    required this.comment,
    required this.date,
    required this.reviewerName,
    required this.reviewerEmail,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      rating: (json['rating'] ?? 0).toDouble(),
      comment: json['comment'] ?? 'No comment',
      date: json['date'] ?? 'No date',
      reviewerName: json['reviewerName'] ?? 'Anonymous',
      reviewerEmail: json['reviewerEmail'] ?? 'No email',
    );
  }
}

class Meta {
  final String createdAt;
  final String updatedAt;
  final String barcode;
  final String qrCode;

  Meta({
    required this.createdAt,
    required this.updatedAt,
    required this.barcode,
    required this.qrCode,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      createdAt: json['createdAt'] ?? 'Unknown',
      updatedAt: json['updatedAt'] ?? 'Unknown',
      barcode: json['barcode'] ?? 'No barcode',
      qrCode: json['qrCode'] ?? '',
    );
  }
}


class User {
  final String name;

  User({
    required this.name,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(name: json['firstName'],);
  }
}
