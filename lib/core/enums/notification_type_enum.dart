enum NotificationType { all, order, offers }

NotificationType getNotificationTypeFromString(String notificationType) {
  switch (notificationType) {
    case "all":
      return NotificationType.all;
    case "order":
      return NotificationType.order;
    case "offers":
      return NotificationType.offers;
    default:
      return NotificationType.all;
  }
}
