class Product{
  int id;
  String image;
  String name;
  String description;
  double price;

  Product(this.id,this.image, this.name, this.description, this.price);
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      int.parse(json['ID'].toString()),
      json['Image'].toString().replaceFirst("%2520","_"),
      json['Title'],
      json['Description'],
      double.parse(json['Price'].toString()),
    );
  }
  @override
  String toString(){
    return "{id: "+id.toString()+", image: "+image+", name: "+name+", description: "+description+", price: "+price.toString()+"}";
  }
}