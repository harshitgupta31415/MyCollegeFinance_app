import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../domain/models/college_models.dart';
import '../../domain/providers/finance_providers.dart';

class FeeInputScreen extends ConsumerStatefulWidget {
  const FeeInputScreen({super.key});

  @override
  ConsumerState<FeeInputScreen> createState() => _FeeInputScreenState();
}

class _FeeInputScreenState extends ConsumerState<FeeInputScreen> {
  FeeMode _feeMode = FeeMode.yearly;
  final Map<int, TextEditingController> _tuitionControllers = {};
  final Map<int, TextEditingController> _hostelControllers = {};
  final Map<int, TextEditingController> _examControllers = {};
  final Map<int, TextEditingController> _travelControllers = {};
  final Map<int, TextEditingController> _laptopControllers = {};
  final Map<int, TextEditingController> _miscControllers = {};
  
  final _totalTuitionController = TextEditingController();
  final _totalHostelController = TextEditingController();
  final _totalExamController = TextEditingController();
  final _totalTravelController = TextEditingController();
  final _totalLaptopController = TextEditingController();
  final _totalMiscController = TextEditingController();

  void _fillDemoFees() {
    setState(() {
      _feeMode = FeeMode.total;
      _totalTuitionController.text = "1200000";
      _totalHostelController.text = "400000";
    });
  }

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  @override
  void dispose() {
    _totalTuitionController.dispose();
    _totalHostelController.dispose();
    _totalExamController.dispose();
    _totalTravelController.dispose();
    _totalLaptopController.dispose();
    _totalMiscController.dispose();
    for (var c in _tuitionControllers.values) c.dispose();
    for (var c in _hostelControllers.values) c.dispose();
    for (var c in _examControllers.values) c.dispose();
    for (var c in _travelControllers.values) c.dispose();
    for (var c in _laptopControllers.values) c.dispose();
    for (var c in _miscControllers.values) c.dispose();
    super.dispose();
  }

  void _initializeControllers() {
    final college = ref.read(activeCollegeProvider);
    if (college == null) return;

    _tuitionControllers.values.forEach((c) => c.dispose());
    _hostelControllers.values.forEach((c) => c.dispose());
    _examControllers.values.forEach((c) => c.dispose());
    _travelControllers.values.forEach((c) => c.dispose());
    _laptopControllers.values.forEach((c) => c.dispose());
    _miscControllers.values.forEach((c) => c.dispose());
    
    _tuitionControllers.clear();
    _hostelControllers.clear();
    _examControllers.clear();
    _travelControllers.clear();
    _laptopControllers.clear();
    _miscControllers.clear();

    int count = _feeMode == FeeMode.yearly ? college.durationYears : college.durationYears * 2;
    final existingFees = ref.read(collegeFeesProvider);
    
    for (int i = 1; i <= count; i++) {
      _tuitionControllers[i] = TextEditingController();
      _hostelControllers[i] = TextEditingController();
      _examControllers[i] = TextEditingController();
      _travelControllers[i] = TextEditingController();
      _laptopControllers[i] = TextEditingController();
      _miscControllers[i] = TextEditingController();

      if (existingFees.isNotEmpty && _feeMode == FeeMode.yearly) {
        final f = existingFees.firstWhere((f) => f.yearNumber == i, orElse: () => const YearFee(yearNumber: 0, tuitionFee: 0));
        if (f.yearNumber != 0) {
          _tuitionControllers[i]!.text = f.tuitionFee.toStringAsFixed(0);
          _hostelControllers[i]!.text = f.hostelFee?.toStringAsFixed(0) ?? "";
          _examControllers[i]!.text = f.examFee?.toStringAsFixed(0) ?? "";
          _travelControllers[i]!.text = f.travelFee?.toStringAsFixed(0) ?? "";
          _laptopControllers[i]!.text = f.laptopFee?.toStringAsFixed(0) ?? "";
          _miscControllers[i]!.text = f.miscFee?.toStringAsFixed(0) ?? "";
        }
      }

      if (existingFees.isNotEmpty && _feeMode == FeeMode.semester) {
        int yearNum = ((i - 1) / 2).floor() + 1;
        final f = existingFees.firstWhere((f) => f.yearNumber == yearNum, orElse: () => const YearFee(yearNumber: 0, tuitionFee: 0));
        if (f.yearNumber != 0) {
          _tuitionControllers[i]!.text = (f.tuitionFee / 2).toStringAsFixed(0);
          _hostelControllers[i]!.text = ((f.hostelFee ?? 0) / 2).toStringAsFixed(0);
          _examControllers[i]!.text = ((f.examFee ?? 0) / 2).toStringAsFixed(0);
          _travelControllers[i]!.text = ((f.travelFee ?? 0) / 2).toStringAsFixed(0);
          _laptopControllers[i]!.text = i % 2 != 0 ? (f.laptopFee?.toStringAsFixed(0) ?? "") : ""; // Show only once
          _miscControllers[i]!.text = ((f.miscFee ?? 0) / 2).toStringAsFixed(0);
        }
      }
    }
    
    if (existingFees.isNotEmpty && _feeMode == FeeMode.total) {
      double totalT = 0, totalH = 0, totalE = 0, totalTr = 0, totalL = 0, totalM = 0;
      for (var f in existingFees) {
        totalT += f.tuitionFee;
        totalH += f.hostelFee ?? 0;
        totalE += f.examFee ?? 0;
        totalTr += f.travelFee ?? 0;
        totalL += f.laptopFee ?? 0;
        totalM += f.miscFee ?? 0;
      }
      _totalTuitionController.text = totalT.toStringAsFixed(0);
      _totalHostelController.text = totalH.toStringAsFixed(0);
      _totalExamController.text = totalE.toStringAsFixed(0);
      _totalTravelController.text = totalTr.toStringAsFixed(0);
      _totalLaptopController.text = totalL.toStringAsFixed(0);
      _totalMiscController.text = totalM.toStringAsFixed(0);
    }
  }

  void _distributeFees() {
    final college = ref.read(activeCollegeProvider);
    if (college == null) return;
    
    double totalTuition = double.tryParse(_totalTuitionController.text) ?? 0;
    double totalHostel = double.tryParse(_totalHostelController.text) ?? 0;
    double totalExam = double.tryParse(_totalExamController.text) ?? 0;
    double totalTravel = double.tryParse(_totalTravelController.text) ?? 0;
    double totalLaptop = double.tryParse(_totalLaptopController.text) ?? 0;
    double totalMisc = double.tryParse(_totalMiscController.text) ?? 0;
    
    int count = _feeMode == FeeMode.yearly ? college.durationYears : college.durationYears * 2;
    
    if (totalTuition > 0) {
      double perPeriod = totalTuition / count;
      for (int i = 1; i <= count; i++) _tuitionControllers[i]?.text = perPeriod.toStringAsFixed(0);
    }
    
    if (totalHostel > 0) {
      double perPeriod = totalHostel / count;
      for (int i = 1; i <= count; i++) _hostelControllers[i]?.text = perPeriod.toStringAsFixed(0);
    }

    if (totalExam > 0) {
      double perPeriod = totalExam / count;
      for (int i = 1; i <= count; i++) _examControllers[i]?.text = perPeriod.toStringAsFixed(0);
    }

    if (totalTravel > 0) {
      double perPeriod = totalTravel / count;
      for (int i = 1; i <= count; i++) _travelControllers[i]?.text = perPeriod.toStringAsFixed(0);
    }

    if (totalLaptop > 0) {
      _laptopControllers[1]?.text = totalLaptop.toStringAsFixed(0);
      for (int i = 2; i <= count; i++) _laptopControllers[i]?.text = "0";
    }

    if (totalMisc > 0) {
      double perPeriod = totalMisc / count;
      for (int i = 1; i <= count; i++) _miscControllers[i]?.text = perPeriod.toStringAsFixed(0);
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final college = ref.watch(activeCollegeProvider);
    if (college == null) return const Scaffold(body: Center(child: Text('No college selected')));

    return Scaffold(
      appBar: AppBar(
        title: Text('${college.collegeName} - Fees'),
        actions: [
          if (kDebugMode)
            TextButton.icon(
              onPressed: _fillDemoFees,
              icon: const Icon(Icons.auto_fix_high, color: Colors.green),
              label: const Text('Fast Fill', style: TextStyle(color: Colors.green)),
            ),
        ],
      ),
      body: Column(
        children: [
          _buildModeSelector(),
          const SizedBox(height: 8),
          Expanded(
            child: _feeMode == FeeMode.total 
              ? _buildTotalEntryView(college) 
              : _buildDetailedListView(college),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: ElevatedButton(
              onPressed: _saveFees,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 56),
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: const Text('Save & Continue to Scholarships', style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalEntryView(CollegeEntity college) {
    double totalTuition = double.tryParse(_totalTuitionController.text) ?? 0;
    double totalHostel = double.tryParse(_totalHostelController.text) ?? 0;
    double totalExam = double.tryParse(_totalExamController.text) ?? 0;
    double totalTravel = double.tryParse(_totalTravelController.text) ?? 0;
    double totalMisc = double.tryParse(_totalMiscController.text) ?? 0;

    double yearlyTuition = totalTuition / college.durationYears;
    double yearlyHostel = totalHostel / college.durationYears;
    double yearlyExam = totalExam / college.durationYears;
    double yearlyTravel = totalTravel / college.durationYears;
    double yearlyMisc = totalMisc / college.durationYears;
    
    double totalFeesExceptLaptop = yearlyTuition + yearlyHostel + yearlyExam + yearlyTravel + yearlyMisc;
    double semAverage = totalFeesExceptLaptop / 2;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Enter Total Course Fees',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
          ),
          const SizedBox(height: 8),
          const Text(
            'Include all costs for the entire duration.',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 32),
          _buildAmountField('Total Tuition', _totalTuitionController),
          const SizedBox(height: 16),
          _buildAmountField('Total Hostel (Opt)', _totalHostelController),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _buildAmountField('Exam Fees', _totalExamController)),
              const SizedBox(width: 8),
              Expanded(child: _buildAmountField('Travel/Bus', _totalTravelController)),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _buildAmountField('Laptop/Gear', _totalLaptopController)),
              const SizedBox(width: 8),
              Expanded(child: _buildAmountField('Misc Exp', _totalMiscController)),
            ],
          ),
          const SizedBox(height: 48),
          const Divider(),
          const SizedBox(height: 24),
          const Text('ESTIMATED RECURRING COST', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2, color: Colors.grey, fontSize: 12)),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildBreakdownCard('Yearly Avg', yearlyTuition, yearlyHostel, yearlyExam + yearlyTravel + yearlyMisc),
              const SizedBox(width: 12),
              _buildBreakdownCard('Semester Avg', yearlyTuition / 2, yearlyHostel / 2, (yearlyExam + yearlyTravel + yearlyMisc) / 2),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBreakdownCard(String title, double tuition, double hostel, double other) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.green.withOpacity(0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green, fontSize: 13)),
            const SizedBox(height: 12),
            _buildMiniBreakdown('Tuition', tuition),
            _buildMiniBreakdown('Hostel', hostel),
            _buildMiniBreakdown('Other', other),
            const Divider(height: 16, color: Colors.white10),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                'Total: ₹ ${(tuition + hostel + other).toStringAsFixed(0)}',
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMiniBreakdown(String label, double amount) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 10, color: Colors.white.withOpacity(0.4))),
          Text('₹${amount.toStringAsFixed(0)}', style: const TextStyle(fontSize: 10, color: Colors.white70)),
        ],
      ),
    );
  }

  Widget _buildDetailedListView(CollegeEntity college) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 8),
          child: Row(
            children: [
              Expanded(child: Divider()),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text('INDIVIDUAL BREAKDOWN', style: TextStyle(fontSize: 12, color: Colors.grey, letterSpacing: 1.2)),
              ),
              Expanded(child: Divider()),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: _feeMode == FeeMode.yearly ? college.durationYears : college.durationYears * 2,
            itemBuilder: (context, index) {
              int key = index + 1;
              return _buildFeeCard(key);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildModeSelector() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      color: Colors.white.withOpacity(0.05),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Input Method: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
            const SizedBox(width: 8),
            SegmentedButton<FeeMode>(
              segments: const [
                ButtonSegment(value: FeeMode.total, label: Text('Total', style: TextStyle(fontSize: 12))),
                ButtonSegment(value: FeeMode.yearly, label: Text('Yearly', style: TextStyle(fontSize: 12))),
                ButtonSegment(value: FeeMode.semester, label: Text('Sem', style: TextStyle(fontSize: 12))),
              ],
              selected: {_feeMode},
              onSelectionChanged: (Set<FeeMode> newSelection) {
                _showModeChangeWarning(newSelection.first);
              },
              style: SegmentedButton.styleFrom(
                selectedBackgroundColor: Colors.green,
                selectedForegroundColor: Colors.white,
                visualDensity: VisualDensity.compact,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showModeChangeWarning(FeeMode newMode) {
    if (_feeMode == FeeMode.total && (newMode == FeeMode.yearly || newMode == FeeMode.semester)) {
      setState(() {
        _feeMode = newMode;
        _initializeControllers();
        _distributeFees();
      });
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Change Fee Mode?'),
        content: const Text('Changing the fee mode will restructure your data. Existing inputs for the current mode will be lost.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              setState(() {
                _feeMode = newMode;
                _initializeControllers();
              });
              Navigator.pop(context);
            },
            child: const Text('Change', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  Widget _buildFeeCard(int number) {
    String label = _feeMode == FeeMode.yearly ? 'Year $number' : 'Semester $number';
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.green)),
            const SizedBox(height: 16),
            _buildAmountField('Tuition Fee', _tuitionControllers[number]!),
            const SizedBox(height: 12),
            _buildAmountField('Hostel Fee (Opt)', _hostelControllers[number]!),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: _buildAmountField('Exam Fees', _examControllers[number]!)),
                const SizedBox(width: 8),
                Expanded(child: _buildAmountField('Travel', _travelControllers[number]!)),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: _buildAmountField(number == 1 ? 'Laptop (1-Time)' : 'Hardware/Other', _laptopControllers[number]!)),
                const SizedBox(width: 8),
                Expanded(child: _buildAmountField('Misc', _miscControllers[number]!)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAmountField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      onChanged: (_) {
        if (_feeMode == FeeMode.total) setState(() {});
      },
      style: const TextStyle(fontSize: 15),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(fontSize: 13),
        prefixText: '₹ ',
        hintText: '0',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      ),
    );
  }

  void _saveFees() {
    final List<YearFee> fees = [];
    final college = ref.read(activeCollegeProvider);
    if (college == null) return;

    if (_feeMode == FeeMode.total) {
      double totalTuition = double.tryParse(_totalTuitionController.text) ?? 0;
      double totalHostel = double.tryParse(_totalHostelController.text) ?? 0;
      double totalExam = double.tryParse(_totalExamController.text) ?? 0;
      double totalTravel = double.tryParse(_totalTravelController.text) ?? 0;
      double totalLaptop = double.tryParse(_totalLaptopController.text) ?? 0;
      double totalMisc = double.tryParse(_totalMiscController.text) ?? 0;
      
      double perYearTuition = totalTuition / college.durationYears;
      double perYearHostel = totalHostel / college.durationYears;
      double perYearExam = totalExam / college.durationYears;
      double perYearTravel = totalTravel / college.durationYears;
      double perYearMisc = totalMisc / college.durationYears;

      for (int i = 1; i <= college.durationYears; i++) {
        fees.add(YearFee(
          yearNumber: i,
          tuitionFee: perYearTuition,
          hostelFee: perYearHostel,
          examFee: perYearExam,
          travelFee: perYearTravel,
          laptopFee: i == 1 ? totalLaptop : 0, // Laptop is one-time
          miscFee: perYearMisc,
        ));
      }
    } else if (_feeMode == FeeMode.yearly) {
      _tuitionControllers.forEach((year, _) {
        fees.add(YearFee(
          yearNumber: year,
          tuitionFee: double.tryParse(_tuitionControllers[year]?.text ?? '') ?? 0,
          hostelFee: double.tryParse(_hostelControllers[year]?.text ?? '') ?? 0,
          examFee: double.tryParse(_examControllers[year]?.text ?? '') ?? 0,
          travelFee: double.tryParse(_travelControllers[year]?.text ?? '') ?? 0,
          laptopFee: double.tryParse(_laptopControllers[year]?.text ?? '') ?? 0,
          miscFee: double.tryParse(_miscControllers[year]?.text ?? '') ?? 0,
        ));
      });
    } else {
      // Semester to Yearly conversion
      for (int year = 1; year <= college.durationYears; year++) {
        int s1 = 2 * year - 1;
        int s2 = 2 * year;
        
        fees.add(YearFee(
          yearNumber: year,
          tuitionFee: (double.tryParse(_tuitionControllers[s1]?.text ?? '') ?? 0) + 
                     (double.tryParse(_tuitionControllers[s2]?.text ?? '') ?? 0),
          hostelFee: (double.tryParse(_hostelControllers[s1]?.text ?? '') ?? 0) + 
                    (double.tryParse(_hostelControllers[s2]?.text ?? '') ?? 0),
          examFee: (double.tryParse(_examControllers[s1]?.text ?? '') ?? 0) + 
                  (double.tryParse(_examControllers[s2]?.text ?? '') ?? 0),
          travelFee: (double.tryParse(_travelControllers[s1]?.text ?? '') ?? 0) + 
                    (double.tryParse(_travelControllers[s2]?.text ?? '') ?? 0),
          laptopFee: (double.tryParse(_laptopControllers[s1]?.text ?? '') ?? 0) + 
                    (double.tryParse(_laptopControllers[s2]?.text ?? '') ?? 0),
          miscFee: (double.tryParse(_miscControllers[s1]?.text ?? '') ?? 0) + 
                  (double.tryParse(_miscControllers[s2]?.text ?? '') ?? 0),
        ));
      }
    }
    
    ref.read(collegeFeesProvider.notifier).state = fees;
    context.push('/scholarships');
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Fees saved successfully!')));
  }
}
