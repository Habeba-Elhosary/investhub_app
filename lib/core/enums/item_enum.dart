enum ItemType { offer, product }

ItemType getItemTypeFromString(String productType) {
  switch (productType) {
    case "product":
      return ItemType.product;
    case "offer":
      return ItemType.offer;
    default:
      return ItemType.product;
  }
}

String getItemTypeString(ItemType itemType) {
  switch (itemType) {
    case ItemType.offer:
      return 'offer';
    case ItemType.product:
      return 'product';
  }
}
