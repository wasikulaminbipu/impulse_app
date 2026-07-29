// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'precaution.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Precaution {

 int get id; int get productId; String get textEn; String? get textBn; int get displayOrder;
/// Create a copy of Precaution
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PrecautionCopyWith<Precaution> get copyWith => _$PrecautionCopyWithImpl<Precaution>(this as Precaution, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Precaution&&(identical(other.id, id) || other.id == id)&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.textEn, textEn) || other.textEn == textEn)&&(identical(other.textBn, textBn) || other.textBn == textBn)&&(identical(other.displayOrder, displayOrder) || other.displayOrder == displayOrder));
}


@override
int get hashCode => Object.hash(runtimeType,id,productId,textEn,textBn,displayOrder);

@override
String toString() {
  return 'Precaution(id: $id, productId: $productId, textEn: $textEn, textBn: $textBn, displayOrder: $displayOrder)';
}


}

/// @nodoc
abstract mixin class $PrecautionCopyWith<$Res>  {
  factory $PrecautionCopyWith(Precaution value, $Res Function(Precaution) _then) = _$PrecautionCopyWithImpl;
@useResult
$Res call({
 int id, int productId, String textEn, String? textBn, int displayOrder
});




}
/// @nodoc
class _$PrecautionCopyWithImpl<$Res>
    implements $PrecautionCopyWith<$Res> {
  _$PrecautionCopyWithImpl(this._self, this._then);

  final Precaution _self;
  final $Res Function(Precaution) _then;

/// Create a copy of Precaution
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? productId = null,Object? textEn = null,Object? textBn = freezed,Object? displayOrder = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as int,textEn: null == textEn ? _self.textEn : textEn // ignore: cast_nullable_to_non_nullable
as String,textBn: freezed == textBn ? _self.textBn : textBn // ignore: cast_nullable_to_non_nullable
as String?,displayOrder: null == displayOrder ? _self.displayOrder : displayOrder // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [Precaution].
extension PrecautionPatterns on Precaution {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Precaution value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Precaution() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Precaution value)  $default,){
final _that = this;
switch (_that) {
case _Precaution():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Precaution value)?  $default,){
final _that = this;
switch (_that) {
case _Precaution() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int productId,  String textEn,  String? textBn,  int displayOrder)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Precaution() when $default != null:
return $default(_that.id,_that.productId,_that.textEn,_that.textBn,_that.displayOrder);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int productId,  String textEn,  String? textBn,  int displayOrder)  $default,) {final _that = this;
switch (_that) {
case _Precaution():
return $default(_that.id,_that.productId,_that.textEn,_that.textBn,_that.displayOrder);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int productId,  String textEn,  String? textBn,  int displayOrder)?  $default,) {final _that = this;
switch (_that) {
case _Precaution() when $default != null:
return $default(_that.id,_that.productId,_that.textEn,_that.textBn,_that.displayOrder);case _:
  return null;

}
}

}

/// @nodoc


class _Precaution implements Precaution {
  const _Precaution({required this.id, required this.productId, required this.textEn, this.textBn, this.displayOrder = 0});
  

@override final  int id;
@override final  int productId;
@override final  String textEn;
@override final  String? textBn;
@override@JsonKey() final  int displayOrder;

/// Create a copy of Precaution
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PrecautionCopyWith<_Precaution> get copyWith => __$PrecautionCopyWithImpl<_Precaution>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Precaution&&(identical(other.id, id) || other.id == id)&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.textEn, textEn) || other.textEn == textEn)&&(identical(other.textBn, textBn) || other.textBn == textBn)&&(identical(other.displayOrder, displayOrder) || other.displayOrder == displayOrder));
}


@override
int get hashCode => Object.hash(runtimeType,id,productId,textEn,textBn,displayOrder);

@override
String toString() {
  return 'Precaution(id: $id, productId: $productId, textEn: $textEn, textBn: $textBn, displayOrder: $displayOrder)';
}


}

/// @nodoc
abstract mixin class _$PrecautionCopyWith<$Res> implements $PrecautionCopyWith<$Res> {
  factory _$PrecautionCopyWith(_Precaution value, $Res Function(_Precaution) _then) = __$PrecautionCopyWithImpl;
@override @useResult
$Res call({
 int id, int productId, String textEn, String? textBn, int displayOrder
});




}
/// @nodoc
class __$PrecautionCopyWithImpl<$Res>
    implements _$PrecautionCopyWith<$Res> {
  __$PrecautionCopyWithImpl(this._self, this._then);

  final _Precaution _self;
  final $Res Function(_Precaution) _then;

/// Create a copy of Precaution
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? productId = null,Object? textEn = null,Object? textBn = freezed,Object? displayOrder = null,}) {
  return _then(_Precaution(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as int,textEn: null == textEn ? _self.textEn : textEn // ignore: cast_nullable_to_non_nullable
as String,textBn: freezed == textBn ? _self.textBn : textBn // ignore: cast_nullable_to_non_nullable
as String?,displayOrder: null == displayOrder ? _self.displayOrder : displayOrder // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
