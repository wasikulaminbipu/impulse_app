// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_label.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProductLabel {

 int get id; String get titleEn; String? get titleBn; String? get shortDescriptionEn; String? get shortDescriptionBn; String? get mottoEn; String? get mottoBn; int get categoryId; Category get category; List<int> get targetGroupIds; List<TargetGroup> get targetGroups; List<Presentation> get presentations; bool get isFavourite; String? get imageUrl;
/// Create a copy of ProductLabel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductLabelCopyWith<ProductLabel> get copyWith => _$ProductLabelCopyWithImpl<ProductLabel>(this as ProductLabel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductLabel&&(identical(other.id, id) || other.id == id)&&(identical(other.titleEn, titleEn) || other.titleEn == titleEn)&&(identical(other.titleBn, titleBn) || other.titleBn == titleBn)&&(identical(other.shortDescriptionEn, shortDescriptionEn) || other.shortDescriptionEn == shortDescriptionEn)&&(identical(other.shortDescriptionBn, shortDescriptionBn) || other.shortDescriptionBn == shortDescriptionBn)&&(identical(other.mottoEn, mottoEn) || other.mottoEn == mottoEn)&&(identical(other.mottoBn, mottoBn) || other.mottoBn == mottoBn)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.category, category) || other.category == category)&&const DeepCollectionEquality().equals(other.targetGroupIds, targetGroupIds)&&const DeepCollectionEquality().equals(other.targetGroups, targetGroups)&&const DeepCollectionEquality().equals(other.presentations, presentations)&&(identical(other.isFavourite, isFavourite) || other.isFavourite == isFavourite)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl));
}


@override
int get hashCode => Object.hash(runtimeType,id,titleEn,titleBn,shortDescriptionEn,shortDescriptionBn,mottoEn,mottoBn,categoryId,category,const DeepCollectionEquality().hash(targetGroupIds),const DeepCollectionEquality().hash(targetGroups),const DeepCollectionEquality().hash(presentations),isFavourite,imageUrl);

@override
String toString() {
  return 'ProductLabel(id: $id, titleEn: $titleEn, titleBn: $titleBn, shortDescriptionEn: $shortDescriptionEn, shortDescriptionBn: $shortDescriptionBn, mottoEn: $mottoEn, mottoBn: $mottoBn, categoryId: $categoryId, category: $category, targetGroupIds: $targetGroupIds, targetGroups: $targetGroups, presentations: $presentations, isFavourite: $isFavourite, imageUrl: $imageUrl)';
}


}

/// @nodoc
abstract mixin class $ProductLabelCopyWith<$Res>  {
  factory $ProductLabelCopyWith(ProductLabel value, $Res Function(ProductLabel) _then) = _$ProductLabelCopyWithImpl;
@useResult
$Res call({
 int id, String titleEn, String? titleBn, String? shortDescriptionEn, String? shortDescriptionBn, String? mottoEn, String? mottoBn, int categoryId, Category category, List<int> targetGroupIds, List<TargetGroup> targetGroups, List<Presentation> presentations, bool isFavourite, String? imageUrl
});


$CategoryCopyWith<$Res> get category;

}
/// @nodoc
class _$ProductLabelCopyWithImpl<$Res>
    implements $ProductLabelCopyWith<$Res> {
  _$ProductLabelCopyWithImpl(this._self, this._then);

  final ProductLabel _self;
  final $Res Function(ProductLabel) _then;

/// Create a copy of ProductLabel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? titleEn = null,Object? titleBn = freezed,Object? shortDescriptionEn = freezed,Object? shortDescriptionBn = freezed,Object? mottoEn = freezed,Object? mottoBn = freezed,Object? categoryId = null,Object? category = null,Object? targetGroupIds = null,Object? targetGroups = null,Object? presentations = null,Object? isFavourite = null,Object? imageUrl = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,titleEn: null == titleEn ? _self.titleEn : titleEn // ignore: cast_nullable_to_non_nullable
as String,titleBn: freezed == titleBn ? _self.titleBn : titleBn // ignore: cast_nullable_to_non_nullable
as String?,shortDescriptionEn: freezed == shortDescriptionEn ? _self.shortDescriptionEn : shortDescriptionEn // ignore: cast_nullable_to_non_nullable
as String?,shortDescriptionBn: freezed == shortDescriptionBn ? _self.shortDescriptionBn : shortDescriptionBn // ignore: cast_nullable_to_non_nullable
as String?,mottoEn: freezed == mottoEn ? _self.mottoEn : mottoEn // ignore: cast_nullable_to_non_nullable
as String?,mottoBn: freezed == mottoBn ? _self.mottoBn : mottoBn // ignore: cast_nullable_to_non_nullable
as String?,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as int,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as Category,targetGroupIds: null == targetGroupIds ? _self.targetGroupIds : targetGroupIds // ignore: cast_nullable_to_non_nullable
as List<int>,targetGroups: null == targetGroups ? _self.targetGroups : targetGroups // ignore: cast_nullable_to_non_nullable
as List<TargetGroup>,presentations: null == presentations ? _self.presentations : presentations // ignore: cast_nullable_to_non_nullable
as List<Presentation>,isFavourite: null == isFavourite ? _self.isFavourite : isFavourite // ignore: cast_nullable_to_non_nullable
as bool,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of ProductLabel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CategoryCopyWith<$Res> get category {
  
  return $CategoryCopyWith<$Res>(_self.category, (value) {
    return _then(_self.copyWith(category: value));
  });
}
}


/// Adds pattern-matching-related methods to [ProductLabel].
extension ProductLabelPatterns on ProductLabel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProductLabel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProductLabel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProductLabel value)  $default,){
final _that = this;
switch (_that) {
case _ProductLabel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProductLabel value)?  $default,){
final _that = this;
switch (_that) {
case _ProductLabel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String titleEn,  String? titleBn,  String? shortDescriptionEn,  String? shortDescriptionBn,  String? mottoEn,  String? mottoBn,  int categoryId,  Category category,  List<int> targetGroupIds,  List<TargetGroup> targetGroups,  List<Presentation> presentations,  bool isFavourite,  String? imageUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProductLabel() when $default != null:
return $default(_that.id,_that.titleEn,_that.titleBn,_that.shortDescriptionEn,_that.shortDescriptionBn,_that.mottoEn,_that.mottoBn,_that.categoryId,_that.category,_that.targetGroupIds,_that.targetGroups,_that.presentations,_that.isFavourite,_that.imageUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String titleEn,  String? titleBn,  String? shortDescriptionEn,  String? shortDescriptionBn,  String? mottoEn,  String? mottoBn,  int categoryId,  Category category,  List<int> targetGroupIds,  List<TargetGroup> targetGroups,  List<Presentation> presentations,  bool isFavourite,  String? imageUrl)  $default,) {final _that = this;
switch (_that) {
case _ProductLabel():
return $default(_that.id,_that.titleEn,_that.titleBn,_that.shortDescriptionEn,_that.shortDescriptionBn,_that.mottoEn,_that.mottoBn,_that.categoryId,_that.category,_that.targetGroupIds,_that.targetGroups,_that.presentations,_that.isFavourite,_that.imageUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String titleEn,  String? titleBn,  String? shortDescriptionEn,  String? shortDescriptionBn,  String? mottoEn,  String? mottoBn,  int categoryId,  Category category,  List<int> targetGroupIds,  List<TargetGroup> targetGroups,  List<Presentation> presentations,  bool isFavourite,  String? imageUrl)?  $default,) {final _that = this;
switch (_that) {
case _ProductLabel() when $default != null:
return $default(_that.id,_that.titleEn,_that.titleBn,_that.shortDescriptionEn,_that.shortDescriptionBn,_that.mottoEn,_that.mottoBn,_that.categoryId,_that.category,_that.targetGroupIds,_that.targetGroups,_that.presentations,_that.isFavourite,_that.imageUrl);case _:
  return null;

}
}

}

/// @nodoc


class _ProductLabel extends ProductLabel {
  const _ProductLabel({required this.id, required this.titleEn, this.titleBn, this.shortDescriptionEn, this.shortDescriptionBn, this.mottoEn, this.mottoBn, required this.categoryId, this.category = const Category.empty(), final  List<int> targetGroupIds = const [], final  List<TargetGroup> targetGroups = const [], final  List<Presentation> presentations = const [], this.isFavourite = false, this.imageUrl}): _targetGroupIds = targetGroupIds,_targetGroups = targetGroups,_presentations = presentations,super._();
  

@override final  int id;
@override final  String titleEn;
@override final  String? titleBn;
@override final  String? shortDescriptionEn;
@override final  String? shortDescriptionBn;
@override final  String? mottoEn;
@override final  String? mottoBn;
@override final  int categoryId;
@override@JsonKey() final  Category category;
 final  List<int> _targetGroupIds;
@override@JsonKey() List<int> get targetGroupIds {
  if (_targetGroupIds is EqualUnmodifiableListView) return _targetGroupIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_targetGroupIds);
}

 final  List<TargetGroup> _targetGroups;
@override@JsonKey() List<TargetGroup> get targetGroups {
  if (_targetGroups is EqualUnmodifiableListView) return _targetGroups;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_targetGroups);
}

 final  List<Presentation> _presentations;
@override@JsonKey() List<Presentation> get presentations {
  if (_presentations is EqualUnmodifiableListView) return _presentations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_presentations);
}

@override@JsonKey() final  bool isFavourite;
@override final  String? imageUrl;

/// Create a copy of ProductLabel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductLabelCopyWith<_ProductLabel> get copyWith => __$ProductLabelCopyWithImpl<_ProductLabel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductLabel&&(identical(other.id, id) || other.id == id)&&(identical(other.titleEn, titleEn) || other.titleEn == titleEn)&&(identical(other.titleBn, titleBn) || other.titleBn == titleBn)&&(identical(other.shortDescriptionEn, shortDescriptionEn) || other.shortDescriptionEn == shortDescriptionEn)&&(identical(other.shortDescriptionBn, shortDescriptionBn) || other.shortDescriptionBn == shortDescriptionBn)&&(identical(other.mottoEn, mottoEn) || other.mottoEn == mottoEn)&&(identical(other.mottoBn, mottoBn) || other.mottoBn == mottoBn)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.category, category) || other.category == category)&&const DeepCollectionEquality().equals(other._targetGroupIds, _targetGroupIds)&&const DeepCollectionEquality().equals(other._targetGroups, _targetGroups)&&const DeepCollectionEquality().equals(other._presentations, _presentations)&&(identical(other.isFavourite, isFavourite) || other.isFavourite == isFavourite)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl));
}


@override
int get hashCode => Object.hash(runtimeType,id,titleEn,titleBn,shortDescriptionEn,shortDescriptionBn,mottoEn,mottoBn,categoryId,category,const DeepCollectionEquality().hash(_targetGroupIds),const DeepCollectionEquality().hash(_targetGroups),const DeepCollectionEquality().hash(_presentations),isFavourite,imageUrl);

@override
String toString() {
  return 'ProductLabel(id: $id, titleEn: $titleEn, titleBn: $titleBn, shortDescriptionEn: $shortDescriptionEn, shortDescriptionBn: $shortDescriptionBn, mottoEn: $mottoEn, mottoBn: $mottoBn, categoryId: $categoryId, category: $category, targetGroupIds: $targetGroupIds, targetGroups: $targetGroups, presentations: $presentations, isFavourite: $isFavourite, imageUrl: $imageUrl)';
}


}

/// @nodoc
abstract mixin class _$ProductLabelCopyWith<$Res> implements $ProductLabelCopyWith<$Res> {
  factory _$ProductLabelCopyWith(_ProductLabel value, $Res Function(_ProductLabel) _then) = __$ProductLabelCopyWithImpl;
@override @useResult
$Res call({
 int id, String titleEn, String? titleBn, String? shortDescriptionEn, String? shortDescriptionBn, String? mottoEn, String? mottoBn, int categoryId, Category category, List<int> targetGroupIds, List<TargetGroup> targetGroups, List<Presentation> presentations, bool isFavourite, String? imageUrl
});


@override $CategoryCopyWith<$Res> get category;

}
/// @nodoc
class __$ProductLabelCopyWithImpl<$Res>
    implements _$ProductLabelCopyWith<$Res> {
  __$ProductLabelCopyWithImpl(this._self, this._then);

  final _ProductLabel _self;
  final $Res Function(_ProductLabel) _then;

/// Create a copy of ProductLabel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? titleEn = null,Object? titleBn = freezed,Object? shortDescriptionEn = freezed,Object? shortDescriptionBn = freezed,Object? mottoEn = freezed,Object? mottoBn = freezed,Object? categoryId = null,Object? category = null,Object? targetGroupIds = null,Object? targetGroups = null,Object? presentations = null,Object? isFavourite = null,Object? imageUrl = freezed,}) {
  return _then(_ProductLabel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,titleEn: null == titleEn ? _self.titleEn : titleEn // ignore: cast_nullable_to_non_nullable
as String,titleBn: freezed == titleBn ? _self.titleBn : titleBn // ignore: cast_nullable_to_non_nullable
as String?,shortDescriptionEn: freezed == shortDescriptionEn ? _self.shortDescriptionEn : shortDescriptionEn // ignore: cast_nullable_to_non_nullable
as String?,shortDescriptionBn: freezed == shortDescriptionBn ? _self.shortDescriptionBn : shortDescriptionBn // ignore: cast_nullable_to_non_nullable
as String?,mottoEn: freezed == mottoEn ? _self.mottoEn : mottoEn // ignore: cast_nullable_to_non_nullable
as String?,mottoBn: freezed == mottoBn ? _self.mottoBn : mottoBn // ignore: cast_nullable_to_non_nullable
as String?,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as int,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as Category,targetGroupIds: null == targetGroupIds ? _self._targetGroupIds : targetGroupIds // ignore: cast_nullable_to_non_nullable
as List<int>,targetGroups: null == targetGroups ? _self._targetGroups : targetGroups // ignore: cast_nullable_to_non_nullable
as List<TargetGroup>,presentations: null == presentations ? _self._presentations : presentations // ignore: cast_nullable_to_non_nullable
as List<Presentation>,isFavourite: null == isFavourite ? _self.isFavourite : isFavourite // ignore: cast_nullable_to_non_nullable
as bool,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of ProductLabel
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
