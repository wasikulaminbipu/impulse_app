// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'indication.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Indication {

 int get id; int get productId; String get textEn; String? get textBn; int get displayOrder;
/// Create a copy of Indication
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IndicationCopyWith<Indication> get copyWith => _$IndicationCopyWithImpl<Indication>(this as Indication, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Indication&&(identical(other.id, id) || other.id == id)&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.textEn, textEn) || other.textEn == textEn)&&(identical(other.textBn, textBn) || other.textBn == textBn)&&(identical(other.displayOrder, displayOrder) || other.displayOrder == displayOrder));
}


@override
int get hashCode => Object.hash(runtimeType,id,productId,textEn,textBn,displayOrder);

@override
String toString() {
  return 'Indication(id: $id, productId: $productId, textEn: $textEn, textBn: $textBn, displayOrder: $displayOrder)';
}


}

/// @nodoc
abstract mixin class $IndicationCopyWith<$Res>  {
  factory $IndicationCopyWith(Indication value, $Res Function(Indication) _then) = _$IndicationCopyWithImpl;
@useResult
$Res call({
 int id, int productId, String textEn, String? textBn, int displayOrder
});




}
/// @nodoc
class _$IndicationCopyWithImpl<$Res>
    implements $IndicationCopyWith<$Res> {
  _$IndicationCopyWithImpl(this._self, this._then);

  final Indication _self;
  final $Res Function(Indication) _then;

/// Create a copy of Indication
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


/// Adds pattern-matching-related methods to [Indication].
extension IndicationPatterns on Indication {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Indication value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Indication() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Indication value)  $default,){
final _that = this;
switch (_that) {
case _Indication():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Indication value)?  $default,){
final _that = this;
switch (_that) {
case _Indication() when $default != null:
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
case _Indication() when $default != null:
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
case _Indication():
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
case _Indication() when $default != null:
return $default(_that.id,_that.productId,_that.textEn,_that.textBn,_that.displayOrder);case _:
  return null;

}
}

}

/// @nodoc


class _Indication implements Indication {
  const _Indication({required this.id, required this.productId, required this.textEn, this.textBn, this.displayOrder = 0});
  

@override final  int id;
@override final  int productId;
@override final  String textEn;
@override final  String? textBn;
@override@JsonKey() final  int displayOrder;

/// Create a copy of Indication
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IndicationCopyWith<_Indication> get copyWith => __$IndicationCopyWithImpl<_Indication>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Indication&&(identical(other.id, id) || other.id == id)&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.textEn, textEn) || other.textEn == textEn)&&(identical(other.textBn, textBn) || other.textBn == textBn)&&(identical(other.displayOrder, displayOrder) || other.displayOrder == displayOrder));
}


@override
int get hashCode => Object.hash(runtimeType,id,productId,textEn,textBn,displayOrder);

@override
String toString() {
  return 'Indication(id: $id, productId: $productId, textEn: $textEn, textBn: $textBn, displayOrder: $displayOrder)';
}


}

/// @nodoc
abstract mixin class _$IndicationCopyWith<$Res> implements $IndicationCopyWith<$Res> {
  factory _$IndicationCopyWith(_Indication value, $Res Function(_Indication) _then) = __$IndicationCopyWithImpl;
@override @useResult
$Res call({
 int id, int productId, String textEn, String? textBn, int displayOrder
});




}
/// @nodoc
class __$IndicationCopyWithImpl<$Res>
    implements _$IndicationCopyWith<$Res> {
  __$IndicationCopyWithImpl(this._self, this._then);

  final _Indication _self;
  final $Res Function(_Indication) _then;

/// Create a copy of Indication
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? productId = null,Object? textEn = null,Object? textBn = freezed,Object? displayOrder = null,}) {
  return _then(_Indication(
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
