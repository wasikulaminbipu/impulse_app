// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'presentation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Presentation {

 int get id; int get productId; int get productTypeId; int get contentTypeId; String? get size; double? get mrp; String? get imageUrl; int get displayOrder; bool get bulkItem;
/// Create a copy of Presentation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PresentationCopyWith<Presentation> get copyWith => _$PresentationCopyWithImpl<Presentation>(this as Presentation, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Presentation;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Presentation&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.productId, _this.productId) || other.productId == _this.productId)&&(identical(other.productTypeId, _this.productTypeId) || other.productTypeId == _this.productTypeId)&&(identical(other.contentTypeId, _this.contentTypeId) || other.contentTypeId == _this.contentTypeId)&&(identical(other.size, _this.size) || other.size == _this.size)&&(identical(other.mrp, _this.mrp) || other.mrp == _this.mrp)&&(identical(other.imageUrl, _this.imageUrl) || other.imageUrl == _this.imageUrl)&&(identical(other.displayOrder, _this.displayOrder) || other.displayOrder == _this.displayOrder)&&(identical(other.bulkItem, _this.bulkItem) || other.bulkItem == _this.bulkItem));
}


@override
int get hashCode {
  final _this = this as Presentation;
  return Object.hash(runtimeType,_this.id,_this.productId,_this.productTypeId,_this.contentTypeId,_this.size,_this.mrp,_this.imageUrl,_this.displayOrder,_this.bulkItem);
}

@override
String toString() {
  final _this = this as Presentation;
  return 'Presentation(id: ${_this.id}, productId: ${_this.productId}, productTypeId: ${_this.productTypeId}, contentTypeId: ${_this.contentTypeId}, size: ${_this.size}, mrp: ${_this.mrp}, imageUrl: ${_this.imageUrl}, displayOrder: ${_this.displayOrder}, bulkItem: ${_this.bulkItem})';
}


}

/// @nodoc
abstract mixin class $PresentationCopyWith<$Res>  {
  factory $PresentationCopyWith(Presentation value, $Res Function(Presentation) _then) = _$PresentationCopyWithImpl;
@useResult
$Res call({
 int id, int productId, int productTypeId, int contentTypeId, String? size, double? mrp, String? imageUrl, int displayOrder, bool bulkItem
});




}
/// @nodoc
class _$PresentationCopyWithImpl<$Res>
    implements $PresentationCopyWith<$Res> {
  _$PresentationCopyWithImpl(this._self, this._then);

  final Presentation _self;
  final $Res Function(Presentation) _then;

/// Create a copy of Presentation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? productId = null,Object? productTypeId = null,Object? contentTypeId = null,Object? size = freezed,Object? mrp = freezed,Object? imageUrl = freezed,Object? displayOrder = null,Object? bulkItem = null,}) {
  return _then(Presentation(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as int,productTypeId: null == productTypeId ? _self.productTypeId : productTypeId // ignore: cast_nullable_to_non_nullable
as int,contentTypeId: null == contentTypeId ? _self.contentTypeId : contentTypeId // ignore: cast_nullable_to_non_nullable
as int,size: freezed == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as String?,mrp: freezed == mrp ? _self.mrp : mrp // ignore: cast_nullable_to_non_nullable
as double?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,displayOrder: null == displayOrder ? _self.displayOrder : displayOrder // ignore: cast_nullable_to_non_nullable
as int,bulkItem: null == bulkItem ? _self.bulkItem : bulkItem // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [Presentation].
extension PresentationPatterns on Presentation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Presentation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Presentation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Presentation value)  $default,){
final _that = this;
switch (_that) {
case _Presentation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Presentation value)?  $default,){
final _that = this;
switch (_that) {
case _Presentation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int productId,  int productTypeId,  int contentTypeId,  String? size,  double? mrp,  String? imageUrl,  int displayOrder,  bool bulkItem)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Presentation() when $default != null:
return $default(_that.id,_that.productId,_that.productTypeId,_that.contentTypeId,_that.size,_that.mrp,_that.imageUrl,_that.displayOrder,_that.bulkItem);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int productId,  int productTypeId,  int contentTypeId,  String? size,  double? mrp,  String? imageUrl,  int displayOrder,  bool bulkItem)  $default,) {final _that = this;
switch (_that) {
case _Presentation():
return $default(_that.id,_that.productId,_that.productTypeId,_that.contentTypeId,_that.size,_that.mrp,_that.imageUrl,_that.displayOrder,_that.bulkItem);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int productId,  int productTypeId,  int contentTypeId,  String? size,  double? mrp,  String? imageUrl,  int displayOrder,  bool bulkItem)?  $default,) {final _that = this;
switch (_that) {
case _Presentation() when $default != null:
return $default(_that.id,_that.productId,_that.productTypeId,_that.contentTypeId,_that.size,_that.mrp,_that.imageUrl,_that.displayOrder,_that.bulkItem);case _:
  return null;

}
}

}

/// @nodoc


class _Presentation extends Presentation {
  const _Presentation({required this.id, required this.productId, required this.productTypeId, required this.contentTypeId, this.size, this.mrp, this.imageUrl, this.displayOrder = 0, this.bulkItem = false}): super._();
  

@override final  int id;
@override final  int productId;
@override final  int productTypeId;
@override final  int contentTypeId;
@override final  String? size;
@override final  double? mrp;
@override final  String? imageUrl;
@override@JsonKey() final  int displayOrder;
@override@JsonKey() final  bool bulkItem;

/// Create a copy of Presentation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PresentationCopyWith<_Presentation> get copyWith => __$PresentationCopyWithImpl<_Presentation>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Presentation&&(identical(other.id, id) || other.id == id)&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.productTypeId, productTypeId) || other.productTypeId == productTypeId)&&(identical(other.contentTypeId, contentTypeId) || other.contentTypeId == contentTypeId)&&(identical(other.size, size) || other.size == size)&&(identical(other.mrp, mrp) || other.mrp == mrp)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.displayOrder, displayOrder) || other.displayOrder == displayOrder)&&(identical(other.bulkItem, bulkItem) || other.bulkItem == bulkItem));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,productId,productTypeId,contentTypeId,size,mrp,imageUrl,displayOrder,bulkItem);
}

@override
String toString() {
    return 'Presentation(id: $id, productId: $productId, productTypeId: $productTypeId, contentTypeId: $contentTypeId, size: $size, mrp: $mrp, imageUrl: $imageUrl, displayOrder: $displayOrder, bulkItem: $bulkItem)';
}


}

/// @nodoc
abstract mixin class _$PresentationCopyWith<$Res> implements $PresentationCopyWith<$Res> {
  factory _$PresentationCopyWith(_Presentation value, $Res Function(_Presentation) _then) = __$PresentationCopyWithImpl;
@override @useResult
$Res call({
 int id, int productId, int productTypeId, int contentTypeId, String? size, double? mrp, String? imageUrl, int displayOrder, bool bulkItem
});




}
/// @nodoc
class __$PresentationCopyWithImpl<$Res>
    implements _$PresentationCopyWith<$Res> {
  __$PresentationCopyWithImpl(this._self, this._then);

  final _Presentation _self;
  final $Res Function(_Presentation) _then;

/// Create a copy of Presentation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? productId = null,Object? productTypeId = null,Object? contentTypeId = null,Object? size = freezed,Object? mrp = freezed,Object? imageUrl = freezed,Object? displayOrder = null,Object? bulkItem = null,}) {
  return _then(_Presentation(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as int,productTypeId: null == productTypeId ? _self.productTypeId : productTypeId // ignore: cast_nullable_to_non_nullable
as int,contentTypeId: null == contentTypeId ? _self.contentTypeId : contentTypeId // ignore: cast_nullable_to_non_nullable
as int,size: freezed == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as String?,mrp: freezed == mrp ? _self.mrp : mrp // ignore: cast_nullable_to_non_nullable
as double?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,displayOrder: null == displayOrder ? _self.displayOrder : displayOrder // ignore: cast_nullable_to_non_nullable
as int,bulkItem: null == bulkItem ? _self.bulkItem : bulkItem // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
