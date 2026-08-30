import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:impulse_app/models/product.dart';


part 'product_label.freezed.dart';

@freezed
abstract class ProductLabel with _$ProductLabel {
  const factory ProductLabel({
    required int id,
    required String titleEn,
    String? titleBn,
    String? shortDescriptionEn,
    String? shortDescriptionBn,
    String? mottoEn,
    String? mottoBn,
    required int categoryId,
    @Default(Category.empty()) Category category,
    @Default([]) List<int> targetGroupIds,
    @Default([]) List<TargetGroup> targetGroups,
    @Default([]) List<Presentation> presentations,
    @Default(false) bool isFavourite,
    String? imageUrl,
  }) = _ProductLabel;

  const ProductLabel._();

  String? get fullImageUrl {
    final url = imageUrl?.trim();
    if (url == null || url.isEmpty) return null;
    if (url.startsWith('assets/')) return url;
    if (url.startsWith('product_image/')) return 'assets/$url';
    return 'assets/product_image/$url';
  }

  factory ProductLabel.fromRow(Map<String, dynamic> row) => ProductLabel(
    id: row['id'] as int,
    titleEn: row['title_en'] as String,
    titleBn: row['title_bn'] as String?,
    shortDescriptionEn: row['short_description_en'] as String?,
    shortDescriptionBn: row['short_description_bn'] as String?,
    mottoEn: row['motto_en'] as String?,
    mottoBn: row['motto_bn'] as String?,
    categoryId: row['category_id'] as int,
    imageUrl: row['image_url'] as String?,
  );
}
