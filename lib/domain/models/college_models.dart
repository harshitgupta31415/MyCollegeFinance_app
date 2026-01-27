import 'package:freezed_annotation/freezed_annotation.dart';

part 'college_models.freezed.dart';
part 'college_models.g.dart';

@freezed
class CollectionEntity with _$CollectionEntity {
  const factory CollectionEntity({
    required String collectionId,
    required String name,
    required int orderIndex,
    required DateTime createdAt,
  }) = _CollectionEntity;

  factory CollectionEntity.fromJson(Map<String, dynamic> json) =>
      _$CollectionEntityFromJson(json);
}

@freezed
class CollegeEntity with _$CollegeEntity {
  const factory CollegeEntity({
    required String collegeId,
    required String collegeName,
    required String location,
    required String courseName,
    required int durationYears,
    required String collectionId,
    double? averagePackage, // Added average placement package
    String? notes,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default([]) List<YearFee> fees,
    @Default([]) List<Scholarship> scholarships,
    @Default([]) List<Expense> expenses,
    RepaymentConfig? repaymentConfig,
    MoratoriumConfig? moratoriumConfig,
  }) = _CollegeEntity;

  factory CollegeEntity.fromJson(Map<String, dynamic> json) =>
      _$CollegeEntityFromJson(json);
}

enum FeeMode { yearly, semester, total }

@freezed
class YearFee with _$YearFee {
  const factory YearFee({
    required int yearNumber,
    required double tuitionFee,
    double? hostelFee,
    double? examFee,
    double? travelFee,
    double? laptopFee,
    double? miscFee,
  }) = _YearFee;

  factory YearFee.fromJson(Map<String, dynamic> json) =>
      _$YearFeeFromJson(json);
}

@freezed
class SemesterFee with _$SemesterFee {
  const factory SemesterFee({
    required int semesterNumber,
    required double tuitionFee,
    double? hostelFee,
    double? examFee,
    double? travelFee,
    double? laptopFee,
    double? miscFee,
  }) = _SemesterFee;

  factory SemesterFee.fromJson(Map<String, dynamic> json) =>
      _$SemesterFeeFromJson(json);
}

enum ScholarshipProvider {
  government,
  college,
  private,
  corporate,
  international,
  other
}

enum ScholarshipCategory {
  tuitionWaiver,
  feeReimbursement,
  directCash,
  stipend,
  oneTimeGrant,
  performanceBased,
  loanSubsidy
}

enum ScholarshipValueType { amount, percent }

enum ScholarshipFrequency { perSemester, perYear, oneTime }

enum ScholarshipBasis { tuitionOnly, tuitionAcademic, totalFees, custom }

enum FeeComponent {
  tuition,
  hostel,
  mess,
  exam,
  library,
  laptop,
  travel,
  miscellaneous
}

enum ScholarshipStatus { confirmed, expected, discontinued }

@freezed
class Scholarship with _$Scholarship {
  const factory Scholarship({
    required String scholarshipId,
    required String name,
    @Default(ScholarshipProvider.government) ScholarshipProvider provider,
    @Default(ScholarshipCategory.tuitionWaiver) ScholarshipCategory category,
    required ScholarshipValueType valueType,
    required double value,
    @Default(ScholarshipFrequency.perYear) ScholarshipFrequency frequency,
    @Default(ScholarshipBasis.tuitionOnly) ScholarshipBasis basis,
    @Default([]) List<int> applicableYears,
    @Default([]) List<int> applicableSemesters,
    @Default([FeeComponent.tuition]) List<FeeComponent> feeComponents,
    @Default(ScholarshipStatus.confirmed) ScholarshipStatus status,
    double? minCgpa,
    @Default(false) bool incomeCriteriaMet,
    @Default(false) bool isDiscontinued,
    String? notes,
  }) = _Scholarship;

  factory Scholarship.fromJson(Map<String, dynamic> json) =>
      _$ScholarshipFromJson(json);
}

enum ExpenseType { oneTime, yearly }

@freezed
class Expense with _$Expense {
  const factory Expense({
    required String expenseId,
    required String name,
    required double amount,
    required String category,
    required ExpenseType type,
  }) = _Expense;

  factory Expense.fromJson(Map<String, dynamic> json) =>
      _$ExpenseFromJson(json);
}

@freezed
class RepaymentConfig with _$RepaymentConfig {
  const factory RepaymentConfig({
    @Default(8) int tenureYears,
    @Default(13.0) double interestRate,
    @Default('Monthly') String paymentFrequency,
    @Default(SalaryConfig()) SalaryConfig salaryConfig,
    @Default([]) List<Prepayment> prepayments, // Added prepayments list
  }) = _RepaymentConfig;

  factory RepaymentConfig.fromJson(Map<String, dynamic> json) =>
      _$RepaymentConfigFromJson(json);
}

@freezed
class SalaryConfig with _$SalaryConfig {
  const factory SalaryConfig({
    @Default(0.0) double monthlySalary,
    @Default(0.0) double annualGrowthPercent,
    @Default('Monthly') String allocationMode, // Monthly EMI, Yearly Lump Sum, Mixed
    @Default([]) List<SalaryChange> changes,
  }) = _SalaryConfig;

  factory SalaryConfig.fromJson(Map<String, dynamic> json) =>
      _$SalaryConfigFromJson(json);
}

@freezed
class SalaryChange with _$SalaryChange {
  const factory SalaryChange({
    required int startYear, // 1-based year index
    required double monthlySalary,
    @Default(0.0) double annualGrowthPercent,
  }) = _SalaryChange;

  factory SalaryChange.fromJson(Map<String, dynamic> json) =>
      _$SalaryChangeFromJson(json);
}

enum InterestType { simple, compound }

@freezed
class MoratoriumConfig with _$MoratoriumConfig {
  const factory MoratoriumConfig({
    @Default(4.5) double durationYears,
    @Default(12.0) double interestRate,
    @Default(InterestType.simple) InterestType interestType,
    @Default([]) List<MoratoriumPayment> payments,
  }) = _MoratoriumConfig;

  factory MoratoriumConfig.fromJson(Map<String, dynamic> json) =>
      _$MoratoriumConfigFromJson(json);
}

@freezed
class MoratoriumPayment with _$MoratoriumPayment {
  const factory MoratoriumPayment({
    required double amount,
    required double yearOffset, // when during moratorium it was paid
    @Default('One-time') String type,
  }) = _MoratoriumPayment;

  factory MoratoriumPayment.fromJson(Map<String, dynamic> json) =>
      _$MoratoriumPaymentFromJson(json);
}

@freezed
class EMIMonth with _$EMIMonth {
  const factory EMIMonth({
    required int monthIndex,
    required double openingBalance,
    required double principalComponent,
    required double interestComponent,
    required double closingBalance,
    @Default(0.0) double prepayment,
    @Default(0.0) double monthlySalary,
  }) = _EMIMonth;

  factory EMIMonth.fromJson(Map<String, dynamic> json) =>
      _$EMIMonthFromJson(json);
}

enum PrepaymentMode { lumpSum, monthlyExtra }

@freezed
class Prepayment with _$Prepayment {
  const factory Prepayment({
    required double amount,
    required DateTime date, 
    int? monthIndex, // Added for simulation
    required PrepaymentMode mode,
    @Default(true) bool reduceTenure, // if false, reduce EMI
  }) = _Prepayment;

  factory Prepayment.fromJson(Map<String, dynamic> json) =>
      _$PrepaymentFromJson(json);
}
