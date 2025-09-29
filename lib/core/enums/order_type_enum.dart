import 'package:investhub_app/core/constant/values/colors.dart';
import 'package:investhub_app/generated/LocaleKeys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

enum OrderType { pending, processing, completed, cancelled }

OrderType getOrderTypeFromString(String orderType) {
  switch (orderType) {
    case "pending":
      return OrderType.pending;
    case "cancelled":
      return OrderType.cancelled;
    case "completed":
      return OrderType.completed;
    case "processing":
      return OrderType.processing;
    default:
      return OrderType.pending;
  }
}

String getOrderTypeString(OrderType orderType) {
  switch (orderType) {
    case OrderType.pending:
      return 'pending';
    case OrderType.cancelled:
      return 'cancelled';
    case OrderType.completed:
      return 'completed';
    case OrderType.processing:
      return 'processing';
  }
}

extension OrderTypeExtension on OrderType {
  String get label {
    switch (this) {
      case OrderType.pending:
        return LocaleKeys.order_pending.tr();
      case OrderType.processing:
        return LocaleKeys.order_processing.tr();
      case OrderType.completed:
        return LocaleKeys.order_completed.tr();
      case OrderType.cancelled:
        return LocaleKeys.order_cancelled.tr();
    }
  }

  Color get color {
    switch (this) {
      case OrderType.pending:
        return AppColors.blue;
      case OrderType.processing:
        return AppColors.orange;
      case OrderType.completed:
        return AppColors.green;
      case OrderType.cancelled:
        return AppColors.red;
    }
  }
}
