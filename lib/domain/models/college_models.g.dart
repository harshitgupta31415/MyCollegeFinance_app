// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'college_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CollectionEntityImpl _$$CollectionEntityImplFromJson(
        Map<String, dynamic> json) =>
    _$CollectionEntityImpl(
      collectionId: json['collectionId'] as String,
      name: json['name'] as String,
      orderIndex: (json['orderIndex'] as num).toInt(),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$CollectionEntityImplToJson(
        _$CollectionEntityImpl instance) =>
    <String, dynamic>{
      'collectionId': instance.collectionId,
      'name': instance.name,
      'orderIndex': instance.orderIndex,
      'createdAt': instance.createdAt.toIso8601String(),
    };

_$CollegeEntityImpl _$$CollegeEntityImplFromJson(Map<String, dynamic> json) =>
    _$CollegeEntityImpl(
      collegeId: json['collegeId'] as String,
      collegeName: json['collegeName'] as String,
      location: json['location'] as String,
      courseName: json['courseName'] as String,
      durationYears: (json['durationYears'] as num).toInt(),
      collectionId: json['collectionId'] as String,
      averagePackage: (json['averagePackage'] as num?)?.toDouble(),
      notes: json['notes'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      fees: (json['fees'] as List<dynamic>?)
              ?.map((e) => YearFee.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      scholarships: (json['scholarships'] as List<dynamic>?)
              ?.map((e) => Scholarship.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      expenses: (json['expenses'] as List<dynamic>?)
              ?.map((e) => Expense.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      repaymentConfig: json['repaymentConfig'] == null
          ? null
          : RepaymentConfig.fromJson(
              json['repaymentConfig'] as Map<String, dynamic>),
      moratoriumConfig: json['moratoriumConfig'] == null
          ? null
          : MoratoriumConfig.fromJson(
              json['moratoriumConfig'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$CollegeEntityImplToJson(_$CollegeEntityImpl instance) =>
    <String, dynamic>{
      'collegeId': instance.collegeId,
      'collegeName': instance.collegeName,
      'location': instance.location,
      'courseName': instance.courseName,
      'durationYears': instance.durationYears,
      'collectionId': instance.collectionId,
      'averagePackage': instance.averagePackage,
      'notes': instance.notes,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'fees': instance.fees,
      'scholarships': instance.scholarships,
      'expenses': instance.expenses,
      'repaymentConfig': instance.repaymentConfig,
      'moratoriumConfig': instance.moratoriumConfig,
    };

_$YearFeeImpl _$$YearFeeImplFromJson(Map<String, dynamic> json) =>
    _$YearFeeImpl(
      yearNumber: (json['yearNumber'] as num).toInt(),
      tuitionFee: (json['tuitionFee'] as num).toDouble(),
      hostelFee: (json['hostelFee'] as num?)?.toDouble(),
      examFee: (json['examFee'] as num?)?.toDouble(),
      travelFee: (json['travelFee'] as num?)?.toDouble(),
      laptopFee: (json['laptopFee'] as num?)?.toDouble(),
      miscFee: (json['miscFee'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$YearFeeImplToJson(_$YearFeeImpl instance) =>
    <String, dynamic>{
      'yearNumber': instance.yearNumber,
      'tuitionFee': instance.tuitionFee,
      'hostelFee': instance.hostelFee,
      'examFee': instance.examFee,
      'travelFee': instance.travelFee,
      'laptopFee': instance.laptopFee,
      'miscFee': instance.miscFee,
    };

_$SemesterFeeImpl _$$SemesterFeeImplFromJson(Map<String, dynamic> json) =>
    _$SemesterFeeImpl(
      semesterNumber: (json['semesterNumber'] as num).toInt(),
      tuitionFee: (json['tuitionFee'] as num).toDouble(),
      hostelFee: (json['hostelFee'] as num?)?.toDouble(),
      examFee: (json['examFee'] as num?)?.toDouble(),
      travelFee: (json['travelFee'] as num?)?.toDouble(),
      laptopFee: (json['laptopFee'] as num?)?.toDouble(),
      miscFee: (json['miscFee'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$SemesterFeeImplToJson(_$SemesterFeeImpl instance) =>
    <String, dynamic>{
      'semesterNumber': instance.semesterNumber,
      'tuitionFee': instance.tuitionFee,
      'hostelFee': instance.hostelFee,
      'examFee': instance.examFee,
      'travelFee': instance.travelFee,
      'laptopFee': instance.laptopFee,
      'miscFee': instance.miscFee,
    };

_$ScholarshipImpl _$$ScholarshipImplFromJson(Map<String, dynamic> json) =>
    _$ScholarshipImpl(
      scholarshipId: json['scholarshipId'] as String,
      name: json['name'] as String,
      provider:
          $enumDecodeNullable(_$ScholarshipProviderEnumMap, json['provider']) ??
              ScholarshipProvider.government,
      category:
          $enumDecodeNullable(_$ScholarshipCategoryEnumMap, json['category']) ??
              ScholarshipCategory.tuitionWaiver,
      valueType: $enumDecode(_$ScholarshipValueTypeEnumMap, json['valueType']),
      value: (json['value'] as num).toDouble(),
      frequency: $enumDecodeNullable(
              _$ScholarshipFrequencyEnumMap, json['frequency']) ??
          ScholarshipFrequency.perYear,
      basis: $enumDecodeNullable(_$ScholarshipBasisEnumMap, json['basis']) ??
          ScholarshipBasis.tuitionOnly,
      applicableYears: (json['applicableYears'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [],
      applicableSemesters: (json['applicableSemesters'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [],
      feeComponents: (json['feeComponents'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$FeeComponentEnumMap, e))
              .toList() ??
          const [FeeComponent.tuition],
      status: $enumDecodeNullable(_$ScholarshipStatusEnumMap, json['status']) ??
          ScholarshipStatus.confirmed,
      minCgpa: (json['minCgpa'] as num?)?.toDouble(),
      incomeCriteriaMet: json['incomeCriteriaMet'] as bool? ?? false,
      isDiscontinued: json['isDiscontinued'] as bool? ?? false,
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$$ScholarshipImplToJson(_$ScholarshipImpl instance) =>
    <String, dynamic>{
      'scholarshipId': instance.scholarshipId,
      'name': instance.name,
      'provider': _$ScholarshipProviderEnumMap[instance.provider]!,
      'category': _$ScholarshipCategoryEnumMap[instance.category]!,
      'valueType': _$ScholarshipValueTypeEnumMap[instance.valueType]!,
      'value': instance.value,
      'frequency': _$ScholarshipFrequencyEnumMap[instance.frequency]!,
      'basis': _$ScholarshipBasisEnumMap[instance.basis]!,
      'applicableYears': instance.applicableYears,
      'applicableSemesters': instance.applicableSemesters,
      'feeComponents':
          instance.feeComponents.map((e) => _$FeeComponentEnumMap[e]!).toList(),
      'status': _$ScholarshipStatusEnumMap[instance.status]!,
      'minCgpa': instance.minCgpa,
      'incomeCriteriaMet': instance.incomeCriteriaMet,
      'isDiscontinued': instance.isDiscontinued,
      'notes': instance.notes,
    };

const _$ScholarshipProviderEnumMap = {
  ScholarshipProvider.government: 'government',
  ScholarshipProvider.college: 'college',
  ScholarshipProvider.private: 'private',
  ScholarshipProvider.corporate: 'corporate',
  ScholarshipProvider.international: 'international',
  ScholarshipProvider.other: 'other',
};

const _$ScholarshipCategoryEnumMap = {
  ScholarshipCategory.tuitionWaiver: 'tuitionWaiver',
  ScholarshipCategory.feeReimbursement: 'feeReimbursement',
  ScholarshipCategory.directCash: 'directCash',
  ScholarshipCategory.stipend: 'stipend',
  ScholarshipCategory.oneTimeGrant: 'oneTimeGrant',
  ScholarshipCategory.performanceBased: 'performanceBased',
  ScholarshipCategory.loanSubsidy: 'loanSubsidy',
};

const _$ScholarshipValueTypeEnumMap = {
  ScholarshipValueType.amount: 'amount',
  ScholarshipValueType.percent: 'percent',
};

const _$ScholarshipFrequencyEnumMap = {
  ScholarshipFrequency.perSemester: 'perSemester',
  ScholarshipFrequency.perYear: 'perYear',
  ScholarshipFrequency.oneTime: 'oneTime',
};

const _$ScholarshipBasisEnumMap = {
  ScholarshipBasis.tuitionOnly: 'tuitionOnly',
  ScholarshipBasis.tuitionAcademic: 'tuitionAcademic',
  ScholarshipBasis.totalFees: 'totalFees',
  ScholarshipBasis.custom: 'custom',
};

const _$FeeComponentEnumMap = {
  FeeComponent.tuition: 'tuition',
  FeeComponent.hostel: 'hostel',
  FeeComponent.mess: 'mess',
  FeeComponent.exam: 'exam',
  FeeComponent.library: 'library',
  FeeComponent.laptop: 'laptop',
  FeeComponent.travel: 'travel',
  FeeComponent.miscellaneous: 'miscellaneous',
};

const _$ScholarshipStatusEnumMap = {
  ScholarshipStatus.confirmed: 'confirmed',
  ScholarshipStatus.expected: 'expected',
  ScholarshipStatus.discontinued: 'discontinued',
};

_$ExpenseImpl _$$ExpenseImplFromJson(Map<String, dynamic> json) =>
    _$ExpenseImpl(
      expenseId: json['expenseId'] as String,
      name: json['name'] as String,
      amount: (json['amount'] as num).toDouble(),
      category: json['category'] as String,
      type: $enumDecode(_$ExpenseTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$$ExpenseImplToJson(_$ExpenseImpl instance) =>
    <String, dynamic>{
      'expenseId': instance.expenseId,
      'name': instance.name,
      'amount': instance.amount,
      'category': instance.category,
      'type': _$ExpenseTypeEnumMap[instance.type]!,
    };

const _$ExpenseTypeEnumMap = {
  ExpenseType.oneTime: 'oneTime',
  ExpenseType.yearly: 'yearly',
};

_$RepaymentConfigImpl _$$RepaymentConfigImplFromJson(
        Map<String, dynamic> json) =>
    _$RepaymentConfigImpl(
      tenureYears: (json['tenureYears'] as num?)?.toInt() ?? 8,
      interestRate: (json['interestRate'] as num?)?.toDouble() ?? 13.0,
      paymentFrequency: json['paymentFrequency'] as String? ?? 'Monthly',
      salaryConfig: json['salaryConfig'] == null
          ? const SalaryConfig()
          : SalaryConfig.fromJson(json['salaryConfig'] as Map<String, dynamic>),
      prepayments: (json['prepayments'] as List<dynamic>?)
              ?.map((e) => Prepayment.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$RepaymentConfigImplToJson(
        _$RepaymentConfigImpl instance) =>
    <String, dynamic>{
      'tenureYears': instance.tenureYears,
      'interestRate': instance.interestRate,
      'paymentFrequency': instance.paymentFrequency,
      'salaryConfig': instance.salaryConfig,
      'prepayments': instance.prepayments,
    };

_$SalaryConfigImpl _$$SalaryConfigImplFromJson(Map<String, dynamic> json) =>
    _$SalaryConfigImpl(
      monthlySalary: (json['monthlySalary'] as num?)?.toDouble() ?? 0.0,
      annualGrowthPercent:
          (json['annualGrowthPercent'] as num?)?.toDouble() ?? 0.0,
      allocationMode: json['allocationMode'] as String? ?? 'Monthly',
      changes: (json['changes'] as List<dynamic>?)
              ?.map((e) => SalaryChange.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$SalaryConfigImplToJson(_$SalaryConfigImpl instance) =>
    <String, dynamic>{
      'monthlySalary': instance.monthlySalary,
      'annualGrowthPercent': instance.annualGrowthPercent,
      'allocationMode': instance.allocationMode,
      'changes': instance.changes,
    };

_$SalaryChangeImpl _$$SalaryChangeImplFromJson(Map<String, dynamic> json) =>
    _$SalaryChangeImpl(
      startYear: (json['startYear'] as num).toInt(),
      monthlySalary: (json['monthlySalary'] as num).toDouble(),
      annualGrowthPercent:
          (json['annualGrowthPercent'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$$SalaryChangeImplToJson(_$SalaryChangeImpl instance) =>
    <String, dynamic>{
      'startYear': instance.startYear,
      'monthlySalary': instance.monthlySalary,
      'annualGrowthPercent': instance.annualGrowthPercent,
    };

_$MoratoriumConfigImpl _$$MoratoriumConfigImplFromJson(
        Map<String, dynamic> json) =>
    _$MoratoriumConfigImpl(
      durationYears: (json['durationYears'] as num?)?.toDouble() ?? 4.5,
      interestRate: (json['interestRate'] as num?)?.toDouble() ?? 12.0,
      interestType:
          $enumDecodeNullable(_$InterestTypeEnumMap, json['interestType']) ??
              InterestType.simple,
      payments: (json['payments'] as List<dynamic>?)
              ?.map(
                  (e) => MoratoriumPayment.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$MoratoriumConfigImplToJson(
        _$MoratoriumConfigImpl instance) =>
    <String, dynamic>{
      'durationYears': instance.durationYears,
      'interestRate': instance.interestRate,
      'interestType': _$InterestTypeEnumMap[instance.interestType]!,
      'payments': instance.payments,
    };

const _$InterestTypeEnumMap = {
  InterestType.simple: 'simple',
  InterestType.compound: 'compound',
};

_$MoratoriumPaymentImpl _$$MoratoriumPaymentImplFromJson(
        Map<String, dynamic> json) =>
    _$MoratoriumPaymentImpl(
      amount: (json['amount'] as num).toDouble(),
      yearOffset: (json['yearOffset'] as num).toDouble(),
      type: json['type'] as String? ?? 'One-time',
    );

Map<String, dynamic> _$$MoratoriumPaymentImplToJson(
        _$MoratoriumPaymentImpl instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'yearOffset': instance.yearOffset,
      'type': instance.type,
    };

_$EMIMonthImpl _$$EMIMonthImplFromJson(Map<String, dynamic> json) =>
    _$EMIMonthImpl(
      monthIndex: (json['monthIndex'] as num).toInt(),
      openingBalance: (json['openingBalance'] as num).toDouble(),
      principalComponent: (json['principalComponent'] as num).toDouble(),
      interestComponent: (json['interestComponent'] as num).toDouble(),
      closingBalance: (json['closingBalance'] as num).toDouble(),
      prepayment: (json['prepayment'] as num?)?.toDouble() ?? 0.0,
      monthlySalary: (json['monthlySalary'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$$EMIMonthImplToJson(_$EMIMonthImpl instance) =>
    <String, dynamic>{
      'monthIndex': instance.monthIndex,
      'openingBalance': instance.openingBalance,
      'principalComponent': instance.principalComponent,
      'interestComponent': instance.interestComponent,
      'closingBalance': instance.closingBalance,
      'prepayment': instance.prepayment,
      'monthlySalary': instance.monthlySalary,
    };

_$PrepaymentImpl _$$PrepaymentImplFromJson(Map<String, dynamic> json) =>
    _$PrepaymentImpl(
      amount: (json['amount'] as num).toDouble(),
      date: DateTime.parse(json['date'] as String),
      monthIndex: (json['monthIndex'] as num?)?.toInt(),
      mode: $enumDecode(_$PrepaymentModeEnumMap, json['mode']),
      reduceTenure: json['reduceTenure'] as bool? ?? true,
    );

Map<String, dynamic> _$$PrepaymentImplToJson(_$PrepaymentImpl instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'date': instance.date.toIso8601String(),
      'monthIndex': instance.monthIndex,
      'mode': _$PrepaymentModeEnumMap[instance.mode]!,
      'reduceTenure': instance.reduceTenure,
    };

const _$PrepaymentModeEnumMap = {
  PrepaymentMode.lumpSum: 'lumpSum',
  PrepaymentMode.monthlyExtra: 'monthlyExtra',
};
