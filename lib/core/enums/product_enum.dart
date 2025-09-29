enum ProductType { tires, batteries }

ProductType getProductTypeFromString(String productType) {
  switch (productType) {
    case "batteries":
      return ProductType.batteries;
    case "tires":
      return ProductType.tires;
    default:
      return ProductType.tires;
  }
}

String getProductTypeString(ProductType productType) {
  switch (productType) {
    case ProductType.batteries:
      return 'batteries';
    case ProductType.tires:
      return 'tires';
  }
}
