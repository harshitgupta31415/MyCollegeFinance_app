import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/college_models.dart';
import '../logic/financial_logic.dart';
import '../../data/services/storage_service.dart';

// Current active college being edited
final activeCollegeProvider = StateProvider<CollegeEntity?>((ref) => null);

// Selected college for dashboard view/stats
final selectedDashboardCollegeProvider = StateProvider<CollegeEntity?>((ref) => null);

// List of all colleges (mock for now, will be fetched from DB)
// List of all colleges (Persistent)
class CollegesNotifier extends StateNotifier<List<CollegeEntity>> {
  final StorageService _storage;
  
  CollegesNotifier(this._storage) : super([]) {
    _load();
  }

  Future<void> _load() async {
    final loaded = await _storage.getColleges();
    if (loaded.isEmpty) {
      final nstru = CollegeEntity(
        collegeId: 'nstru_default',
        collegeName: 'NST-RU',
        location: 'Delhi',
        courseName: 'B.Tech CSE',
        durationYears: 4,
        collectionId: 'priority',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        averagePackage: 1800000, // Implied high package for mac laptop users? Or just 1.5L salary monthly = 18LPA
        fees: [
          YearFee(
            yearNumber: 1,
            tuitionFee: 430000, // 1.9 + 2.4
            hostelFee: 240000,  // 1.2 + 1.2
            laptopFee: 160000,
            miscFee: 150000,
          ),
          const YearFee(yearNumber: 2, tuitionFee: 480000, hostelFee: 240000),
          const YearFee(yearNumber: 3, tuitionFee: 480000, hostelFee: 240000),
          const YearFee(yearNumber: 4, tuitionFee: 480000, hostelFee: 240000),
        ],
        moratoriumConfig: const MoratoriumConfig(
          durationYears: 4.5,
          interestRate: 12.0,
          interestType: InterestType.simple,
        ),
        repaymentConfig: const RepaymentConfig(
          tenureYears: 8,
          interestRate: 12.0,
          salaryConfig: SalaryConfig(
            monthlySalary: 150000,
            annualGrowthPercent: 5.0,
          ),
        ),
      );
      state = [nstru];
      _storage.saveColleges(state);
    } else {
      state = loaded;
    }
  }

  void addCollege(CollegeEntity college) {
    state = [...state, college];
    _storage.saveColleges(state);
  }

  void updateCollege(CollegeEntity college) {
    state = [
      for (final c in state)
        if (c.collegeId == college.collegeId) college else c
    ];
    _storage.saveColleges(state);
  }
  
  void removeCollege(String id) {
    state = state.where((c) => c.collegeId != id).toList();
    _storage.saveColleges(state);
  }
}

final allCollegesProvider = StateNotifierProvider<CollegesNotifier, List<CollegeEntity>>((ref) {
  return CollegesNotifier(ref.watch(storageServiceProvider));
});

// Collections management
class CollectionsNotifier extends StateNotifier<List<CollectionEntity>> {
  final StorageService _storage;
  
  CollectionsNotifier(this._storage) : super([]) {
    _load();
  }

  Future<void> _load() async {
    final loaded = await _storage.getCollections();
    if (loaded.isEmpty) {
      // Default collections
      final defaults = [
        CollectionEntity(collectionId: 'priority', name: 'Priority List', orderIndex: 0, createdAt: DateTime.now()),
        CollectionEntity(collectionId: 'backup', name: 'Backup Options', orderIndex: 1, createdAt: DateTime.now()),
        CollectionEntity(collectionId: 'shortlist', name: 'Shortlist', orderIndex: 2, createdAt: DateTime.now()),
      ];
      state = defaults;
      _storage.saveCollections(defaults);
    } else {
      state = loaded;
    }
  }

  void addCollection(CollectionEntity collection) {
    state = [...state, collection];
    _storage.saveCollections(state);
  }
  
  void removeCollection(String id) {
    state = state.where((c) => c.collectionId != id).toList();
    _storage.saveCollections(state);
  }
}

final collectionsProvider = StateNotifierProvider<CollectionsNotifier, List<CollectionEntity>>((ref) {
  return CollectionsNotifier(ref.watch(storageServiceProvider));
});

// Yearly/Semester Fee data for a specific college
final collegeFeesProvider = StateProvider<List<YearFee>>((ref) => []);

// Scholarships for the active college
final collegeScholarshipsProvider = StateProvider<List<Scholarship>>((ref) => []);

// Expenses for the active college
final collegeExpensesProvider = StateProvider<List<Expense>>((ref) => []);

// Repayment configuration


// Storage Service Provider
final storageServiceProvider = Provider<StorageService>((ref) => StorageService());

// Repayment configuration Notifier
class RepaymentConfigNotifier extends StateNotifier<RepaymentConfig> {
  final StorageService _storage;
  
  RepaymentConfigNotifier(this._storage) : super(const RepaymentConfig(
    tenureYears: 8,
    interestRate: 13.0,
  ));

  void setState(RepaymentConfig config) {
    state = config;
    // Don't save to global storage, we save in CollegeEntity now
  }
}

final repaymentConfigProvider = StateNotifierProvider<RepaymentConfigNotifier, RepaymentConfig>((ref) {
  return RepaymentConfigNotifier(ref.watch(storageServiceProvider));
});

// Moratorium Configuration Notifier
class MoratoriumConfigNotifier extends StateNotifier<MoratoriumConfig> {
  final StorageService _storage;

  MoratoriumConfigNotifier(this._storage) : super(const MoratoriumConfig());

  void setState(MoratoriumConfig config) {
    state = config;
    // Don't save to global storage
  }
}

final moratoriumConfigProvider = StateNotifierProvider<MoratoriumConfigNotifier, MoratoriumConfig>((ref) {
  return MoratoriumConfigNotifier(ref.watch(storageServiceProvider));
});

// Moratorium Impact Calculation
final moratoriumImpactProvider = Provider<Map<String, dynamic>>((ref) {
  final initialPrincipal = ref.watch(loanPrincipalProvider);
  final config = ref.watch(moratoriumConfigProvider);
  
  return LoanEngine.calculateMoratoriumImpact(
    initialPrincipal: initialPrincipal,
    config: config,
  );
});

// CALCULATED PROVIDERS

final netYearCostsProvider = Provider<List<double>>((ref) {
  final fees = ref.watch(collegeFeesProvider);
  final scholarships = ref.watch(collegeScholarshipsProvider);
  
  return fees.map((fee) => ScholarshipEngine.calculateNetYearCost(
    yearNumber: fee.yearNumber,
    tuitionFee: fee.tuitionFee,
    hostelFee: fee.hostelFee,
    examFee: fee.examFee,
    travelFee: fee.travelFee,
    laptopFee: fee.laptopFee,
    miscFee: fee.miscFee,
    scholarships: scholarships,
  )).toList();
});

final loanPrincipalProvider = Provider<double>((ref) {
  final netCosts = ref.watch(netYearCostsProvider);
  final expenses = ref.watch(collegeExpensesProvider);
  final college = ref.watch(activeCollegeProvider);
  
  if (college == null) return 0.0;
  
  return LoanEngine.calculatePrincipal(
    netYearCosts: netCosts,
    otherExpenses: expenses,
    durationYears: college.durationYears,
  );
});

final repaymentScheduleProvider = Provider<Map<String, dynamic>>((ref) {
  final impact = ref.watch(moratoriumImpactProvider);
  final principal = impact['finalPrincipal'] as double;
  final config = ref.watch(repaymentConfigProvider);
  
  return EMIEngine.generateAdvancedSchedule(
    principal: principal,
    annualRate: config.interestRate,
    tenureYears: config.tenureYears,
    salaryConfig: config.salaryConfig,
    prepayments: config.prepayments,
  );
});

final moratoriumTimelineProvider = Provider<List<Map<String, dynamic>>>((ref) {
  final college = ref.watch(activeCollegeProvider);
  if (college == null) return [];
  
  final fees = ref.watch(collegeFeesProvider);
  final scholarships = ref.watch(collegeScholarshipsProvider);
  final config = ref.watch(moratoriumConfigProvider);
  
  return ScholarshipEngine.calculateSemesterTimeline(
    college: college,
    fees: fees,
    scholarships: scholarships,
    moratoriumPayments: config.payments,
    morRate: config.interestRate,
    interestType: config.interestType,
  );
});
