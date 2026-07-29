// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Product {

 int get id; String get titleEn; String? get titleBn; String get slug; int get categoryId; List<int> get targetGroupIds; int? get manufacturerId; String? get imageUrl; String? get mottoEn; String? get mottoBn; String? get compositionBasisEn; String? get compositionBasisBn; String? get shortDescriptionEn; String? get shortDescriptionBn; int get isActive; String get createdAt; String get updatedAt; List<Composition> get compositions; List<Indication> get indications; List<Direction> get directions; List<Precaution> get precautions; List<Presentation> get presentations; Manufacturer get manufacturer; Category get category; List<TargetGroup> get targetGroups;
/// Create a copy of Product
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductCopyWith<Product> get copyWith => _$ProductCopyWithImpl<Product>(this as Product, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Product&&(identical(other.id, id) || other.id == id)&&(identical(other.titleEn, titleEn) || other.titleEn == titleEn)&&(identical(other.titleBn, titleBn) || other.titleBn == titleBn)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&const DeepCollectionEquality().equals(other.targetGroupIds, targetGroupIds)&&(identical(other.manufacturerId, manufacturerId) || other.manufacturerId == manufacturerId)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.mottoEn, mottoEn) || other.mottoEn == mottoEn)&&(identical(other.mottoBn, mottoBn) || other.mottoBn == mottoBn)&&(identical(other.compositionBasisEn, compositionBasisEn) || other.compositionBasisEn == compositionBasisEn)&&(identical(other.compositionBasisBn, compositionBasisBn) || other.compositionBasisBn == compositionBasisBn)&&(identical(other.shortDescriptionEn, shortDescriptionEn) || other.shortDescriptionEn == shortDescriptionEn)&&(identical(other.shortDescriptionBn, shortDescriptionBn) || other.shortDescriptionBn == shortDescriptionBn)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other.compositions, compositions)&&const DeepCollectionEquality().equals(other.indications, indications)&&const DeepCollectionEquality().equals(other.directions, directions)&&const DeepCollectionEquality().equals(other.precautions, precautions)&&const DeepCollectionEquality().equals(other.presentations, presentations)&&(identical(other.manufacturer, manufacturer) || other.manufacturer == manufacturer)&&(identical(other.category, category) || other.category == category)&&const DeepCollectionEquality().equals(other.targetGroups, targetGroups));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,titleEn,titleBn,slug,categoryId,const DeepCollectionEquality().hash(targetGroupIds),manufacturerId,imageUrl,mottoEn,mottoBn,compositionBasisEn,compositionBasisBn,shortDescriptionEn,shortDescriptionBn,isActive,createdAt,updatedAt,const DeepCollectionEquality().hash(compositions),const DeepCollectionEquality().hash(indications),const DeepCollectionEquality().hash(directions),const DeepCollectionEquality().hash(precautions),const DeepCollectionEquality().hash(presentations),manufacturer,category,const DeepCollectionEquality().hash(targetGroups)]);

@override
String toString() {
  return 'Product(id: $id, titleEn: $titleEn, titleBn: $titleBn, slug: $slug, categoryId: $categoryId, targetGroupIds: $targetGroupIds, manufacturerId: $manufacturerId, imageUrl: $imageUrl, mottoEn: $mottoEn, mottoBn: $mottoBn, compositionBasisEn: $compositionBasisEn, compositionBasisBn: $compositionBasisBn, shortDescriptionEn: $shortDescriptionEn, shortDescriptionBn: $shortDescriptionBn, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt, compositions: $compositions, indications: $indications, directions: $directions, precautions: $precautions, presentations: $presentations, manufacturer: $manufacturer, category: $category, targetGroups: $targetGroups)';
}


}

/// @nodoc
abstract mixin class $ProductCopyWith<$Res>  {
  factory $ProductCopyWith(Product value, $Res Function(Product) _then) = _$ProductCopyWithImpl;
@useResult
$Res call({
 int id, String titleEn, String? titleBn, String slug, int categoryId, List<int> targetGroupIds, int? manufacturerId, String? imageUrl, String? mottoEn, String? mottoBn, String? compositionBasisEn, String? compositionBasisBn, String? shortDescriptionEn, String? shortDescriptionBn, int isActive, String createdAt, String updatedAt, List<Composition> compositions, List<Indication> indications, List<Direction> directions, List<Precaution> precautions, List<Presentation> presentations, Manufacturer manufacturer, Category category, List<TargetGroup> targetGroups
});


$ManufacturerCopyWith<$Res> get manufacturer;$CategoryCopyWith<$Res> get category;

}
/// @nodoc
class _$ProductCopyWithImpl<$Res>
    implements $ProductCopyWith<$Res> {
  _$ProductCopyWithImpl(this._self, this._then);

  final Product _self;
  final $Res Function(Product) _then;

/// Create a copy of Product
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? titleEn = null,Object? titleBn = freezed,Object? slug = null,Object? categoryId = null,Object? targetGroupIds = null,Object? manufacturerId = freezed,Object? imageUrl = freezed,Object? mottoEn = freezed,Object? mottoBn = freezed,Object? compositionBasisEn = freezed,Object? compositionBasisBn = freezed,Object? shortDescriptionEn = freezed,Object? shortDescriptionBn = freezed,Object? isActive = null,Object? createdAt = null,Object? updatedAt = null,Object? compositions = null,Object? indications = null,Object? directions = null,Object? precautions = null,Object? presentations = null,Object? manufacturer = null,Object? category = null,Object? targetGroups = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,titleEn: null == titleEn ? _self.titleEn : titleEn // ignore: cast_nullable_to_non_nullable
as String,titleBn: freezed == titleBn ? _self.titleBn : titleBn // ignore: cast_nullable_to_non_nullable
as String?,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as int,targetGroupIds: null == targetGroupIds ? _self.targetGroupIds : targetGroupIds // ignore: cast_nullable_to_non_nullable
as List<int>,manufacturerId: freezed == manufacturerId ? _self.manufacturerId : manufacturerId // ignore: cast_nullable_to_non_nullable
as int?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,mottoEn: freezed == mottoEn ? _self.mottoEn : mottoEn // ignore: cast_nullable_to_non_nullable
as String?,mottoBn: freezed == mottoBn ? _self.mottoBn : mottoBn // ignore: cast_nullable_to_non_nullable
as String?,compositionBasisEn: freezed == compositionBasisEn ? _self.compositionBasisEn : compositionBasisEn // ignore: cast_nullable_to_non_nullable
as String?,compositionBasisBn: freezed == compositionBasisBn ? _self.compositionBasisBn : compositionBasisBn // ignore: cast_nullable_to_non_nullable
as String?,shortDescriptionEn: freezed == shortDescriptionEn ? _self.shortDescriptionEn : shortDescriptionEn // ignore: cast_nullable_to_non_nullable
as String?,shortDescriptionBn: freezed == shortDescriptionBn ? _self.shortDescriptionBn : shortDescriptionBn // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,compositions: null == compositions ? _self.compositions : compositions // ignore: cast_nullable_to_non_nullable
as List<Composition>,indications: null == indications ? _self.indications : indications // ignore: cast_nullable_to_non_nullable
as List<Indication>,directions: null == directions ? _self.directions : directions // ignore: cast_nullable_to_non_nullable
as List<Direction>,precautions: null == precautions ? _self.precautions : precautions // ignore: cast_nullable_to_non_nullable
as List<Precaution>,presentations: null == presentations ? _self.presentations : presentations // ignore: cast_nullable_to_non_nullable
as List<Presentation>,manufacturer: null == manufacturer ? _self.manufacturer : manufacturer // ignore: cast_nullable_to_non_nullable
as Manufacturer,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as Category,targetGroups: null == targetGroups ? _self.targetGroups : targetGroups // ignore: cast_nullable_to_non_nullable
as List<TargetGroup>,
  ));
}
/// Create a copy of Product
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ManufacturerCopyWith<$Res> get manufacturer {
  
  return $ManufacturerCopyWith<$Res>(_self.manufacturer, (value) {
    return _then(_self.copyWith(manufacturer: value));
  });
}/// Create a copy of Product
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CategoryCopyWith<$Res> get category {
  
  return $CategoryCopyWith<$Res>(_self.category, (value) {
    return _then(_self.copyWith(category: value));
  });
}
}


/// Adds pattern-matching-related methods to [Product].
extension ProductPatterns on Product {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Product value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Product() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Product value)  $default,){
final _that = this;
switch (_that) {
case _Product():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Product value)?  $default,){
final _that = this;
switch (_that) {
case _Product() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String titleEn,  String? titleBn,  String slug,  int categoryId,  List<int> targetGroupIds,  int? manufacturerId,  String? imageUrl,  String? mottoEn,  String? mottoBn,  String? compositionBasisEn,  String? compositionBasisBn,  String? shortDescriptionEn,  String? shortDescriptionBn,  int isActive,  String createdAt,  String updatedAt,  List<Composition> compositions,  List<Indication> indications,  List<Direction> directions,  List<Precaution> precautions,  List<Presentation> presentations,  Manufacturer manufacturer,  Category category,  List<TargetGroup> targetGroups)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Product() when $default != null:
return $default(_that.id,_that.titleEn,_that.titleBn,_that.slug,_that.categoryId,_that.targetGroupIds,_that.manufacturerId,_that.imageUrl,_that.mottoEn,_that.mottoBn,_that.compositionBasisEn,_that.compositionBasisBn,_that.shortDescriptionEn,_that.shortDescriptionBn,_that.isActive,_that.createdAt,_that.updatedAt,_that.compositions,_that.indications,_that.directions,_that.precautions,_that.presentations,_that.manufacturer,_that.category,_that.targetGroups);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String titleEn,  String? titleBn,  String slug,  int categoryId,  List<int> targetGroupIds,  int? manufacturerId,  String? imageUrl,  String? mottoEn,  String? mottoBn,  String? compositionBasisEn,  String? compositionBasisBn,  String? shortDescriptionEn,  String? shortDescriptionBn,  int isActive,  String createdAt,  String updatedAt,  List<Composition> compositions,  List<Indication> indications,  List<Direction> directions,  List<Precaution> precautions,  List<Presentation> presentations,  Manufacturer manufacturer,  Category category,  List<TargetGroup> targetGroups)  $default,) {final _that = this;
switch (_that) {
case _Product():
return $default(_that.id,_that.titleEn,_that.titleBn,_that.slug,_that.categoryId,_that.targetGroupIds,_that.manufacturerId,_that.imageUrl,_that.mottoEn,_that.mottoBn,_that.compositionBasisEn,_that.compositionBasisBn,_that.shortDescriptionEn,_that.shortDescriptionBn,_that.isActive,_that.createdAt,_that.updatedAt,_that.compositions,_that.indications,_that.directions,_that.precautions,_that.presentations,_that.manufacturer,_that.category,_that.targetGroups);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String titleEn,  String? titleBn,  String slug,  int categoryId,  List<int> targetGroupIds,  int? manufacturerId,  String? imageUrl,  String? mottoEn,  String? mottoBn,  String? compositionBasisEn,  String? compositionBasisBn,  String? shortDescriptionEn,  String? shortDescriptionBn,  int isActive,  String createdAt,  String updatedAt,  List<Composition> compositions,  List<Indication> indications,  List<Direction> directions,  List<Precaution> precautions,  List<Presentation> presentations,  Manufacturer manufacturer,  Category category,  List<TargetGroup> targetGroups)?  $default,) {final _that = this;
switch (_that) {
case _Product() when $default != null:
return $default(_that.id,_that.titleEn,_that.titleBn,_that.slug,_that.categoryId,_that.targetGroupIds,_that.manufacturerId,_that.imageUrl,_that.mottoEn,_that.mottoBn,_that.compositionBasisEn,_that.compositionBasisBn,_that.shortDescriptionEn,_that.shortDescriptionBn,_that.isActive,_that.createdAt,_that.updatedAt,_that.compositions,_that.indications,_that.directions,_that.precautions,_that.presentations,_that.manufacturer,_that.category,_that.targetGroups);case _:
  return null;

}
}

}

/// @nodoc


class _Product extends Product {
  const _Product({required this.id, required this.titleEn, this.titleBn, required this.slug, required this.categoryId, final  List<int> targetGroupIds = const [], this.manufacturerId, this.imageUrl, this.mottoEn, this.mottoBn, this.compositionBasisEn, this.compositionBasisBn, this.shortDescriptionEn, this.shortDescriptionBn, this.isActive = 1, required this.createdAt, required this.updatedAt, final  List<Composition> compositions = const [], final  List<Indication> indications = const [], final  List<Direction> directions = const [], final  List<Precaution> precautions = const [], final  List<Presentation> presentations = const [], this.manufacturer = const Manufacturer.empty(), this.category = const Category.empty(), final  List<TargetGroup> targetGroups = const []}): _targetGroupIds = targetGroupIds,_compositions = compositions,_indications = indications,_directions = directions,_precautions = precautions,_presentations = presentations,_targetGroups = targetGroups,super._();
  

@override final  int id;
@override final  String titleEn;
@override final  String? titleBn;
@override final  String slug;
@override final  int categoryId;
 final  List<int> _targetGroupIds;
@override@JsonKey() List<int> get targetGroupIds {
  if (_targetGroupIds is EqualUnmodifiableListView) return _targetGroupIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_targetGroupIds);
}

@override final  int? manufacturerId;
@override final  String? imageUrl;
@override final  String? mottoEn;
@override final  String? mottoBn;
@override final  String? compositionBasisEn;
@override final  String? compositionBasisBn;
@override final  String? shortDescriptionEn;
@override final  String? shortDescriptionBn;
@override@JsonKey() final  int isActive;
@override final  String createdAt;
@override final  String updatedAt;
 final  List<Composition> _compositions;
@override@JsonKey() List<Composition> get compositions {
  if (_compositions is EqualUnmodifiableListView) return _compositions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_compositions);
}

 final  List<Indication> _indications;
@override@JsonKey() List<Indication> get indications {
  if (_indications is EqualUnmodifiableListView) return _indications;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_indications);
}

 final  List<Direction> _directions;
@override@JsonKey() List<Direction> get directions {
  if (_directions is EqualUnmodifiableListView) return _directions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_directions);
}

 final  List<Precaution> _precautions;
@override@JsonKey() List<Precaution> get precautions {
  if (_precautions is EqualUnmodifiableListView) return _precautions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_precautions);
}

 final  List<Presentation> _presentations;
@override@JsonKey() List<Presentation> get presentations {
  if (_presentations is EqualUnmodifiableListView) return _presentations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_presentations);
}

@override@JsonKey() final  Manufacturer manufacturer;
@override@JsonKey() final  Category category;
 final  List<TargetGroup> _targetGroups;
@override@JsonKey() List<TargetGroup> get targetGroups {
  if (_targetGroups is EqualUnmodifiableListView) return _targetGroups;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_targetGroups);
}


/// Create a copy of Product
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductCopyWith<_Product> get copyWith => __$ProductCopyWithImpl<_Product>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Product&&(identical(other.id, id) || other.id == id)&&(identical(other.titleEn, titleEn) || other.titleEn == titleEn)&&(identical(other.titleBn, titleBn) || other.titleBn == titleBn)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&const DeepCollectionEquality().equals(other._targetGroupIds, _targetGroupIds)&&(identical(other.manufacturerId, manufacturerId) || other.manufacturerId == manufacturerId)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.mottoEn, mottoEn) || other.mottoEn == mottoEn)&&(identical(other.mottoBn, mottoBn) || other.mottoBn == mottoBn)&&(identical(other.compositionBasisEn, compositionBasisEn) || other.compositionBasisEn == compositionBasisEn)&&(identical(other.compositionBasisBn, compositionBasisBn) || other.compositionBasisBn == compositionBasisBn)&&(identical(other.shortDescriptionEn, shortDescriptionEn) || other.shortDescriptionEn == shortDescriptionEn)&&(identical(other.shortDescriptionBn, shortDescriptionBn) || other.shortDescriptionBn == shortDescriptionBn)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other._compositions, _compositions)&&const DeepCollectionEquality().equals(other._indications, _indications)&&const DeepCollectionEquality().equals(other._directions, _directions)&&const DeepCollectionEquality().equals(other._precautions, _precautions)&&const DeepCollectionEquality().equals(other._presentations, _presentations)&&(identical(other.manufacturer, manufacturer) || other.manufacturer == manufacturer)&&(identical(other.category, category) || other.category == category)&&const DeepCollectionEquality().equals(other._targetGroups, _targetGroups));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,titleEn,titleBn,slug,categoryId,const DeepCollectionEquality().hash(_targetGroupIds),manufacturerId,imageUrl,mottoEn,mottoBn,compositionBasisEn,compositionBasisBn,shortDescriptionEn,shortDescriptionBn,isActive,createdAt,updatedAt,const DeepCollectionEquality().hash(_compositions),const DeepCollectionEquality().hash(_indications),const DeepCollectionEquality().hash(_directions),const DeepCollectionEquality().hash(_precautions),const DeepCollectionEquality().hash(_presentations),manufacturer,category,const DeepCollectionEquality().hash(_targetGroups)]);

@override
String toString() {
  return 'Product(id: $id, titleEn: $titleEn, titleBn: $titleBn, slug: $slug, categoryId: $categoryId, targetGroupIds: $targetGroupIds, manufacturerId: $manufacturerId, imageUrl: $imageUrl, mottoEn: $mottoEn, mottoBn: $mottoBn, compositionBasisEn: $compositionBasisEn, compositionBasisBn: $compositionBasisBn, shortDescriptionEn: $shortDescriptionEn, shortDescriptionBn: $shortDescriptionBn, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt, compositions: $compositions, indications: $indications, directions: $directions, precautions: $precautions, presentations: $presentations, manufacturer: $manufacturer, category: $category, targetGroups: $targetGroups)';
}


}

/// @nodoc
abstract mixin class _$ProductCopyWith<$Res> implements $ProductCopyWith<$Res> {
  factory _$ProductCopyWith(_Product value, $Res Function(_Product) _then) = __$ProductCopyWithImpl;
@override @useResult
$Res call({
 int id, String titleEn, String? titleBn, String slug, int categoryId, List<int> targetGroupIds, int? manufacturerId, String? imageUrl, String? mottoEn, String? mottoBn, String? compositionBasisEn, String? compositionBasisBn, String? shortDescriptionEn, String? shortDescriptionBn, int isActive, String createdAt, String updatedAt, List<Composition> compositions, List<Indication> indications, List<Direction> directions, List<Precaution> precautions, List<Presentation> presentations, Manufacturer manufacturer, Category category, List<TargetGroup> targetGroups
});


@override $ManufacturerCopyWith<$Res> get manufacturer;@override $CategoryCopyWith<$Res> get category;

}
/// @nodoc
class __$ProductCopyWithImpl<$Res>
    implements _$ProductCopyWith<$Res> {
  __$ProductCopyWithImpl(this._self, this._then);

  final _Product _self;
  final $Res Function(_Product) _then;

/// Create a copy of Product
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? titleEn = null,Object? titleBn = freezed,Object? slug = null,Object? categoryId = null,Object? targetGroupIds = null,Object? manufacturerId = freezed,Object? imageUrl = freezed,Object? mottoEn = freezed,Object? mottoBn = freezed,Object? compositionBasisEn = freezed,Object? compositionBasisBn = freezed,Object? shortDescriptionEn = freezed,Object? shortDescriptionBn = freezed,Object? isActive = null,Object? createdAt = null,Object? updatedAt = null,Object? compositions = null,Object? indications = null,Object? directions = null,Object? precautions = null,Object? presentations = null,Object? manufacturer = null,Object? category = null,Object? targetGroups = null,}) {
  return _then(_Product(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,titleEn: null == titleEn ? _self.titleEn : titleEn // ignore: cast_nullable_to_non_nullable
as String,titleBn: freezed == titleBn ? _self.titleBn : titleBn // ignore: cast_nullable_to_non_nullable
as String?,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as int,targetGroupIds: null == targetGroupIds ? _self._targetGroupIds : targetGroupIds // ignore: cast_nullable_to_non_nullable
as List<int>,manufacturerId: freezed == manufacturerId ? _self.manufacturerId : manufacturerId // ignore: cast_nullable_to_non_nullable
as int?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,mottoEn: freezed == mottoEn ? _self.mottoEn : mottoEn // ignore: cast_nullable_to_non_nullable
as String?,mottoBn: freezed == mottoBn ? _self.mottoBn : mottoBn // ignore: cast_nullable_to_non_nullable
as String?,compositionBasisEn: freezed == compositionBasisEn ? _self.compositionBasisEn : compositionBasisEn // ignore: cast_nullable_to_non_nullable
as String?,compositionBasisBn: freezed == compositionBasisBn ? _self.compositionBasisBn : compositionBasisBn // ignore: cast_nullable_to_non_nullable
as String?,shortDescriptionEn: freezed == shortDescriptionEn ? _self.shortDescriptionEn : shortDescriptionEn // ignore: cast_nullable_to_non_nullable
as String?,shortDescriptionBn: freezed == shortDescriptionBn ? _self.shortDescriptionBn : shortDescriptionBn // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,compositions: null == compositions ? _self._compositions : compositions // ignore: cast_nullable_to_non_nullable
as List<Composition>,indications: null == indications ? _self._indications : indications // ignore: cast_nullable_to_non_nullable
as List<Indication>,directions: null == directions ? _self._directions : directions // ignore: cast_nullable_to_non_nullable
as List<Direction>,precautions: null == precautions ? _self._precautions : precautions // ignore: cast_nullable_to_non_nullable
as List<Precaution>,presentations: null == presentations ? _self._presentations : presentations // ignore: cast_nullable_to_non_nullable
as List<Presentation>,manufacturer: null == manufacturer ? _self.manufacturer : manufacturer // ignore: cast_nullable_to_non_nullable
as Manufacturer,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as Category,targetGroups: null == targetGroups ? _self._targetGroups : targetGroups // ignore: cast_nullable_to_non_nullable
as List<TargetGroup>,
  ));
}

/// Create a copy of Product
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ManufacturerCopyWith<$Res> get manufacturer {
  
  return $ManufacturerCopyWith<$Res>(_self.manufacturer, (value) {
    return _then(_self.copyWith(manufacturer: value));
  });
}/// Create a copy of Product
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CategoryCopyWith<$Res> get category {
  
  return $CategoryCopyWith<$Res>(_self.category, (value) {
    return _then(_self.copyWith(category: value));
  });
}
}

// dart format on
