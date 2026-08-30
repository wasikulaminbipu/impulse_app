import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:impulse_app/models/product.dart';


part 'product_model.freezed.dart';

@freezed
abstract class Product with _$Product {
  const factory Product({
    required int id,
    required String titleEn,
    String? titleBn,
    required String slug,
    required int categoryId,
    @Default([]) List<int> targetGroupIds,
    int? manufacturerId,
    String? imageUrl,
    String? mottoEn,
    String? mottoBn,
    String? compositionBasisEn,
    String? compositionBasisBn,
    String? shortDescriptionEn,
    String? shortDescriptionBn,
    @Default(1) int isActive,
    required String createdAt,
    required String updatedAt,
    @Default([]) List<Composition> compositions,
    @Default([]) List<Indication> indications,
    @Default([]) List<Direction> directions,
    @Default([]) List<Precaution> precautions,
    @Default([]) List<Presentation> presentations,
    @Default(Manufacturer.empty()) Manufacturer manufacturer,
    @Default(Category.empty()) Category category,
    @Default([]) List<TargetGroup> targetGroups,
  }) = _Product;

  const Product._();

  factory Product.fromRow(Map<String, dynamic> row) => Product(
    id: row['id'] as int,
    titleEn: row['title_en'] as String,
    titleBn: row['title_bn'] as String?,
    slug: row['slug'] as String,
    categoryId: row['category_id'] as int,
    manufacturerId: row['manufacturer_id'] as int?,
    imageUrl: row['image_url'] as String?,
    mottoEn: row['motto_en'] as String?,
    mottoBn: row['motto_bn'] as String?,
    compositionBasisEn: row['composition_basis_en'] as String?,
    compositionBasisBn: row['composition_basis_bn'] as String?,
    shortDescriptionEn: row['short_description_en'] as String?,
    shortDescriptionBn: row['short_description_bn'] as String?,
    isActive: row['is_active'] as int,
    createdAt: row['created_at'] as String,
    updatedAt: row['updated_at'] as String,
  );

  ProductLabel toLabel() => ProductLabel(
    id: id,
    titleEn: titleEn,
    titleBn: titleBn,
    shortDescriptionEn: shortDescriptionEn,
    shortDescriptionBn: shortDescriptionBn,
    mottoEn: mottoEn,
    mottoBn: mottoBn,
    categoryId: categoryId,
    category: category,
    targetGroupIds: targetGroupIds,
    targetGroups: targetGroups,
    presentations: presentations,
    imageUrl: imageUrl,
  );
}
