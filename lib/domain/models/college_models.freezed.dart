// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'college_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CollectionEntity _$CollectionEntityFromJson(Map<String, dynamic> json) {
  return _CollectionEntity.fromJson(json);
}

/// @nodoc
mixin _$CollectionEntity {
  String get collectionId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get orderIndex => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this CollectionEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CollectionEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CollectionEntityCopyWith<CollectionEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CollectionEntityCopyWith<$Res> {
  factory $CollectionEntityCopyWith(
          CollectionEntity value, $Res Function(CollectionEntity) then) =
      _$CollectionEntityCopyWithImpl<$Res, CollectionEntity>;
  @useResult
  $Res call(
      {String collectionId, String name, int orderIndex, DateTime createdAt});
}

/// @nodoc
class _$CollectionEntityCopyWithImpl<$Res, $Val extends CollectionEntity>
    implements $CollectionEntityCopyWith<$Res> {
  _$CollectionEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CollectionEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? collectionId = null,
    Object? name = null,
    Object? orderIndex = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      collectionId: null == collectionId
          ? _value.collectionId
          : collectionId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      orderIndex: null == orderIndex
          ? _value.orderIndex
          : orderIndex // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CollectionEntityImplCopyWith<$Res>
    implements $CollectionEntityCopyWith<$Res> {
  factory _$$CollectionEntityImplCopyWith(_$CollectionEntityImpl value,
          $Res Function(_$CollectionEntityImpl) then) =
      __$$CollectionEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String collectionId, String name, int orderIndex, DateTime createdAt});
}

/// @nodoc
class __$$CollectionEntityImplCopyWithImpl<$Res>
    extends _$CollectionEntityCopyWithImpl<$Res, _$CollectionEntityImpl>
    implements _$$CollectionEntityImplCopyWith<$Res> {
  __$$CollectionEntityImplCopyWithImpl(_$CollectionEntityImpl _value,
      $Res Function(_$CollectionEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of CollectionEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? collectionId = null,
    Object? name = null,
    Object? orderIndex = null,
    Object? createdAt = null,
  }) {
    return _then(_$CollectionEntityImpl(
      collectionId: null == collectionId
          ? _value.collectionId
          : collectionId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      orderIndex: null == orderIndex
          ? _value.orderIndex
          : orderIndex // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CollectionEntityImpl implements _CollectionEntity {
  const _$CollectionEntityImpl(
      {required this.collectionId,
      required this.name,
      required this.orderIndex,
      required this.createdAt});

  factory _$CollectionEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$CollectionEntityImplFromJson(json);

  @override
  final String collectionId;
  @override
  final String name;
  @override
  final int orderIndex;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'CollectionEntity(collectionId: $collectionId, name: $name, orderIndex: $orderIndex, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CollectionEntityImpl &&
            (identical(other.collectionId, collectionId) ||
                other.collectionId == collectionId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.orderIndex, orderIndex) ||
                other.orderIndex == orderIndex) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, collectionId, name, orderIndex, createdAt);

  /// Create a copy of CollectionEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CollectionEntityImplCopyWith<_$CollectionEntityImpl> get copyWith =>
      __$$CollectionEntityImplCopyWithImpl<_$CollectionEntityImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CollectionEntityImplToJson(
      this,
    );
  }
}

abstract class _CollectionEntity implements CollectionEntity {
  const factory _CollectionEntity(
      {required final String collectionId,
      required final String name,
      required final int orderIndex,
      required final DateTime createdAt}) = _$CollectionEntityImpl;

  factory _CollectionEntity.fromJson(Map<String, dynamic> json) =
      _$CollectionEntityImpl.fromJson;

  @override
  String get collectionId;
  @override
  String get name;
  @override
  int get orderIndex;
  @override
  DateTime get createdAt;

  /// Create a copy of CollectionEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CollectionEntityImplCopyWith<_$CollectionEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CollegeEntity _$CollegeEntityFromJson(Map<String, dynamic> json) {
  return _CollegeEntity.fromJson(json);
}

/// @nodoc
mixin _$CollegeEntity {
  String get collegeId => throw _privateConstructorUsedError;
  String get collegeName => throw _privateConstructorUsedError;
  String get location => throw _privateConstructorUsedError;
  String get courseName => throw _privateConstructorUsedError;
  int get durationYears => throw _privateConstructorUsedError;
  String get collectionId => throw _privateConstructorUsedError;
  double? get averagePackage =>
      throw _privateConstructorUsedError; // Added average placement package
  String? get notes => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  List<YearFee> get fees => throw _privateConstructorUsedError;
  List<Scholarship> get scholarships => throw _privateConstructorUsedError;
  List<Expense> get expenses => throw _privateConstructorUsedError;
  RepaymentConfig? get repaymentConfig => throw _privateConstructorUsedError;
  MoratoriumConfig? get moratoriumConfig => throw _privateConstructorUsedError;

  /// Serializes this CollegeEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CollegeEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CollegeEntityCopyWith<CollegeEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CollegeEntityCopyWith<$Res> {
  factory $CollegeEntityCopyWith(
          CollegeEntity value, $Res Function(CollegeEntity) then) =
      _$CollegeEntityCopyWithImpl<$Res, CollegeEntity>;
  @useResult
  $Res call(
      {String collegeId,
      String collegeName,
      String location,
      String courseName,
      int durationYears,
      String collectionId,
      double? averagePackage,
      String? notes,
      DateTime createdAt,
      DateTime updatedAt,
      List<YearFee> fees,
      List<Scholarship> scholarships,
      List<Expense> expenses,
      RepaymentConfig? repaymentConfig,
      MoratoriumConfig? moratoriumConfig});

  $RepaymentConfigCopyWith<$Res>? get repaymentConfig;
  $MoratoriumConfigCopyWith<$Res>? get moratoriumConfig;
}

/// @nodoc
class _$CollegeEntityCopyWithImpl<$Res, $Val extends CollegeEntity>
    implements $CollegeEntityCopyWith<$Res> {
  _$CollegeEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CollegeEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? collegeId = null,
    Object? collegeName = null,
    Object? location = null,
    Object? courseName = null,
    Object? durationYears = null,
    Object? collectionId = null,
    Object? averagePackage = freezed,
    Object? notes = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? fees = null,
    Object? scholarships = null,
    Object? expenses = null,
    Object? repaymentConfig = freezed,
    Object? moratoriumConfig = freezed,
  }) {
    return _then(_value.copyWith(
      collegeId: null == collegeId
          ? _value.collegeId
          : collegeId // ignore: cast_nullable_to_non_nullable
              as String,
      collegeName: null == collegeName
          ? _value.collegeName
          : collegeName // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      courseName: null == courseName
          ? _value.courseName
          : courseName // ignore: cast_nullable_to_non_nullable
              as String,
      durationYears: null == durationYears
          ? _value.durationYears
          : durationYears // ignore: cast_nullable_to_non_nullable
              as int,
      collectionId: null == collectionId
          ? _value.collectionId
          : collectionId // ignore: cast_nullable_to_non_nullable
              as String,
      averagePackage: freezed == averagePackage
          ? _value.averagePackage
          : averagePackage // ignore: cast_nullable_to_non_nullable
              as double?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      fees: null == fees
          ? _value.fees
          : fees // ignore: cast_nullable_to_non_nullable
              as List<YearFee>,
      scholarships: null == scholarships
          ? _value.scholarships
          : scholarships // ignore: cast_nullable_to_non_nullable
              as List<Scholarship>,
      expenses: null == expenses
          ? _value.expenses
          : expenses // ignore: cast_nullable_to_non_nullable
              as List<Expense>,
      repaymentConfig: freezed == repaymentConfig
          ? _value.repaymentConfig
          : repaymentConfig // ignore: cast_nullable_to_non_nullable
              as RepaymentConfig?,
      moratoriumConfig: freezed == moratoriumConfig
          ? _value.moratoriumConfig
          : moratoriumConfig // ignore: cast_nullable_to_non_nullable
              as MoratoriumConfig?,
    ) as $Val);
  }

  /// Create a copy of CollegeEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RepaymentConfigCopyWith<$Res>? get repaymentConfig {
    if (_value.repaymentConfig == null) {
      return null;
    }

    return $RepaymentConfigCopyWith<$Res>(_value.repaymentConfig!, (value) {
      return _then(_value.copyWith(repaymentConfig: value) as $Val);
    });
  }

  /// Create a copy of CollegeEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MoratoriumConfigCopyWith<$Res>? get moratoriumConfig {
    if (_value.moratoriumConfig == null) {
      return null;
    }

    return $MoratoriumConfigCopyWith<$Res>(_value.moratoriumConfig!, (value) {
      return _then(_value.copyWith(moratoriumConfig: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CollegeEntityImplCopyWith<$Res>
    implements $CollegeEntityCopyWith<$Res> {
  factory _$$CollegeEntityImplCopyWith(
          _$CollegeEntityImpl value, $Res Function(_$CollegeEntityImpl) then) =
      __$$CollegeEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String collegeId,
      String collegeName,
      String location,
      String courseName,
      int durationYears,
      String collectionId,
      double? averagePackage,
      String? notes,
      DateTime createdAt,
      DateTime updatedAt,
      List<YearFee> fees,
      List<Scholarship> scholarships,
      List<Expense> expenses,
      RepaymentConfig? repaymentConfig,
      MoratoriumConfig? moratoriumConfig});

  @override
  $RepaymentConfigCopyWith<$Res>? get repaymentConfig;
  @override
  $MoratoriumConfigCopyWith<$Res>? get moratoriumConfig;
}

/// @nodoc
class __$$CollegeEntityImplCopyWithImpl<$Res>
    extends _$CollegeEntityCopyWithImpl<$Res, _$CollegeEntityImpl>
    implements _$$CollegeEntityImplCopyWith<$Res> {
  __$$CollegeEntityImplCopyWithImpl(
      _$CollegeEntityImpl _value, $Res Function(_$CollegeEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of CollegeEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? collegeId = null,
    Object? collegeName = null,
    Object? location = null,
    Object? courseName = null,
    Object? durationYears = null,
    Object? collectionId = null,
    Object? averagePackage = freezed,
    Object? notes = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? fees = null,
    Object? scholarships = null,
    Object? expenses = null,
    Object? repaymentConfig = freezed,
    Object? moratoriumConfig = freezed,
  }) {
    return _then(_$CollegeEntityImpl(
      collegeId: null == collegeId
          ? _value.collegeId
          : collegeId // ignore: cast_nullable_to_non_nullable
              as String,
      collegeName: null == collegeName
          ? _value.collegeName
          : collegeName // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      courseName: null == courseName
          ? _value.courseName
          : courseName // ignore: cast_nullable_to_non_nullable
              as String,
      durationYears: null == durationYears
          ? _value.durationYears
          : durationYears // ignore: cast_nullable_to_non_nullable
              as int,
      collectionId: null == collectionId
          ? _value.collectionId
          : collectionId // ignore: cast_nullable_to_non_nullable
              as String,
      averagePackage: freezed == averagePackage
          ? _value.averagePackage
          : averagePackage // ignore: cast_nullable_to_non_nullable
              as double?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      fees: null == fees
          ? _value._fees
          : fees // ignore: cast_nullable_to_non_nullable
              as List<YearFee>,
      scholarships: null == scholarships
          ? _value._scholarships
          : scholarships // ignore: cast_nullable_to_non_nullable
              as List<Scholarship>,
      expenses: null == expenses
          ? _value._expenses
          : expenses // ignore: cast_nullable_to_non_nullable
              as List<Expense>,
      repaymentConfig: freezed == repaymentConfig
          ? _value.repaymentConfig
          : repaymentConfig // ignore: cast_nullable_to_non_nullable
              as RepaymentConfig?,
      moratoriumConfig: freezed == moratoriumConfig
          ? _value.moratoriumConfig
          : moratoriumConfig // ignore: cast_nullable_to_non_nullable
              as MoratoriumConfig?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CollegeEntityImpl implements _CollegeEntity {
  const _$CollegeEntityImpl(
      {required this.collegeId,
      required this.collegeName,
      required this.location,
      required this.courseName,
      required this.durationYears,
      required this.collectionId,
      this.averagePackage,
      this.notes,
      required this.createdAt,
      required this.updatedAt,
      final List<YearFee> fees = const [],
      final List<Scholarship> scholarships = const [],
      final List<Expense> expenses = const [],
      this.repaymentConfig,
      this.moratoriumConfig})
      : _fees = fees,
        _scholarships = scholarships,
        _expenses = expenses;

  factory _$CollegeEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$CollegeEntityImplFromJson(json);

  @override
  final String collegeId;
  @override
  final String collegeName;
  @override
  final String location;
  @override
  final String courseName;
  @override
  final int durationYears;
  @override
  final String collectionId;
  @override
  final double? averagePackage;
// Added average placement package
  @override
  final String? notes;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  final List<YearFee> _fees;
  @override
  @JsonKey()
  List<YearFee> get fees {
    if (_fees is EqualUnmodifiableListView) return _fees;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_fees);
  }

  final List<Scholarship> _scholarships;
  @override
  @JsonKey()
  List<Scholarship> get scholarships {
    if (_scholarships is EqualUnmodifiableListView) return _scholarships;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_scholarships);
  }

  final List<Expense> _expenses;
  @override
  @JsonKey()
  List<Expense> get expenses {
    if (_expenses is EqualUnmodifiableListView) return _expenses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_expenses);
  }

  @override
  final RepaymentConfig? repaymentConfig;
  @override
  final MoratoriumConfig? moratoriumConfig;

  @override
  String toString() {
    return 'CollegeEntity(collegeId: $collegeId, collegeName: $collegeName, location: $location, courseName: $courseName, durationYears: $durationYears, collectionId: $collectionId, averagePackage: $averagePackage, notes: $notes, createdAt: $createdAt, updatedAt: $updatedAt, fees: $fees, scholarships: $scholarships, expenses: $expenses, repaymentConfig: $repaymentConfig, moratoriumConfig: $moratoriumConfig)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CollegeEntityImpl &&
            (identical(other.collegeId, collegeId) ||
                other.collegeId == collegeId) &&
            (identical(other.collegeName, collegeName) ||
                other.collegeName == collegeName) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.courseName, courseName) ||
                other.courseName == courseName) &&
            (identical(other.durationYears, durationYears) ||
                other.durationYears == durationYears) &&
            (identical(other.collectionId, collectionId) ||
                other.collectionId == collectionId) &&
            (identical(other.averagePackage, averagePackage) ||
                other.averagePackage == averagePackage) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            const DeepCollectionEquality().equals(other._fees, _fees) &&
            const DeepCollectionEquality()
                .equals(other._scholarships, _scholarships) &&
            const DeepCollectionEquality().equals(other._expenses, _expenses) &&
            (identical(other.repaymentConfig, repaymentConfig) ||
                other.repaymentConfig == repaymentConfig) &&
            (identical(other.moratoriumConfig, moratoriumConfig) ||
                other.moratoriumConfig == moratoriumConfig));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      collegeId,
      collegeName,
      location,
      courseName,
      durationYears,
      collectionId,
      averagePackage,
      notes,
      createdAt,
      updatedAt,
      const DeepCollectionEquality().hash(_fees),
      const DeepCollectionEquality().hash(_scholarships),
      const DeepCollectionEquality().hash(_expenses),
      repaymentConfig,
      moratoriumConfig);

  /// Create a copy of CollegeEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CollegeEntityImplCopyWith<_$CollegeEntityImpl> get copyWith =>
      __$$CollegeEntityImplCopyWithImpl<_$CollegeEntityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CollegeEntityImplToJson(
      this,
    );
  }
}

abstract class _CollegeEntity implements CollegeEntity {
  const factory _CollegeEntity(
      {required final String collegeId,
      required final String collegeName,
      required final String location,
      required final String courseName,
      required final int durationYears,
      required final String collectionId,
      final double? averagePackage,
      final String? notes,
      required final DateTime createdAt,
      required final DateTime updatedAt,
      final List<YearFee> fees,
      final List<Scholarship> scholarships,
      final List<Expense> expenses,
      final RepaymentConfig? repaymentConfig,
      final MoratoriumConfig? moratoriumConfig}) = _$CollegeEntityImpl;

  factory _CollegeEntity.fromJson(Map<String, dynamic> json) =
      _$CollegeEntityImpl.fromJson;

  @override
  String get collegeId;
  @override
  String get collegeName;
  @override
  String get location;
  @override
  String get courseName;
  @override
  int get durationYears;
  @override
  String get collectionId;
  @override
  double? get averagePackage; // Added average placement package
  @override
  String? get notes;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  List<YearFee> get fees;
  @override
  List<Scholarship> get scholarships;
  @override
  List<Expense> get expenses;
  @override
  RepaymentConfig? get repaymentConfig;
  @override
  MoratoriumConfig? get moratoriumConfig;

  /// Create a copy of CollegeEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CollegeEntityImplCopyWith<_$CollegeEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

YearFee _$YearFeeFromJson(Map<String, dynamic> json) {
  return _YearFee.fromJson(json);
}

/// @nodoc
mixin _$YearFee {
  int get yearNumber => throw _privateConstructorUsedError;
  double get tuitionFee => throw _privateConstructorUsedError;
  double? get hostelFee => throw _privateConstructorUsedError;
  double? get examFee => throw _privateConstructorUsedError;
  double? get travelFee => throw _privateConstructorUsedError;
  double? get laptopFee => throw _privateConstructorUsedError;
  double? get miscFee => throw _privateConstructorUsedError;

  /// Serializes this YearFee to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of YearFee
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $YearFeeCopyWith<YearFee> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $YearFeeCopyWith<$Res> {
  factory $YearFeeCopyWith(YearFee value, $Res Function(YearFee) then) =
      _$YearFeeCopyWithImpl<$Res, YearFee>;
  @useResult
  $Res call(
      {int yearNumber,
      double tuitionFee,
      double? hostelFee,
      double? examFee,
      double? travelFee,
      double? laptopFee,
      double? miscFee});
}

/// @nodoc
class _$YearFeeCopyWithImpl<$Res, $Val extends YearFee>
    implements $YearFeeCopyWith<$Res> {
  _$YearFeeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of YearFee
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? yearNumber = null,
    Object? tuitionFee = null,
    Object? hostelFee = freezed,
    Object? examFee = freezed,
    Object? travelFee = freezed,
    Object? laptopFee = freezed,
    Object? miscFee = freezed,
  }) {
    return _then(_value.copyWith(
      yearNumber: null == yearNumber
          ? _value.yearNumber
          : yearNumber // ignore: cast_nullable_to_non_nullable
              as int,
      tuitionFee: null == tuitionFee
          ? _value.tuitionFee
          : tuitionFee // ignore: cast_nullable_to_non_nullable
              as double,
      hostelFee: freezed == hostelFee
          ? _value.hostelFee
          : hostelFee // ignore: cast_nullable_to_non_nullable
              as double?,
      examFee: freezed == examFee
          ? _value.examFee
          : examFee // ignore: cast_nullable_to_non_nullable
              as double?,
      travelFee: freezed == travelFee
          ? _value.travelFee
          : travelFee // ignore: cast_nullable_to_non_nullable
              as double?,
      laptopFee: freezed == laptopFee
          ? _value.laptopFee
          : laptopFee // ignore: cast_nullable_to_non_nullable
              as double?,
      miscFee: freezed == miscFee
          ? _value.miscFee
          : miscFee // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$YearFeeImplCopyWith<$Res> implements $YearFeeCopyWith<$Res> {
  factory _$$YearFeeImplCopyWith(
          _$YearFeeImpl value, $Res Function(_$YearFeeImpl) then) =
      __$$YearFeeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int yearNumber,
      double tuitionFee,
      double? hostelFee,
      double? examFee,
      double? travelFee,
      double? laptopFee,
      double? miscFee});
}

/// @nodoc
class __$$YearFeeImplCopyWithImpl<$Res>
    extends _$YearFeeCopyWithImpl<$Res, _$YearFeeImpl>
    implements _$$YearFeeImplCopyWith<$Res> {
  __$$YearFeeImplCopyWithImpl(
      _$YearFeeImpl _value, $Res Function(_$YearFeeImpl) _then)
      : super(_value, _then);

  /// Create a copy of YearFee
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? yearNumber = null,
    Object? tuitionFee = null,
    Object? hostelFee = freezed,
    Object? examFee = freezed,
    Object? travelFee = freezed,
    Object? laptopFee = freezed,
    Object? miscFee = freezed,
  }) {
    return _then(_$YearFeeImpl(
      yearNumber: null == yearNumber
          ? _value.yearNumber
          : yearNumber // ignore: cast_nullable_to_non_nullable
              as int,
      tuitionFee: null == tuitionFee
          ? _value.tuitionFee
          : tuitionFee // ignore: cast_nullable_to_non_nullable
              as double,
      hostelFee: freezed == hostelFee
          ? _value.hostelFee
          : hostelFee // ignore: cast_nullable_to_non_nullable
              as double?,
      examFee: freezed == examFee
          ? _value.examFee
          : examFee // ignore: cast_nullable_to_non_nullable
              as double?,
      travelFee: freezed == travelFee
          ? _value.travelFee
          : travelFee // ignore: cast_nullable_to_non_nullable
              as double?,
      laptopFee: freezed == laptopFee
          ? _value.laptopFee
          : laptopFee // ignore: cast_nullable_to_non_nullable
              as double?,
      miscFee: freezed == miscFee
          ? _value.miscFee
          : miscFee // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$YearFeeImpl implements _YearFee {
  const _$YearFeeImpl(
      {required this.yearNumber,
      required this.tuitionFee,
      this.hostelFee,
      this.examFee,
      this.travelFee,
      this.laptopFee,
      this.miscFee});

  factory _$YearFeeImpl.fromJson(Map<String, dynamic> json) =>
      _$$YearFeeImplFromJson(json);

  @override
  final int yearNumber;
  @override
  final double tuitionFee;
  @override
  final double? hostelFee;
  @override
  final double? examFee;
  @override
  final double? travelFee;
  @override
  final double? laptopFee;
  @override
  final double? miscFee;

  @override
  String toString() {
    return 'YearFee(yearNumber: $yearNumber, tuitionFee: $tuitionFee, hostelFee: $hostelFee, examFee: $examFee, travelFee: $travelFee, laptopFee: $laptopFee, miscFee: $miscFee)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$YearFeeImpl &&
            (identical(other.yearNumber, yearNumber) ||
                other.yearNumber == yearNumber) &&
            (identical(other.tuitionFee, tuitionFee) ||
                other.tuitionFee == tuitionFee) &&
            (identical(other.hostelFee, hostelFee) ||
                other.hostelFee == hostelFee) &&
            (identical(other.examFee, examFee) || other.examFee == examFee) &&
            (identical(other.travelFee, travelFee) ||
                other.travelFee == travelFee) &&
            (identical(other.laptopFee, laptopFee) ||
                other.laptopFee == laptopFee) &&
            (identical(other.miscFee, miscFee) || other.miscFee == miscFee));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, yearNumber, tuitionFee,
      hostelFee, examFee, travelFee, laptopFee, miscFee);

  /// Create a copy of YearFee
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$YearFeeImplCopyWith<_$YearFeeImpl> get copyWith =>
      __$$YearFeeImplCopyWithImpl<_$YearFeeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$YearFeeImplToJson(
      this,
    );
  }
}

abstract class _YearFee implements YearFee {
  const factory _YearFee(
      {required final int yearNumber,
      required final double tuitionFee,
      final double? hostelFee,
      final double? examFee,
      final double? travelFee,
      final double? laptopFee,
      final double? miscFee}) = _$YearFeeImpl;

  factory _YearFee.fromJson(Map<String, dynamic> json) = _$YearFeeImpl.fromJson;

  @override
  int get yearNumber;
  @override
  double get tuitionFee;
  @override
  double? get hostelFee;
  @override
  double? get examFee;
  @override
  double? get travelFee;
  @override
  double? get laptopFee;
  @override
  double? get miscFee;

  /// Create a copy of YearFee
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$YearFeeImplCopyWith<_$YearFeeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SemesterFee _$SemesterFeeFromJson(Map<String, dynamic> json) {
  return _SemesterFee.fromJson(json);
}

/// @nodoc
mixin _$SemesterFee {
  int get semesterNumber => throw _privateConstructorUsedError;
  double get tuitionFee => throw _privateConstructorUsedError;
  double? get hostelFee => throw _privateConstructorUsedError;
  double? get examFee => throw _privateConstructorUsedError;
  double? get travelFee => throw _privateConstructorUsedError;
  double? get laptopFee => throw _privateConstructorUsedError;
  double? get miscFee => throw _privateConstructorUsedError;

  /// Serializes this SemesterFee to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SemesterFee
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SemesterFeeCopyWith<SemesterFee> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SemesterFeeCopyWith<$Res> {
  factory $SemesterFeeCopyWith(
          SemesterFee value, $Res Function(SemesterFee) then) =
      _$SemesterFeeCopyWithImpl<$Res, SemesterFee>;
  @useResult
  $Res call(
      {int semesterNumber,
      double tuitionFee,
      double? hostelFee,
      double? examFee,
      double? travelFee,
      double? laptopFee,
      double? miscFee});
}

/// @nodoc
class _$SemesterFeeCopyWithImpl<$Res, $Val extends SemesterFee>
    implements $SemesterFeeCopyWith<$Res> {
  _$SemesterFeeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SemesterFee
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? semesterNumber = null,
    Object? tuitionFee = null,
    Object? hostelFee = freezed,
    Object? examFee = freezed,
    Object? travelFee = freezed,
    Object? laptopFee = freezed,
    Object? miscFee = freezed,
  }) {
    return _then(_value.copyWith(
      semesterNumber: null == semesterNumber
          ? _value.semesterNumber
          : semesterNumber // ignore: cast_nullable_to_non_nullable
              as int,
      tuitionFee: null == tuitionFee
          ? _value.tuitionFee
          : tuitionFee // ignore: cast_nullable_to_non_nullable
              as double,
      hostelFee: freezed == hostelFee
          ? _value.hostelFee
          : hostelFee // ignore: cast_nullable_to_non_nullable
              as double?,
      examFee: freezed == examFee
          ? _value.examFee
          : examFee // ignore: cast_nullable_to_non_nullable
              as double?,
      travelFee: freezed == travelFee
          ? _value.travelFee
          : travelFee // ignore: cast_nullable_to_non_nullable
              as double?,
      laptopFee: freezed == laptopFee
          ? _value.laptopFee
          : laptopFee // ignore: cast_nullable_to_non_nullable
              as double?,
      miscFee: freezed == miscFee
          ? _value.miscFee
          : miscFee // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SemesterFeeImplCopyWith<$Res>
    implements $SemesterFeeCopyWith<$Res> {
  factory _$$SemesterFeeImplCopyWith(
          _$SemesterFeeImpl value, $Res Function(_$SemesterFeeImpl) then) =
      __$$SemesterFeeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int semesterNumber,
      double tuitionFee,
      double? hostelFee,
      double? examFee,
      double? travelFee,
      double? laptopFee,
      double? miscFee});
}

/// @nodoc
class __$$SemesterFeeImplCopyWithImpl<$Res>
    extends _$SemesterFeeCopyWithImpl<$Res, _$SemesterFeeImpl>
    implements _$$SemesterFeeImplCopyWith<$Res> {
  __$$SemesterFeeImplCopyWithImpl(
      _$SemesterFeeImpl _value, $Res Function(_$SemesterFeeImpl) _then)
      : super(_value, _then);

  /// Create a copy of SemesterFee
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? semesterNumber = null,
    Object? tuitionFee = null,
    Object? hostelFee = freezed,
    Object? examFee = freezed,
    Object? travelFee = freezed,
    Object? laptopFee = freezed,
    Object? miscFee = freezed,
  }) {
    return _then(_$SemesterFeeImpl(
      semesterNumber: null == semesterNumber
          ? _value.semesterNumber
          : semesterNumber // ignore: cast_nullable_to_non_nullable
              as int,
      tuitionFee: null == tuitionFee
          ? _value.tuitionFee
          : tuitionFee // ignore: cast_nullable_to_non_nullable
              as double,
      hostelFee: freezed == hostelFee
          ? _value.hostelFee
          : hostelFee // ignore: cast_nullable_to_non_nullable
              as double?,
      examFee: freezed == examFee
          ? _value.examFee
          : examFee // ignore: cast_nullable_to_non_nullable
              as double?,
      travelFee: freezed == travelFee
          ? _value.travelFee
          : travelFee // ignore: cast_nullable_to_non_nullable
              as double?,
      laptopFee: freezed == laptopFee
          ? _value.laptopFee
          : laptopFee // ignore: cast_nullable_to_non_nullable
              as double?,
      miscFee: freezed == miscFee
          ? _value.miscFee
          : miscFee // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SemesterFeeImpl implements _SemesterFee {
  const _$SemesterFeeImpl(
      {required this.semesterNumber,
      required this.tuitionFee,
      this.hostelFee,
      this.examFee,
      this.travelFee,
      this.laptopFee,
      this.miscFee});

  factory _$SemesterFeeImpl.fromJson(Map<String, dynamic> json) =>
      _$$SemesterFeeImplFromJson(json);

  @override
  final int semesterNumber;
  @override
  final double tuitionFee;
  @override
  final double? hostelFee;
  @override
  final double? examFee;
  @override
  final double? travelFee;
  @override
  final double? laptopFee;
  @override
  final double? miscFee;

  @override
  String toString() {
    return 'SemesterFee(semesterNumber: $semesterNumber, tuitionFee: $tuitionFee, hostelFee: $hostelFee, examFee: $examFee, travelFee: $travelFee, laptopFee: $laptopFee, miscFee: $miscFee)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SemesterFeeImpl &&
            (identical(other.semesterNumber, semesterNumber) ||
                other.semesterNumber == semesterNumber) &&
            (identical(other.tuitionFee, tuitionFee) ||
                other.tuitionFee == tuitionFee) &&
            (identical(other.hostelFee, hostelFee) ||
                other.hostelFee == hostelFee) &&
            (identical(other.examFee, examFee) || other.examFee == examFee) &&
            (identical(other.travelFee, travelFee) ||
                other.travelFee == travelFee) &&
            (identical(other.laptopFee, laptopFee) ||
                other.laptopFee == laptopFee) &&
            (identical(other.miscFee, miscFee) || other.miscFee == miscFee));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, semesterNumber, tuitionFee,
      hostelFee, examFee, travelFee, laptopFee, miscFee);

  /// Create a copy of SemesterFee
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SemesterFeeImplCopyWith<_$SemesterFeeImpl> get copyWith =>
      __$$SemesterFeeImplCopyWithImpl<_$SemesterFeeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SemesterFeeImplToJson(
      this,
    );
  }
}

abstract class _SemesterFee implements SemesterFee {
  const factory _SemesterFee(
      {required final int semesterNumber,
      required final double tuitionFee,
      final double? hostelFee,
      final double? examFee,
      final double? travelFee,
      final double? laptopFee,
      final double? miscFee}) = _$SemesterFeeImpl;

  factory _SemesterFee.fromJson(Map<String, dynamic> json) =
      _$SemesterFeeImpl.fromJson;

  @override
  int get semesterNumber;
  @override
  double get tuitionFee;
  @override
  double? get hostelFee;
  @override
  double? get examFee;
  @override
  double? get travelFee;
  @override
  double? get laptopFee;
  @override
  double? get miscFee;

  /// Create a copy of SemesterFee
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SemesterFeeImplCopyWith<_$SemesterFeeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Scholarship _$ScholarshipFromJson(Map<String, dynamic> json) {
  return _Scholarship.fromJson(json);
}

/// @nodoc
mixin _$Scholarship {
  String get scholarshipId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  ScholarshipProvider get provider => throw _privateConstructorUsedError;
  ScholarshipCategory get category => throw _privateConstructorUsedError;
  ScholarshipValueType get valueType => throw _privateConstructorUsedError;
  double get value => throw _privateConstructorUsedError;
  ScholarshipFrequency get frequency => throw _privateConstructorUsedError;
  ScholarshipBasis get basis => throw _privateConstructorUsedError;
  List<int> get applicableYears => throw _privateConstructorUsedError;
  List<int> get applicableSemesters => throw _privateConstructorUsedError;
  List<FeeComponent> get feeComponents => throw _privateConstructorUsedError;
  ScholarshipStatus get status => throw _privateConstructorUsedError;
  double? get minCgpa => throw _privateConstructorUsedError;
  bool get incomeCriteriaMet => throw _privateConstructorUsedError;
  bool get isDiscontinued => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;

  /// Serializes this Scholarship to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Scholarship
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ScholarshipCopyWith<Scholarship> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScholarshipCopyWith<$Res> {
  factory $ScholarshipCopyWith(
          Scholarship value, $Res Function(Scholarship) then) =
      _$ScholarshipCopyWithImpl<$Res, Scholarship>;
  @useResult
  $Res call(
      {String scholarshipId,
      String name,
      ScholarshipProvider provider,
      ScholarshipCategory category,
      ScholarshipValueType valueType,
      double value,
      ScholarshipFrequency frequency,
      ScholarshipBasis basis,
      List<int> applicableYears,
      List<int> applicableSemesters,
      List<FeeComponent> feeComponents,
      ScholarshipStatus status,
      double? minCgpa,
      bool incomeCriteriaMet,
      bool isDiscontinued,
      String? notes});
}

/// @nodoc
class _$ScholarshipCopyWithImpl<$Res, $Val extends Scholarship>
    implements $ScholarshipCopyWith<$Res> {
  _$ScholarshipCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Scholarship
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? scholarshipId = null,
    Object? name = null,
    Object? provider = null,
    Object? category = null,
    Object? valueType = null,
    Object? value = null,
    Object? frequency = null,
    Object? basis = null,
    Object? applicableYears = null,
    Object? applicableSemesters = null,
    Object? feeComponents = null,
    Object? status = null,
    Object? minCgpa = freezed,
    Object? incomeCriteriaMet = null,
    Object? isDiscontinued = null,
    Object? notes = freezed,
  }) {
    return _then(_value.copyWith(
      scholarshipId: null == scholarshipId
          ? _value.scholarshipId
          : scholarshipId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      provider: null == provider
          ? _value.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as ScholarshipProvider,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as ScholarshipCategory,
      valueType: null == valueType
          ? _value.valueType
          : valueType // ignore: cast_nullable_to_non_nullable
              as ScholarshipValueType,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
      frequency: null == frequency
          ? _value.frequency
          : frequency // ignore: cast_nullable_to_non_nullable
              as ScholarshipFrequency,
      basis: null == basis
          ? _value.basis
          : basis // ignore: cast_nullable_to_non_nullable
              as ScholarshipBasis,
      applicableYears: null == applicableYears
          ? _value.applicableYears
          : applicableYears // ignore: cast_nullable_to_non_nullable
              as List<int>,
      applicableSemesters: null == applicableSemesters
          ? _value.applicableSemesters
          : applicableSemesters // ignore: cast_nullable_to_non_nullable
              as List<int>,
      feeComponents: null == feeComponents
          ? _value.feeComponents
          : feeComponents // ignore: cast_nullable_to_non_nullable
              as List<FeeComponent>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ScholarshipStatus,
      minCgpa: freezed == minCgpa
          ? _value.minCgpa
          : minCgpa // ignore: cast_nullable_to_non_nullable
              as double?,
      incomeCriteriaMet: null == incomeCriteriaMet
          ? _value.incomeCriteriaMet
          : incomeCriteriaMet // ignore: cast_nullable_to_non_nullable
              as bool,
      isDiscontinued: null == isDiscontinued
          ? _value.isDiscontinued
          : isDiscontinued // ignore: cast_nullable_to_non_nullable
              as bool,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ScholarshipImplCopyWith<$Res>
    implements $ScholarshipCopyWith<$Res> {
  factory _$$ScholarshipImplCopyWith(
          _$ScholarshipImpl value, $Res Function(_$ScholarshipImpl) then) =
      __$$ScholarshipImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String scholarshipId,
      String name,
      ScholarshipProvider provider,
      ScholarshipCategory category,
      ScholarshipValueType valueType,
      double value,
      ScholarshipFrequency frequency,
      ScholarshipBasis basis,
      List<int> applicableYears,
      List<int> applicableSemesters,
      List<FeeComponent> feeComponents,
      ScholarshipStatus status,
      double? minCgpa,
      bool incomeCriteriaMet,
      bool isDiscontinued,
      String? notes});
}

/// @nodoc
class __$$ScholarshipImplCopyWithImpl<$Res>
    extends _$ScholarshipCopyWithImpl<$Res, _$ScholarshipImpl>
    implements _$$ScholarshipImplCopyWith<$Res> {
  __$$ScholarshipImplCopyWithImpl(
      _$ScholarshipImpl _value, $Res Function(_$ScholarshipImpl) _then)
      : super(_value, _then);

  /// Create a copy of Scholarship
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? scholarshipId = null,
    Object? name = null,
    Object? provider = null,
    Object? category = null,
    Object? valueType = null,
    Object? value = null,
    Object? frequency = null,
    Object? basis = null,
    Object? applicableYears = null,
    Object? applicableSemesters = null,
    Object? feeComponents = null,
    Object? status = null,
    Object? minCgpa = freezed,
    Object? incomeCriteriaMet = null,
    Object? isDiscontinued = null,
    Object? notes = freezed,
  }) {
    return _then(_$ScholarshipImpl(
      scholarshipId: null == scholarshipId
          ? _value.scholarshipId
          : scholarshipId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      provider: null == provider
          ? _value.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as ScholarshipProvider,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as ScholarshipCategory,
      valueType: null == valueType
          ? _value.valueType
          : valueType // ignore: cast_nullable_to_non_nullable
              as ScholarshipValueType,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
      frequency: null == frequency
          ? _value.frequency
          : frequency // ignore: cast_nullable_to_non_nullable
              as ScholarshipFrequency,
      basis: null == basis
          ? _value.basis
          : basis // ignore: cast_nullable_to_non_nullable
              as ScholarshipBasis,
      applicableYears: null == applicableYears
          ? _value._applicableYears
          : applicableYears // ignore: cast_nullable_to_non_nullable
              as List<int>,
      applicableSemesters: null == applicableSemesters
          ? _value._applicableSemesters
          : applicableSemesters // ignore: cast_nullable_to_non_nullable
              as List<int>,
      feeComponents: null == feeComponents
          ? _value._feeComponents
          : feeComponents // ignore: cast_nullable_to_non_nullable
              as List<FeeComponent>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ScholarshipStatus,
      minCgpa: freezed == minCgpa
          ? _value.minCgpa
          : minCgpa // ignore: cast_nullable_to_non_nullable
              as double?,
      incomeCriteriaMet: null == incomeCriteriaMet
          ? _value.incomeCriteriaMet
          : incomeCriteriaMet // ignore: cast_nullable_to_non_nullable
              as bool,
      isDiscontinued: null == isDiscontinued
          ? _value.isDiscontinued
          : isDiscontinued // ignore: cast_nullable_to_non_nullable
              as bool,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ScholarshipImpl implements _Scholarship {
  const _$ScholarshipImpl(
      {required this.scholarshipId,
      required this.name,
      this.provider = ScholarshipProvider.government,
      this.category = ScholarshipCategory.tuitionWaiver,
      required this.valueType,
      required this.value,
      this.frequency = ScholarshipFrequency.perYear,
      this.basis = ScholarshipBasis.tuitionOnly,
      final List<int> applicableYears = const [],
      final List<int> applicableSemesters = const [],
      final List<FeeComponent> feeComponents = const [FeeComponent.tuition],
      this.status = ScholarshipStatus.confirmed,
      this.minCgpa,
      this.incomeCriteriaMet = false,
      this.isDiscontinued = false,
      this.notes})
      : _applicableYears = applicableYears,
        _applicableSemesters = applicableSemesters,
        _feeComponents = feeComponents;

  factory _$ScholarshipImpl.fromJson(Map<String, dynamic> json) =>
      _$$ScholarshipImplFromJson(json);

  @override
  final String scholarshipId;
  @override
  final String name;
  @override
  @JsonKey()
  final ScholarshipProvider provider;
  @override
  @JsonKey()
  final ScholarshipCategory category;
  @override
  final ScholarshipValueType valueType;
  @override
  final double value;
  @override
  @JsonKey()
  final ScholarshipFrequency frequency;
  @override
  @JsonKey()
  final ScholarshipBasis basis;
  final List<int> _applicableYears;
  @override
  @JsonKey()
  List<int> get applicableYears {
    if (_applicableYears is EqualUnmodifiableListView) return _applicableYears;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_applicableYears);
  }

  final List<int> _applicableSemesters;
  @override
  @JsonKey()
  List<int> get applicableSemesters {
    if (_applicableSemesters is EqualUnmodifiableListView)
      return _applicableSemesters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_applicableSemesters);
  }

  final List<FeeComponent> _feeComponents;
  @override
  @JsonKey()
  List<FeeComponent> get feeComponents {
    if (_feeComponents is EqualUnmodifiableListView) return _feeComponents;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_feeComponents);
  }

  @override
  @JsonKey()
  final ScholarshipStatus status;
  @override
  final double? minCgpa;
  @override
  @JsonKey()
  final bool incomeCriteriaMet;
  @override
  @JsonKey()
  final bool isDiscontinued;
  @override
  final String? notes;

  @override
  String toString() {
    return 'Scholarship(scholarshipId: $scholarshipId, name: $name, provider: $provider, category: $category, valueType: $valueType, value: $value, frequency: $frequency, basis: $basis, applicableYears: $applicableYears, applicableSemesters: $applicableSemesters, feeComponents: $feeComponents, status: $status, minCgpa: $minCgpa, incomeCriteriaMet: $incomeCriteriaMet, isDiscontinued: $isDiscontinued, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScholarshipImpl &&
            (identical(other.scholarshipId, scholarshipId) ||
                other.scholarshipId == scholarshipId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.provider, provider) ||
                other.provider == provider) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.valueType, valueType) ||
                other.valueType == valueType) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.frequency, frequency) ||
                other.frequency == frequency) &&
            (identical(other.basis, basis) || other.basis == basis) &&
            const DeepCollectionEquality()
                .equals(other._applicableYears, _applicableYears) &&
            const DeepCollectionEquality()
                .equals(other._applicableSemesters, _applicableSemesters) &&
            const DeepCollectionEquality()
                .equals(other._feeComponents, _feeComponents) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.minCgpa, minCgpa) || other.minCgpa == minCgpa) &&
            (identical(other.incomeCriteriaMet, incomeCriteriaMet) ||
                other.incomeCriteriaMet == incomeCriteriaMet) &&
            (identical(other.isDiscontinued, isDiscontinued) ||
                other.isDiscontinued == isDiscontinued) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      scholarshipId,
      name,
      provider,
      category,
      valueType,
      value,
      frequency,
      basis,
      const DeepCollectionEquality().hash(_applicableYears),
      const DeepCollectionEquality().hash(_applicableSemesters),
      const DeepCollectionEquality().hash(_feeComponents),
      status,
      minCgpa,
      incomeCriteriaMet,
      isDiscontinued,
      notes);

  /// Create a copy of Scholarship
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ScholarshipImplCopyWith<_$ScholarshipImpl> get copyWith =>
      __$$ScholarshipImplCopyWithImpl<_$ScholarshipImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ScholarshipImplToJson(
      this,
    );
  }
}

abstract class _Scholarship implements Scholarship {
  const factory _Scholarship(
      {required final String scholarshipId,
      required final String name,
      final ScholarshipProvider provider,
      final ScholarshipCategory category,
      required final ScholarshipValueType valueType,
      required final double value,
      final ScholarshipFrequency frequency,
      final ScholarshipBasis basis,
      final List<int> applicableYears,
      final List<int> applicableSemesters,
      final List<FeeComponent> feeComponents,
      final ScholarshipStatus status,
      final double? minCgpa,
      final bool incomeCriteriaMet,
      final bool isDiscontinued,
      final String? notes}) = _$ScholarshipImpl;

  factory _Scholarship.fromJson(Map<String, dynamic> json) =
      _$ScholarshipImpl.fromJson;

  @override
  String get scholarshipId;
  @override
  String get name;
  @override
  ScholarshipProvider get provider;
  @override
  ScholarshipCategory get category;
  @override
  ScholarshipValueType get valueType;
  @override
  double get value;
  @override
  ScholarshipFrequency get frequency;
  @override
  ScholarshipBasis get basis;
  @override
  List<int> get applicableYears;
  @override
  List<int> get applicableSemesters;
  @override
  List<FeeComponent> get feeComponents;
  @override
  ScholarshipStatus get status;
  @override
  double? get minCgpa;
  @override
  bool get incomeCriteriaMet;
  @override
  bool get isDiscontinued;
  @override
  String? get notes;

  /// Create a copy of Scholarship
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ScholarshipImplCopyWith<_$ScholarshipImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Expense _$ExpenseFromJson(Map<String, dynamic> json) {
  return _Expense.fromJson(json);
}

/// @nodoc
mixin _$Expense {
  String get expenseId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  ExpenseType get type => throw _privateConstructorUsedError;

  /// Serializes this Expense to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Expense
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExpenseCopyWith<Expense> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExpenseCopyWith<$Res> {
  factory $ExpenseCopyWith(Expense value, $Res Function(Expense) then) =
      _$ExpenseCopyWithImpl<$Res, Expense>;
  @useResult
  $Res call(
      {String expenseId,
      String name,
      double amount,
      String category,
      ExpenseType type});
}

/// @nodoc
class _$ExpenseCopyWithImpl<$Res, $Val extends Expense>
    implements $ExpenseCopyWith<$Res> {
  _$ExpenseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Expense
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? expenseId = null,
    Object? name = null,
    Object? amount = null,
    Object? category = null,
    Object? type = null,
  }) {
    return _then(_value.copyWith(
      expenseId: null == expenseId
          ? _value.expenseId
          : expenseId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ExpenseType,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ExpenseImplCopyWith<$Res> implements $ExpenseCopyWith<$Res> {
  factory _$$ExpenseImplCopyWith(
          _$ExpenseImpl value, $Res Function(_$ExpenseImpl) then) =
      __$$ExpenseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String expenseId,
      String name,
      double amount,
      String category,
      ExpenseType type});
}

/// @nodoc
class __$$ExpenseImplCopyWithImpl<$Res>
    extends _$ExpenseCopyWithImpl<$Res, _$ExpenseImpl>
    implements _$$ExpenseImplCopyWith<$Res> {
  __$$ExpenseImplCopyWithImpl(
      _$ExpenseImpl _value, $Res Function(_$ExpenseImpl) _then)
      : super(_value, _then);

  /// Create a copy of Expense
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? expenseId = null,
    Object? name = null,
    Object? amount = null,
    Object? category = null,
    Object? type = null,
  }) {
    return _then(_$ExpenseImpl(
      expenseId: null == expenseId
          ? _value.expenseId
          : expenseId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ExpenseType,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ExpenseImpl implements _Expense {
  const _$ExpenseImpl(
      {required this.expenseId,
      required this.name,
      required this.amount,
      required this.category,
      required this.type});

  factory _$ExpenseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExpenseImplFromJson(json);

  @override
  final String expenseId;
  @override
  final String name;
  @override
  final double amount;
  @override
  final String category;
  @override
  final ExpenseType type;

  @override
  String toString() {
    return 'Expense(expenseId: $expenseId, name: $name, amount: $amount, category: $category, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExpenseImpl &&
            (identical(other.expenseId, expenseId) ||
                other.expenseId == expenseId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, expenseId, name, amount, category, type);

  /// Create a copy of Expense
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExpenseImplCopyWith<_$ExpenseImpl> get copyWith =>
      __$$ExpenseImplCopyWithImpl<_$ExpenseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExpenseImplToJson(
      this,
    );
  }
}

abstract class _Expense implements Expense {
  const factory _Expense(
      {required final String expenseId,
      required final String name,
      required final double amount,
      required final String category,
      required final ExpenseType type}) = _$ExpenseImpl;

  factory _Expense.fromJson(Map<String, dynamic> json) = _$ExpenseImpl.fromJson;

  @override
  String get expenseId;
  @override
  String get name;
  @override
  double get amount;
  @override
  String get category;
  @override
  ExpenseType get type;

  /// Create a copy of Expense
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExpenseImplCopyWith<_$ExpenseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RepaymentConfig _$RepaymentConfigFromJson(Map<String, dynamic> json) {
  return _RepaymentConfig.fromJson(json);
}

/// @nodoc
mixin _$RepaymentConfig {
  int get tenureYears => throw _privateConstructorUsedError;
  double get interestRate => throw _privateConstructorUsedError;
  String get paymentFrequency => throw _privateConstructorUsedError;
  SalaryConfig get salaryConfig => throw _privateConstructorUsedError;
  List<Prepayment> get prepayments => throw _privateConstructorUsedError;

  /// Serializes this RepaymentConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RepaymentConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RepaymentConfigCopyWith<RepaymentConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RepaymentConfigCopyWith<$Res> {
  factory $RepaymentConfigCopyWith(
          RepaymentConfig value, $Res Function(RepaymentConfig) then) =
      _$RepaymentConfigCopyWithImpl<$Res, RepaymentConfig>;
  @useResult
  $Res call(
      {int tenureYears,
      double interestRate,
      String paymentFrequency,
      SalaryConfig salaryConfig,
      List<Prepayment> prepayments});

  $SalaryConfigCopyWith<$Res> get salaryConfig;
}

/// @nodoc
class _$RepaymentConfigCopyWithImpl<$Res, $Val extends RepaymentConfig>
    implements $RepaymentConfigCopyWith<$Res> {
  _$RepaymentConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RepaymentConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tenureYears = null,
    Object? interestRate = null,
    Object? paymentFrequency = null,
    Object? salaryConfig = null,
    Object? prepayments = null,
  }) {
    return _then(_value.copyWith(
      tenureYears: null == tenureYears
          ? _value.tenureYears
          : tenureYears // ignore: cast_nullable_to_non_nullable
              as int,
      interestRate: null == interestRate
          ? _value.interestRate
          : interestRate // ignore: cast_nullable_to_non_nullable
              as double,
      paymentFrequency: null == paymentFrequency
          ? _value.paymentFrequency
          : paymentFrequency // ignore: cast_nullable_to_non_nullable
              as String,
      salaryConfig: null == salaryConfig
          ? _value.salaryConfig
          : salaryConfig // ignore: cast_nullable_to_non_nullable
              as SalaryConfig,
      prepayments: null == prepayments
          ? _value.prepayments
          : prepayments // ignore: cast_nullable_to_non_nullable
              as List<Prepayment>,
    ) as $Val);
  }

  /// Create a copy of RepaymentConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SalaryConfigCopyWith<$Res> get salaryConfig {
    return $SalaryConfigCopyWith<$Res>(_value.salaryConfig, (value) {
      return _then(_value.copyWith(salaryConfig: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$RepaymentConfigImplCopyWith<$Res>
    implements $RepaymentConfigCopyWith<$Res> {
  factory _$$RepaymentConfigImplCopyWith(_$RepaymentConfigImpl value,
          $Res Function(_$RepaymentConfigImpl) then) =
      __$$RepaymentConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int tenureYears,
      double interestRate,
      String paymentFrequency,
      SalaryConfig salaryConfig,
      List<Prepayment> prepayments});

  @override
  $SalaryConfigCopyWith<$Res> get salaryConfig;
}

/// @nodoc
class __$$RepaymentConfigImplCopyWithImpl<$Res>
    extends _$RepaymentConfigCopyWithImpl<$Res, _$RepaymentConfigImpl>
    implements _$$RepaymentConfigImplCopyWith<$Res> {
  __$$RepaymentConfigImplCopyWithImpl(
      _$RepaymentConfigImpl _value, $Res Function(_$RepaymentConfigImpl) _then)
      : super(_value, _then);

  /// Create a copy of RepaymentConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tenureYears = null,
    Object? interestRate = null,
    Object? paymentFrequency = null,
    Object? salaryConfig = null,
    Object? prepayments = null,
  }) {
    return _then(_$RepaymentConfigImpl(
      tenureYears: null == tenureYears
          ? _value.tenureYears
          : tenureYears // ignore: cast_nullable_to_non_nullable
              as int,
      interestRate: null == interestRate
          ? _value.interestRate
          : interestRate // ignore: cast_nullable_to_non_nullable
              as double,
      paymentFrequency: null == paymentFrequency
          ? _value.paymentFrequency
          : paymentFrequency // ignore: cast_nullable_to_non_nullable
              as String,
      salaryConfig: null == salaryConfig
          ? _value.salaryConfig
          : salaryConfig // ignore: cast_nullable_to_non_nullable
              as SalaryConfig,
      prepayments: null == prepayments
          ? _value._prepayments
          : prepayments // ignore: cast_nullable_to_non_nullable
              as List<Prepayment>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RepaymentConfigImpl implements _RepaymentConfig {
  const _$RepaymentConfigImpl(
      {this.tenureYears = 8,
      this.interestRate = 13.0,
      this.paymentFrequency = 'Monthly',
      this.salaryConfig = const SalaryConfig(),
      final List<Prepayment> prepayments = const []})
      : _prepayments = prepayments;

  factory _$RepaymentConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$RepaymentConfigImplFromJson(json);

  @override
  @JsonKey()
  final int tenureYears;
  @override
  @JsonKey()
  final double interestRate;
  @override
  @JsonKey()
  final String paymentFrequency;
  @override
  @JsonKey()
  final SalaryConfig salaryConfig;
  final List<Prepayment> _prepayments;
  @override
  @JsonKey()
  List<Prepayment> get prepayments {
    if (_prepayments is EqualUnmodifiableListView) return _prepayments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_prepayments);
  }

  @override
  String toString() {
    return 'RepaymentConfig(tenureYears: $tenureYears, interestRate: $interestRate, paymentFrequency: $paymentFrequency, salaryConfig: $salaryConfig, prepayments: $prepayments)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RepaymentConfigImpl &&
            (identical(other.tenureYears, tenureYears) ||
                other.tenureYears == tenureYears) &&
            (identical(other.interestRate, interestRate) ||
                other.interestRate == interestRate) &&
            (identical(other.paymentFrequency, paymentFrequency) ||
                other.paymentFrequency == paymentFrequency) &&
            (identical(other.salaryConfig, salaryConfig) ||
                other.salaryConfig == salaryConfig) &&
            const DeepCollectionEquality()
                .equals(other._prepayments, _prepayments));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      tenureYears,
      interestRate,
      paymentFrequency,
      salaryConfig,
      const DeepCollectionEquality().hash(_prepayments));

  /// Create a copy of RepaymentConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RepaymentConfigImplCopyWith<_$RepaymentConfigImpl> get copyWith =>
      __$$RepaymentConfigImplCopyWithImpl<_$RepaymentConfigImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RepaymentConfigImplToJson(
      this,
    );
  }
}

abstract class _RepaymentConfig implements RepaymentConfig {
  const factory _RepaymentConfig(
      {final int tenureYears,
      final double interestRate,
      final String paymentFrequency,
      final SalaryConfig salaryConfig,
      final List<Prepayment> prepayments}) = _$RepaymentConfigImpl;

  factory _RepaymentConfig.fromJson(Map<String, dynamic> json) =
      _$RepaymentConfigImpl.fromJson;

  @override
  int get tenureYears;
  @override
  double get interestRate;
  @override
  String get paymentFrequency;
  @override
  SalaryConfig get salaryConfig;
  @override
  List<Prepayment> get prepayments;

  /// Create a copy of RepaymentConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RepaymentConfigImplCopyWith<_$RepaymentConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SalaryConfig _$SalaryConfigFromJson(Map<String, dynamic> json) {
  return _SalaryConfig.fromJson(json);
}

/// @nodoc
mixin _$SalaryConfig {
  double get monthlySalary => throw _privateConstructorUsedError;
  double get annualGrowthPercent => throw _privateConstructorUsedError;
  String get allocationMode =>
      throw _privateConstructorUsedError; // Monthly EMI, Yearly Lump Sum, Mixed
  List<SalaryChange> get changes => throw _privateConstructorUsedError;

  /// Serializes this SalaryConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SalaryConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SalaryConfigCopyWith<SalaryConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SalaryConfigCopyWith<$Res> {
  factory $SalaryConfigCopyWith(
          SalaryConfig value, $Res Function(SalaryConfig) then) =
      _$SalaryConfigCopyWithImpl<$Res, SalaryConfig>;
  @useResult
  $Res call(
      {double monthlySalary,
      double annualGrowthPercent,
      String allocationMode,
      List<SalaryChange> changes});
}

/// @nodoc
class _$SalaryConfigCopyWithImpl<$Res, $Val extends SalaryConfig>
    implements $SalaryConfigCopyWith<$Res> {
  _$SalaryConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SalaryConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? monthlySalary = null,
    Object? annualGrowthPercent = null,
    Object? allocationMode = null,
    Object? changes = null,
  }) {
    return _then(_value.copyWith(
      monthlySalary: null == monthlySalary
          ? _value.monthlySalary
          : monthlySalary // ignore: cast_nullable_to_non_nullable
              as double,
      annualGrowthPercent: null == annualGrowthPercent
          ? _value.annualGrowthPercent
          : annualGrowthPercent // ignore: cast_nullable_to_non_nullable
              as double,
      allocationMode: null == allocationMode
          ? _value.allocationMode
          : allocationMode // ignore: cast_nullable_to_non_nullable
              as String,
      changes: null == changes
          ? _value.changes
          : changes // ignore: cast_nullable_to_non_nullable
              as List<SalaryChange>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SalaryConfigImplCopyWith<$Res>
    implements $SalaryConfigCopyWith<$Res> {
  factory _$$SalaryConfigImplCopyWith(
          _$SalaryConfigImpl value, $Res Function(_$SalaryConfigImpl) then) =
      __$$SalaryConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double monthlySalary,
      double annualGrowthPercent,
      String allocationMode,
      List<SalaryChange> changes});
}

/// @nodoc
class __$$SalaryConfigImplCopyWithImpl<$Res>
    extends _$SalaryConfigCopyWithImpl<$Res, _$SalaryConfigImpl>
    implements _$$SalaryConfigImplCopyWith<$Res> {
  __$$SalaryConfigImplCopyWithImpl(
      _$SalaryConfigImpl _value, $Res Function(_$SalaryConfigImpl) _then)
      : super(_value, _then);

  /// Create a copy of SalaryConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? monthlySalary = null,
    Object? annualGrowthPercent = null,
    Object? allocationMode = null,
    Object? changes = null,
  }) {
    return _then(_$SalaryConfigImpl(
      monthlySalary: null == monthlySalary
          ? _value.monthlySalary
          : monthlySalary // ignore: cast_nullable_to_non_nullable
              as double,
      annualGrowthPercent: null == annualGrowthPercent
          ? _value.annualGrowthPercent
          : annualGrowthPercent // ignore: cast_nullable_to_non_nullable
              as double,
      allocationMode: null == allocationMode
          ? _value.allocationMode
          : allocationMode // ignore: cast_nullable_to_non_nullable
              as String,
      changes: null == changes
          ? _value._changes
          : changes // ignore: cast_nullable_to_non_nullable
              as List<SalaryChange>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SalaryConfigImpl implements _SalaryConfig {
  const _$SalaryConfigImpl(
      {this.monthlySalary = 0.0,
      this.annualGrowthPercent = 0.0,
      this.allocationMode = 'Monthly',
      final List<SalaryChange> changes = const []})
      : _changes = changes;

  factory _$SalaryConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$SalaryConfigImplFromJson(json);

  @override
  @JsonKey()
  final double monthlySalary;
  @override
  @JsonKey()
  final double annualGrowthPercent;
  @override
  @JsonKey()
  final String allocationMode;
// Monthly EMI, Yearly Lump Sum, Mixed
  final List<SalaryChange> _changes;
// Monthly EMI, Yearly Lump Sum, Mixed
  @override
  @JsonKey()
  List<SalaryChange> get changes {
    if (_changes is EqualUnmodifiableListView) return _changes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_changes);
  }

  @override
  String toString() {
    return 'SalaryConfig(monthlySalary: $monthlySalary, annualGrowthPercent: $annualGrowthPercent, allocationMode: $allocationMode, changes: $changes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SalaryConfigImpl &&
            (identical(other.monthlySalary, monthlySalary) ||
                other.monthlySalary == monthlySalary) &&
            (identical(other.annualGrowthPercent, annualGrowthPercent) ||
                other.annualGrowthPercent == annualGrowthPercent) &&
            (identical(other.allocationMode, allocationMode) ||
                other.allocationMode == allocationMode) &&
            const DeepCollectionEquality().equals(other._changes, _changes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      monthlySalary,
      annualGrowthPercent,
      allocationMode,
      const DeepCollectionEquality().hash(_changes));

  /// Create a copy of SalaryConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SalaryConfigImplCopyWith<_$SalaryConfigImpl> get copyWith =>
      __$$SalaryConfigImplCopyWithImpl<_$SalaryConfigImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SalaryConfigImplToJson(
      this,
    );
  }
}

abstract class _SalaryConfig implements SalaryConfig {
  const factory _SalaryConfig(
      {final double monthlySalary,
      final double annualGrowthPercent,
      final String allocationMode,
      final List<SalaryChange> changes}) = _$SalaryConfigImpl;

  factory _SalaryConfig.fromJson(Map<String, dynamic> json) =
      _$SalaryConfigImpl.fromJson;

  @override
  double get monthlySalary;
  @override
  double get annualGrowthPercent;
  @override
  String get allocationMode; // Monthly EMI, Yearly Lump Sum, Mixed
  @override
  List<SalaryChange> get changes;

  /// Create a copy of SalaryConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SalaryConfigImplCopyWith<_$SalaryConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SalaryChange _$SalaryChangeFromJson(Map<String, dynamic> json) {
  return _SalaryChange.fromJson(json);
}

/// @nodoc
mixin _$SalaryChange {
  int get startYear => throw _privateConstructorUsedError; // 1-based year index
  double get monthlySalary => throw _privateConstructorUsedError;
  double get annualGrowthPercent => throw _privateConstructorUsedError;

  /// Serializes this SalaryChange to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SalaryChange
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SalaryChangeCopyWith<SalaryChange> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SalaryChangeCopyWith<$Res> {
  factory $SalaryChangeCopyWith(
          SalaryChange value, $Res Function(SalaryChange) then) =
      _$SalaryChangeCopyWithImpl<$Res, SalaryChange>;
  @useResult
  $Res call({int startYear, double monthlySalary, double annualGrowthPercent});
}

/// @nodoc
class _$SalaryChangeCopyWithImpl<$Res, $Val extends SalaryChange>
    implements $SalaryChangeCopyWith<$Res> {
  _$SalaryChangeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SalaryChange
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startYear = null,
    Object? monthlySalary = null,
    Object? annualGrowthPercent = null,
  }) {
    return _then(_value.copyWith(
      startYear: null == startYear
          ? _value.startYear
          : startYear // ignore: cast_nullable_to_non_nullable
              as int,
      monthlySalary: null == monthlySalary
          ? _value.monthlySalary
          : monthlySalary // ignore: cast_nullable_to_non_nullable
              as double,
      annualGrowthPercent: null == annualGrowthPercent
          ? _value.annualGrowthPercent
          : annualGrowthPercent // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SalaryChangeImplCopyWith<$Res>
    implements $SalaryChangeCopyWith<$Res> {
  factory _$$SalaryChangeImplCopyWith(
          _$SalaryChangeImpl value, $Res Function(_$SalaryChangeImpl) then) =
      __$$SalaryChangeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int startYear, double monthlySalary, double annualGrowthPercent});
}

/// @nodoc
class __$$SalaryChangeImplCopyWithImpl<$Res>
    extends _$SalaryChangeCopyWithImpl<$Res, _$SalaryChangeImpl>
    implements _$$SalaryChangeImplCopyWith<$Res> {
  __$$SalaryChangeImplCopyWithImpl(
      _$SalaryChangeImpl _value, $Res Function(_$SalaryChangeImpl) _then)
      : super(_value, _then);

  /// Create a copy of SalaryChange
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startYear = null,
    Object? monthlySalary = null,
    Object? annualGrowthPercent = null,
  }) {
    return _then(_$SalaryChangeImpl(
      startYear: null == startYear
          ? _value.startYear
          : startYear // ignore: cast_nullable_to_non_nullable
              as int,
      monthlySalary: null == monthlySalary
          ? _value.monthlySalary
          : monthlySalary // ignore: cast_nullable_to_non_nullable
              as double,
      annualGrowthPercent: null == annualGrowthPercent
          ? _value.annualGrowthPercent
          : annualGrowthPercent // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SalaryChangeImpl implements _SalaryChange {
  const _$SalaryChangeImpl(
      {required this.startYear,
      required this.monthlySalary,
      this.annualGrowthPercent = 0.0});

  factory _$SalaryChangeImpl.fromJson(Map<String, dynamic> json) =>
      _$$SalaryChangeImplFromJson(json);

  @override
  final int startYear;
// 1-based year index
  @override
  final double monthlySalary;
  @override
  @JsonKey()
  final double annualGrowthPercent;

  @override
  String toString() {
    return 'SalaryChange(startYear: $startYear, monthlySalary: $monthlySalary, annualGrowthPercent: $annualGrowthPercent)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SalaryChangeImpl &&
            (identical(other.startYear, startYear) ||
                other.startYear == startYear) &&
            (identical(other.monthlySalary, monthlySalary) ||
                other.monthlySalary == monthlySalary) &&
            (identical(other.annualGrowthPercent, annualGrowthPercent) ||
                other.annualGrowthPercent == annualGrowthPercent));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, startYear, monthlySalary, annualGrowthPercent);

  /// Create a copy of SalaryChange
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SalaryChangeImplCopyWith<_$SalaryChangeImpl> get copyWith =>
      __$$SalaryChangeImplCopyWithImpl<_$SalaryChangeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SalaryChangeImplToJson(
      this,
    );
  }
}

abstract class _SalaryChange implements SalaryChange {
  const factory _SalaryChange(
      {required final int startYear,
      required final double monthlySalary,
      final double annualGrowthPercent}) = _$SalaryChangeImpl;

  factory _SalaryChange.fromJson(Map<String, dynamic> json) =
      _$SalaryChangeImpl.fromJson;

  @override
  int get startYear; // 1-based year index
  @override
  double get monthlySalary;
  @override
  double get annualGrowthPercent;

  /// Create a copy of SalaryChange
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SalaryChangeImplCopyWith<_$SalaryChangeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MoratoriumConfig _$MoratoriumConfigFromJson(Map<String, dynamic> json) {
  return _MoratoriumConfig.fromJson(json);
}

/// @nodoc
mixin _$MoratoriumConfig {
  double get durationYears => throw _privateConstructorUsedError;
  double get interestRate => throw _privateConstructorUsedError;
  InterestType get interestType => throw _privateConstructorUsedError;
  List<MoratoriumPayment> get payments => throw _privateConstructorUsedError;

  /// Serializes this MoratoriumConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MoratoriumConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MoratoriumConfigCopyWith<MoratoriumConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MoratoriumConfigCopyWith<$Res> {
  factory $MoratoriumConfigCopyWith(
          MoratoriumConfig value, $Res Function(MoratoriumConfig) then) =
      _$MoratoriumConfigCopyWithImpl<$Res, MoratoriumConfig>;
  @useResult
  $Res call(
      {double durationYears,
      double interestRate,
      InterestType interestType,
      List<MoratoriumPayment> payments});
}

/// @nodoc
class _$MoratoriumConfigCopyWithImpl<$Res, $Val extends MoratoriumConfig>
    implements $MoratoriumConfigCopyWith<$Res> {
  _$MoratoriumConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MoratoriumConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? durationYears = null,
    Object? interestRate = null,
    Object? interestType = null,
    Object? payments = null,
  }) {
    return _then(_value.copyWith(
      durationYears: null == durationYears
          ? _value.durationYears
          : durationYears // ignore: cast_nullable_to_non_nullable
              as double,
      interestRate: null == interestRate
          ? _value.interestRate
          : interestRate // ignore: cast_nullable_to_non_nullable
              as double,
      interestType: null == interestType
          ? _value.interestType
          : interestType // ignore: cast_nullable_to_non_nullable
              as InterestType,
      payments: null == payments
          ? _value.payments
          : payments // ignore: cast_nullable_to_non_nullable
              as List<MoratoriumPayment>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MoratoriumConfigImplCopyWith<$Res>
    implements $MoratoriumConfigCopyWith<$Res> {
  factory _$$MoratoriumConfigImplCopyWith(_$MoratoriumConfigImpl value,
          $Res Function(_$MoratoriumConfigImpl) then) =
      __$$MoratoriumConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double durationYears,
      double interestRate,
      InterestType interestType,
      List<MoratoriumPayment> payments});
}

/// @nodoc
class __$$MoratoriumConfigImplCopyWithImpl<$Res>
    extends _$MoratoriumConfigCopyWithImpl<$Res, _$MoratoriumConfigImpl>
    implements _$$MoratoriumConfigImplCopyWith<$Res> {
  __$$MoratoriumConfigImplCopyWithImpl(_$MoratoriumConfigImpl _value,
      $Res Function(_$MoratoriumConfigImpl) _then)
      : super(_value, _then);

  /// Create a copy of MoratoriumConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? durationYears = null,
    Object? interestRate = null,
    Object? interestType = null,
    Object? payments = null,
  }) {
    return _then(_$MoratoriumConfigImpl(
      durationYears: null == durationYears
          ? _value.durationYears
          : durationYears // ignore: cast_nullable_to_non_nullable
              as double,
      interestRate: null == interestRate
          ? _value.interestRate
          : interestRate // ignore: cast_nullable_to_non_nullable
              as double,
      interestType: null == interestType
          ? _value.interestType
          : interestType // ignore: cast_nullable_to_non_nullable
              as InterestType,
      payments: null == payments
          ? _value._payments
          : payments // ignore: cast_nullable_to_non_nullable
              as List<MoratoriumPayment>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MoratoriumConfigImpl implements _MoratoriumConfig {
  const _$MoratoriumConfigImpl(
      {this.durationYears = 4.5,
      this.interestRate = 12.0,
      this.interestType = InterestType.simple,
      final List<MoratoriumPayment> payments = const []})
      : _payments = payments;

  factory _$MoratoriumConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$MoratoriumConfigImplFromJson(json);

  @override
  @JsonKey()
  final double durationYears;
  @override
  @JsonKey()
  final double interestRate;
  @override
  @JsonKey()
  final InterestType interestType;
  final List<MoratoriumPayment> _payments;
  @override
  @JsonKey()
  List<MoratoriumPayment> get payments {
    if (_payments is EqualUnmodifiableListView) return _payments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_payments);
  }

  @override
  String toString() {
    return 'MoratoriumConfig(durationYears: $durationYears, interestRate: $interestRate, interestType: $interestType, payments: $payments)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MoratoriumConfigImpl &&
            (identical(other.durationYears, durationYears) ||
                other.durationYears == durationYears) &&
            (identical(other.interestRate, interestRate) ||
                other.interestRate == interestRate) &&
            (identical(other.interestType, interestType) ||
                other.interestType == interestType) &&
            const DeepCollectionEquality().equals(other._payments, _payments));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, durationYears, interestRate,
      interestType, const DeepCollectionEquality().hash(_payments));

  /// Create a copy of MoratoriumConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MoratoriumConfigImplCopyWith<_$MoratoriumConfigImpl> get copyWith =>
      __$$MoratoriumConfigImplCopyWithImpl<_$MoratoriumConfigImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MoratoriumConfigImplToJson(
      this,
    );
  }
}

abstract class _MoratoriumConfig implements MoratoriumConfig {
  const factory _MoratoriumConfig(
      {final double durationYears,
      final double interestRate,
      final InterestType interestType,
      final List<MoratoriumPayment> payments}) = _$MoratoriumConfigImpl;

  factory _MoratoriumConfig.fromJson(Map<String, dynamic> json) =
      _$MoratoriumConfigImpl.fromJson;

  @override
  double get durationYears;
  @override
  double get interestRate;
  @override
  InterestType get interestType;
  @override
  List<MoratoriumPayment> get payments;

  /// Create a copy of MoratoriumConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MoratoriumConfigImplCopyWith<_$MoratoriumConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MoratoriumPayment _$MoratoriumPaymentFromJson(Map<String, dynamic> json) {
  return _MoratoriumPayment.fromJson(json);
}

/// @nodoc
mixin _$MoratoriumPayment {
  double get amount => throw _privateConstructorUsedError;
  double get yearOffset =>
      throw _privateConstructorUsedError; // when during moratorium it was paid
  String get type => throw _privateConstructorUsedError;

  /// Serializes this MoratoriumPayment to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MoratoriumPayment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MoratoriumPaymentCopyWith<MoratoriumPayment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MoratoriumPaymentCopyWith<$Res> {
  factory $MoratoriumPaymentCopyWith(
          MoratoriumPayment value, $Res Function(MoratoriumPayment) then) =
      _$MoratoriumPaymentCopyWithImpl<$Res, MoratoriumPayment>;
  @useResult
  $Res call({double amount, double yearOffset, String type});
}

/// @nodoc
class _$MoratoriumPaymentCopyWithImpl<$Res, $Val extends MoratoriumPayment>
    implements $MoratoriumPaymentCopyWith<$Res> {
  _$MoratoriumPaymentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MoratoriumPayment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = null,
    Object? yearOffset = null,
    Object? type = null,
  }) {
    return _then(_value.copyWith(
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      yearOffset: null == yearOffset
          ? _value.yearOffset
          : yearOffset // ignore: cast_nullable_to_non_nullable
              as double,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MoratoriumPaymentImplCopyWith<$Res>
    implements $MoratoriumPaymentCopyWith<$Res> {
  factory _$$MoratoriumPaymentImplCopyWith(_$MoratoriumPaymentImpl value,
          $Res Function(_$MoratoriumPaymentImpl) then) =
      __$$MoratoriumPaymentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double amount, double yearOffset, String type});
}

/// @nodoc
class __$$MoratoriumPaymentImplCopyWithImpl<$Res>
    extends _$MoratoriumPaymentCopyWithImpl<$Res, _$MoratoriumPaymentImpl>
    implements _$$MoratoriumPaymentImplCopyWith<$Res> {
  __$$MoratoriumPaymentImplCopyWithImpl(_$MoratoriumPaymentImpl _value,
      $Res Function(_$MoratoriumPaymentImpl) _then)
      : super(_value, _then);

  /// Create a copy of MoratoriumPayment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = null,
    Object? yearOffset = null,
    Object? type = null,
  }) {
    return _then(_$MoratoriumPaymentImpl(
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      yearOffset: null == yearOffset
          ? _value.yearOffset
          : yearOffset // ignore: cast_nullable_to_non_nullable
              as double,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MoratoriumPaymentImpl implements _MoratoriumPayment {
  const _$MoratoriumPaymentImpl(
      {required this.amount, required this.yearOffset, this.type = 'One-time'});

  factory _$MoratoriumPaymentImpl.fromJson(Map<String, dynamic> json) =>
      _$$MoratoriumPaymentImplFromJson(json);

  @override
  final double amount;
  @override
  final double yearOffset;
// when during moratorium it was paid
  @override
  @JsonKey()
  final String type;

  @override
  String toString() {
    return 'MoratoriumPayment(amount: $amount, yearOffset: $yearOffset, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MoratoriumPaymentImpl &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.yearOffset, yearOffset) ||
                other.yearOffset == yearOffset) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, amount, yearOffset, type);

  /// Create a copy of MoratoriumPayment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MoratoriumPaymentImplCopyWith<_$MoratoriumPaymentImpl> get copyWith =>
      __$$MoratoriumPaymentImplCopyWithImpl<_$MoratoriumPaymentImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MoratoriumPaymentImplToJson(
      this,
    );
  }
}

abstract class _MoratoriumPayment implements MoratoriumPayment {
  const factory _MoratoriumPayment(
      {required final double amount,
      required final double yearOffset,
      final String type}) = _$MoratoriumPaymentImpl;

  factory _MoratoriumPayment.fromJson(Map<String, dynamic> json) =
      _$MoratoriumPaymentImpl.fromJson;

  @override
  double get amount;
  @override
  double get yearOffset; // when during moratorium it was paid
  @override
  String get type;

  /// Create a copy of MoratoriumPayment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MoratoriumPaymentImplCopyWith<_$MoratoriumPaymentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

EMIMonth _$EMIMonthFromJson(Map<String, dynamic> json) {
  return _EMIMonth.fromJson(json);
}

/// @nodoc
mixin _$EMIMonth {
  int get monthIndex => throw _privateConstructorUsedError;
  double get openingBalance => throw _privateConstructorUsedError;
  double get principalComponent => throw _privateConstructorUsedError;
  double get interestComponent => throw _privateConstructorUsedError;
  double get closingBalance => throw _privateConstructorUsedError;
  double get prepayment => throw _privateConstructorUsedError;
  double get monthlySalary => throw _privateConstructorUsedError;

  /// Serializes this EMIMonth to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EMIMonth
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EMIMonthCopyWith<EMIMonth> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EMIMonthCopyWith<$Res> {
  factory $EMIMonthCopyWith(EMIMonth value, $Res Function(EMIMonth) then) =
      _$EMIMonthCopyWithImpl<$Res, EMIMonth>;
  @useResult
  $Res call(
      {int monthIndex,
      double openingBalance,
      double principalComponent,
      double interestComponent,
      double closingBalance,
      double prepayment,
      double monthlySalary});
}

/// @nodoc
class _$EMIMonthCopyWithImpl<$Res, $Val extends EMIMonth>
    implements $EMIMonthCopyWith<$Res> {
  _$EMIMonthCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EMIMonth
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? monthIndex = null,
    Object? openingBalance = null,
    Object? principalComponent = null,
    Object? interestComponent = null,
    Object? closingBalance = null,
    Object? prepayment = null,
    Object? monthlySalary = null,
  }) {
    return _then(_value.copyWith(
      monthIndex: null == monthIndex
          ? _value.monthIndex
          : monthIndex // ignore: cast_nullable_to_non_nullable
              as int,
      openingBalance: null == openingBalance
          ? _value.openingBalance
          : openingBalance // ignore: cast_nullable_to_non_nullable
              as double,
      principalComponent: null == principalComponent
          ? _value.principalComponent
          : principalComponent // ignore: cast_nullable_to_non_nullable
              as double,
      interestComponent: null == interestComponent
          ? _value.interestComponent
          : interestComponent // ignore: cast_nullable_to_non_nullable
              as double,
      closingBalance: null == closingBalance
          ? _value.closingBalance
          : closingBalance // ignore: cast_nullable_to_non_nullable
              as double,
      prepayment: null == prepayment
          ? _value.prepayment
          : prepayment // ignore: cast_nullable_to_non_nullable
              as double,
      monthlySalary: null == monthlySalary
          ? _value.monthlySalary
          : monthlySalary // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EMIMonthImplCopyWith<$Res>
    implements $EMIMonthCopyWith<$Res> {
  factory _$$EMIMonthImplCopyWith(
          _$EMIMonthImpl value, $Res Function(_$EMIMonthImpl) then) =
      __$$EMIMonthImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int monthIndex,
      double openingBalance,
      double principalComponent,
      double interestComponent,
      double closingBalance,
      double prepayment,
      double monthlySalary});
}

/// @nodoc
class __$$EMIMonthImplCopyWithImpl<$Res>
    extends _$EMIMonthCopyWithImpl<$Res, _$EMIMonthImpl>
    implements _$$EMIMonthImplCopyWith<$Res> {
  __$$EMIMonthImplCopyWithImpl(
      _$EMIMonthImpl _value, $Res Function(_$EMIMonthImpl) _then)
      : super(_value, _then);

  /// Create a copy of EMIMonth
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? monthIndex = null,
    Object? openingBalance = null,
    Object? principalComponent = null,
    Object? interestComponent = null,
    Object? closingBalance = null,
    Object? prepayment = null,
    Object? monthlySalary = null,
  }) {
    return _then(_$EMIMonthImpl(
      monthIndex: null == monthIndex
          ? _value.monthIndex
          : monthIndex // ignore: cast_nullable_to_non_nullable
              as int,
      openingBalance: null == openingBalance
          ? _value.openingBalance
          : openingBalance // ignore: cast_nullable_to_non_nullable
              as double,
      principalComponent: null == principalComponent
          ? _value.principalComponent
          : principalComponent // ignore: cast_nullable_to_non_nullable
              as double,
      interestComponent: null == interestComponent
          ? _value.interestComponent
          : interestComponent // ignore: cast_nullable_to_non_nullable
              as double,
      closingBalance: null == closingBalance
          ? _value.closingBalance
          : closingBalance // ignore: cast_nullable_to_non_nullable
              as double,
      prepayment: null == prepayment
          ? _value.prepayment
          : prepayment // ignore: cast_nullable_to_non_nullable
              as double,
      monthlySalary: null == monthlySalary
          ? _value.monthlySalary
          : monthlySalary // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EMIMonthImpl implements _EMIMonth {
  const _$EMIMonthImpl(
      {required this.monthIndex,
      required this.openingBalance,
      required this.principalComponent,
      required this.interestComponent,
      required this.closingBalance,
      this.prepayment = 0.0,
      this.monthlySalary = 0.0});

  factory _$EMIMonthImpl.fromJson(Map<String, dynamic> json) =>
      _$$EMIMonthImplFromJson(json);

  @override
  final int monthIndex;
  @override
  final double openingBalance;
  @override
  final double principalComponent;
  @override
  final double interestComponent;
  @override
  final double closingBalance;
  @override
  @JsonKey()
  final double prepayment;
  @override
  @JsonKey()
  final double monthlySalary;

  @override
  String toString() {
    return 'EMIMonth(monthIndex: $monthIndex, openingBalance: $openingBalance, principalComponent: $principalComponent, interestComponent: $interestComponent, closingBalance: $closingBalance, prepayment: $prepayment, monthlySalary: $monthlySalary)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EMIMonthImpl &&
            (identical(other.monthIndex, monthIndex) ||
                other.monthIndex == monthIndex) &&
            (identical(other.openingBalance, openingBalance) ||
                other.openingBalance == openingBalance) &&
            (identical(other.principalComponent, principalComponent) ||
                other.principalComponent == principalComponent) &&
            (identical(other.interestComponent, interestComponent) ||
                other.interestComponent == interestComponent) &&
            (identical(other.closingBalance, closingBalance) ||
                other.closingBalance == closingBalance) &&
            (identical(other.prepayment, prepayment) ||
                other.prepayment == prepayment) &&
            (identical(other.monthlySalary, monthlySalary) ||
                other.monthlySalary == monthlySalary));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      monthIndex,
      openingBalance,
      principalComponent,
      interestComponent,
      closingBalance,
      prepayment,
      monthlySalary);

  /// Create a copy of EMIMonth
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EMIMonthImplCopyWith<_$EMIMonthImpl> get copyWith =>
      __$$EMIMonthImplCopyWithImpl<_$EMIMonthImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EMIMonthImplToJson(
      this,
    );
  }
}

abstract class _EMIMonth implements EMIMonth {
  const factory _EMIMonth(
      {required final int monthIndex,
      required final double openingBalance,
      required final double principalComponent,
      required final double interestComponent,
      required final double closingBalance,
      final double prepayment,
      final double monthlySalary}) = _$EMIMonthImpl;

  factory _EMIMonth.fromJson(Map<String, dynamic> json) =
      _$EMIMonthImpl.fromJson;

  @override
  int get monthIndex;
  @override
  double get openingBalance;
  @override
  double get principalComponent;
  @override
  double get interestComponent;
  @override
  double get closingBalance;
  @override
  double get prepayment;
  @override
  double get monthlySalary;

  /// Create a copy of EMIMonth
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EMIMonthImplCopyWith<_$EMIMonthImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Prepayment _$PrepaymentFromJson(Map<String, dynamic> json) {
  return _Prepayment.fromJson(json);
}

/// @nodoc
mixin _$Prepayment {
  double get amount => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  int? get monthIndex =>
      throw _privateConstructorUsedError; // Added for simulation
  PrepaymentMode get mode => throw _privateConstructorUsedError;
  bool get reduceTenure => throw _privateConstructorUsedError;

  /// Serializes this Prepayment to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Prepayment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PrepaymentCopyWith<Prepayment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PrepaymentCopyWith<$Res> {
  factory $PrepaymentCopyWith(
          Prepayment value, $Res Function(Prepayment) then) =
      _$PrepaymentCopyWithImpl<$Res, Prepayment>;
  @useResult
  $Res call(
      {double amount,
      DateTime date,
      int? monthIndex,
      PrepaymentMode mode,
      bool reduceTenure});
}

/// @nodoc
class _$PrepaymentCopyWithImpl<$Res, $Val extends Prepayment>
    implements $PrepaymentCopyWith<$Res> {
  _$PrepaymentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Prepayment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = null,
    Object? date = null,
    Object? monthIndex = freezed,
    Object? mode = null,
    Object? reduceTenure = null,
  }) {
    return _then(_value.copyWith(
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      monthIndex: freezed == monthIndex
          ? _value.monthIndex
          : monthIndex // ignore: cast_nullable_to_non_nullable
              as int?,
      mode: null == mode
          ? _value.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as PrepaymentMode,
      reduceTenure: null == reduceTenure
          ? _value.reduceTenure
          : reduceTenure // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PrepaymentImplCopyWith<$Res>
    implements $PrepaymentCopyWith<$Res> {
  factory _$$PrepaymentImplCopyWith(
          _$PrepaymentImpl value, $Res Function(_$PrepaymentImpl) then) =
      __$$PrepaymentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double amount,
      DateTime date,
      int? monthIndex,
      PrepaymentMode mode,
      bool reduceTenure});
}

/// @nodoc
class __$$PrepaymentImplCopyWithImpl<$Res>
    extends _$PrepaymentCopyWithImpl<$Res, _$PrepaymentImpl>
    implements _$$PrepaymentImplCopyWith<$Res> {
  __$$PrepaymentImplCopyWithImpl(
      _$PrepaymentImpl _value, $Res Function(_$PrepaymentImpl) _then)
      : super(_value, _then);

  /// Create a copy of Prepayment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = null,
    Object? date = null,
    Object? monthIndex = freezed,
    Object? mode = null,
    Object? reduceTenure = null,
  }) {
    return _then(_$PrepaymentImpl(
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      monthIndex: freezed == monthIndex
          ? _value.monthIndex
          : monthIndex // ignore: cast_nullable_to_non_nullable
              as int?,
      mode: null == mode
          ? _value.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as PrepaymentMode,
      reduceTenure: null == reduceTenure
          ? _value.reduceTenure
          : reduceTenure // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PrepaymentImpl implements _Prepayment {
  const _$PrepaymentImpl(
      {required this.amount,
      required this.date,
      this.monthIndex,
      required this.mode,
      this.reduceTenure = true});

  factory _$PrepaymentImpl.fromJson(Map<String, dynamic> json) =>
      _$$PrepaymentImplFromJson(json);

  @override
  final double amount;
  @override
  final DateTime date;
  @override
  final int? monthIndex;
// Added for simulation
  @override
  final PrepaymentMode mode;
  @override
  @JsonKey()
  final bool reduceTenure;

  @override
  String toString() {
    return 'Prepayment(amount: $amount, date: $date, monthIndex: $monthIndex, mode: $mode, reduceTenure: $reduceTenure)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PrepaymentImpl &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.monthIndex, monthIndex) ||
                other.monthIndex == monthIndex) &&
            (identical(other.mode, mode) || other.mode == mode) &&
            (identical(other.reduceTenure, reduceTenure) ||
                other.reduceTenure == reduceTenure));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, amount, date, monthIndex, mode, reduceTenure);

  /// Create a copy of Prepayment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PrepaymentImplCopyWith<_$PrepaymentImpl> get copyWith =>
      __$$PrepaymentImplCopyWithImpl<_$PrepaymentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PrepaymentImplToJson(
      this,
    );
  }
}

abstract class _Prepayment implements Prepayment {
  const factory _Prepayment(
      {required final double amount,
      required final DateTime date,
      final int? monthIndex,
      required final PrepaymentMode mode,
      final bool reduceTenure}) = _$PrepaymentImpl;

  factory _Prepayment.fromJson(Map<String, dynamic> json) =
      _$PrepaymentImpl.fromJson;

  @override
  double get amount;
  @override
  DateTime get date;
  @override
  int? get monthIndex; // Added for simulation
  @override
  PrepaymentMode get mode;
  @override
  bool get reduceTenure;

  /// Create a copy of Prepayment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PrepaymentImplCopyWith<_$PrepaymentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
