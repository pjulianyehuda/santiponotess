part of 'models.dart';

class Products{
  final String productId;
  final String productName;
  final String productPrice;
  final String productDescription;
  final String productImg;
  final String addBy;
  final String createdAt;
  final String updatedAt;

  Products(
    this.productId,
    this.productName,
    this.productPrice,
    this.productDescription,
    this.productImg,
    this.addBy,
    this.createdAt,
    this.updatedAt,
  );

  @override
  List<Object> get props =>[
    productId,
    productName,
    productPrice,
    productDescription,
    productImg,
    addBy,
    createdAt,
    updatedAt,
  ];
  
}