import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import '../../domain/providers/finance_providers.dart';
import '../../domain/models/college_models.dart';

class LoanAnalysisScreen extends ConsumerStatefulWidget {
  const LoanAnalysisScreen({super.key});

  @override
  ConsumerState<LoanAnalysisScreen> createState() => _LoanAnalysisScreenState();
}

class _LoanAnalysisScreenState extends ConsumerState<LoanAnalysisScreen> {
  final currencyFormat = NumberFormat.currency(locale: 'en_IN', symbol: '₹', decimalDigits: 0);
  final _salaryController = TextEditingController();
  final _growthController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final config = ref.read(repaymentConfigProvider);
    _salaryController.text = config.salaryConfig.monthlySalary.toString();
    _growthController.text = config.salaryConfig.annualGrowthPercent.toString();
  }

  void _updateConfig({int? tenure, double? rate, SalaryConfig? salary, List<Prepayment>? prepayments}) {
    final current = ref.read(repaymentConfigProvider);
    ref.read(repaymentConfigProvider.notifier).setState(current.copyWith(
      tenureYears: tenure ?? current.tenureYears,
      interestRate: rate ?? current.interestRate,
      salaryConfig: salary ?? current.salaryConfig,
      prepayments: prepayments ?? current.prepayments,
    ));
  }

  void _addSalaryChange(SalaryChange change) {
    final current = ref.read(repaymentConfigProvider);
    final currentChanges = current.salaryConfig.changes;
    final updatedChanges = [...currentChanges, change];
    // Sort by start year
    updatedChanges.sort((a, b) => a.startYear.compareTo(b.startYear));
    
    _updateConfig(salary: current.salaryConfig.copyWith(changes: updatedChanges));
  }

  void _removeSalaryChange(SalaryChange change) {
    final current = ref.read(repaymentConfigProvider);
    final updatedChanges = current.salaryConfig.changes.where((c) => c != change).toList();
    _updateConfig(salary: current.salaryConfig.copyWith(changes: updatedChanges));
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(repaymentConfigProvider, (previous, next) {
      if (previous?.salaryConfig != next.salaryConfig) {
        if (_salaryController.text != next.salaryConfig.monthlySalary.toString() && 
            double.tryParse(_salaryController.text) != next.salaryConfig.monthlySalary) {
          _salaryController.text = next.salaryConfig.monthlySalary.toString();
        }
        if (_growthController.text != next.salaryConfig.annualGrowthPercent.toString() &&
            double.tryParse(_growthController.text) != next.salaryConfig.annualGrowthPercent) {
          _growthController.text = next.salaryConfig.annualGrowthPercent.toString();
        }
      }
    });

    final analysisResult = ref.watch(repaymentScheduleProvider);
    final schedule = analysisResult['schedule'] as List<EMIMonth>;
    final config = ref.watch(repaymentConfigProvider);
    final timeline = ref.watch(moratoriumTimelineProvider);
    final impact = ref.watch(moratoriumImpactProvider);
    final initialPrincipal = ref.watch(loanPrincipalProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        title: const Text('Final Loan Analysis'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInterestTip(),
            const SizedBox(height: 20),
            _buildGraphCard(schedule, impact['finalPrincipal']),
            const SizedBox(height: 32),
            _buildParamSection(config),
            const SizedBox(height: 32),
            _buildSalarySection(config),
            const SizedBox(height: 32),
            _buildMoratoriumTimelineHeader(),
            const SizedBox(height: 16),
            _buildMoratoriumTimeline(timeline, initialPrincipal),
            const SizedBox(height: 32),
            _buildEMIPhaseHeader(impact['finalPrincipal']),
            const SizedBox(height: 16),
            _buildResultGrid(analysisResult),
            const SizedBox(height: 32),
            _buildSavingsCard(analysisResult),
            const SizedBox(height: 32),
            _buildDetailedSchedule(schedule),
            const SizedBox(height: 100),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: const Color(0xFF1E293B),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 10, offset: const Offset(0, -5))],
        ),
        child: ElevatedButton(
          onPressed: _saveAndFinish,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.greenAccent,
            foregroundColor: Colors.black,
            minimumSize: const Size(double.infinity, 56),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
          child: const Text('Save & Finish', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  void _saveAndFinish() {
    final college = ref.read(activeCollegeProvider);
    if (college == null) return;
    
    final updatedCollege = college.copyWith(
      fees: ref.read(collegeFeesProvider),
      scholarships: ref.read(collegeScholarshipsProvider),
      expenses: ref.read(collegeExpensesProvider),
      repaymentConfig: ref.read(repaymentConfigProvider),
      moratoriumConfig: ref.read(moratoriumConfigProvider),
      updatedAt: DateTime.now(),
    );
    
    final allColleges = ref.read(allCollegesProvider);
    final exists = allColleges.any((c) => c.collegeId == updatedCollege.collegeId);
    
    if (exists) {
      ref.read(allCollegesProvider.notifier).updateCollege(updatedCollege);
    } else {
      ref.read(allCollegesProvider.notifier).addCollege(updatedCollege);
    }
    
    context.go('/');
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('College Analysis Saved!')));
  }

  Widget _buildInterestTip() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blueAccent.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blueAccent.withOpacity(0.3)),
      ),
      child: const Row(
        children: [
          Icon(Icons.info_outline, color: Colors.blueAccent, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Section 80E: Interest is tax-deductible for up to 8 years.',
              style: TextStyle(color: Colors.blueAccent, fontSize: 12, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGraphCard(List<EMIMonth> schedule, double startBalance) {
    final timeline = ref.watch(moratoriumTimelineProvider);
    final moratoriumConfig = ref.watch(moratoriumConfigProvider);
    final college = ref.watch(activeCollegeProvider);
    
    // Build graph spots from moratorium (year 0) through EMI completion
    List<FlSpot> spots = [];
    
    // Add moratorium period spots (semester by semester)
    for (var sem in timeline) {
      double yearOffset = ((sem['sem'] as int) - 1) * 0.5; // Sem 1 = 0, Sem 2 = 0.5, Sem 3 = 1, etc.
      spots.add(FlSpot(yearOffset, sem['balance']));
    }
    
    // Add EMI phase spots (every 12 months = 1 year)
    double moratoriumYears = moratoriumConfig.durationYears;
    for (int i = 0; i < schedule.length; i += 12) {
      if (i < schedule.length) {
        double yearOffset = moratoriumYears + (i / 12);
        spots.add(FlSpot(yearOffset, schedule[i].closingBalance));
      }
    }
    
    // Add final point if exists
    if (schedule.isNotEmpty) {
      double finalYear = moratoriumYears + (schedule.length / 12);
      spots.add(FlSpot(finalYear, schedule.last.closingBalance));
    }
    
    double maxY = spots.isEmpty ? startBalance : spots.map((s) => s.y).reduce((a, b) => a > b ? a : b);
    double maxX = spots.isEmpty ? 10 : spots.last.x;
    
    return Container(
      height: 300,
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('LOAN PRINCIPAL TIMELINE', style: TextStyle(color: Colors.white38, fontSize: 10, letterSpacing: 1.2)),
          const SizedBox(height: 4),
          Text('Moratorium → EMI Phase', style: TextStyle(color: Colors.white.withOpacity(0.3), fontSize: 9)),
          const SizedBox(height: 16),
          Expanded(
            child: LineChart(
              LineChartData(
                minX: 0,
                maxX: maxX,
                minY: 0,
                maxY: maxY * 1.1,
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: true,
                  drawHorizontalLine: true,
                  horizontalInterval: maxY / 4,
                  verticalInterval: 2,
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: Colors.white.withOpacity(0.05),
                    strokeWidth: 1,
                  ),
                  getDrawingVerticalLine: (value) => FlLine(
                    color: Colors.white.withOpacity(0.05),
                    strokeWidth: 1,
                    dashArray: value == moratoriumYears ? null : [5, 5],
                  ),
                ),
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      interval: 2,
                      getTitlesWidget: (value, meta) {
                        if (value == moratoriumYears) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text('EMI\nStart', style: TextStyle(color: Colors.orangeAccent, fontSize: 9), textAlign: TextAlign.center),
                          );
                        }
                        return Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text('Y${value.toInt()}', style: TextStyle(color: Colors.white.withOpacity(0.3), fontSize: 10)),
                        );
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 45,
                      interval: maxY / 4,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          '₹${(value / 100000).toStringAsFixed(1)}L',
                          style: TextStyle(color: Colors.white.withOpacity(0.3), fontSize: 9),
                        );
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(
                  show: true,
                  border: Border(
                    bottom: BorderSide(color: Colors.white.withOpacity(0.1)),
                    left: BorderSide(color: Colors.white.withOpacity(0.1)),
                  ),
                ),
                lineTouchData: LineTouchData(
                  enabled: true,
                  touchTooltipData: LineTouchTooltipData(
                    tooltipBgColor: const Color(0xFF1E293B),
                    tooltipRoundedRadius: 8,
                    getTooltipItems: (List<LineBarSpot> touchedSpots) {
                      return touchedSpots.map((spot) {
                        return LineTooltipItem(
                          'Year ${spot.x.toStringAsFixed(1)}\n${currencyFormat.format(spot.y)}',
                          const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                        );
                      }).toList();
                    },
                  ),
                ),
                extraLinesData: ExtraLinesData(
                  verticalLines: [
                    // Moratorium end marker
                    VerticalLine(
                      x: moratoriumYears,
                      color: Colors.orangeAccent.withOpacity(0.5),
                      strokeWidth: 2,
                      dashArray: [8, 4],
                      label: VerticalLineLabel(
                        show: true,
                        alignment: Alignment.topRight,
                        style: const TextStyle(color: Colors.orangeAccent, fontSize: 9),
                        labelResolver: (line) => 'Moratorium Ends',
                      ),
                    ),
                  ],
                  horizontalLines: [
                    // Baseline at initial principal
                    HorizontalLine(
                      y: startBalance,
                      color: Colors.blueAccent.withOpacity(0.3),
                      strokeWidth: 1.5,
                      dashArray: [5, 5],
                      label: HorizontalLineLabel(
                        show: true,
                        alignment: Alignment.topRight,
                        style: const TextStyle(color: Colors.blueAccent, fontSize: 8),
                        labelResolver: (line) => 'Initial Principal',
                      ),
                    ),
                  ],
                ),
                lineBarsData: [
                  LineChartBarData(
                    spots: spots,
                    isCurved: true,
                    color: Colors.greenAccent,
                    barWidth: 3,
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        colors: [Colors.greenAccent.withOpacity(0.2), Colors.greenAccent.withOpacity(0.0)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, barData, index) {
                        // Highlight moratorium end point
                        if ((spot.x - moratoriumYears).abs() < 0.1) {
                          return FlDotCirclePainter(
                            radius: 5,
                            color: Colors.orangeAccent,
                            strokeWidth: 2,
                            strokeColor: Colors.white,
                          );
                        }
                        return FlDotCirclePainter(
                          radius: 2,
                          color: Colors.greenAccent,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildParamSection(RepaymentConfig config) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Loan Parameters'),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withOpacity(0.05)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.calendar_today, color: Colors.blueAccent, size: 20),
                      const SizedBox(width: 8),
                      const Text('Loan Tenure', style: TextStyle(color: Colors.white70)),
                    ],
                  ),
                  Text('${config.tenureYears} Years', style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 12),
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: Colors.blueAccent,
                  inactiveTrackColor: Colors.blueAccent.withOpacity(0.2),
                  thumbColor: Colors.white,
                  overlayColor: Colors.blueAccent.withOpacity(0.2),
                  trackHeight: 4,
                  thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
                  overlayShape: const RoundSliderOverlayShape(overlayRadius: 20),
                ),
                child: Slider(
                  value: config.tenureYears.toDouble(),
                  min: 1,
                  max: 30,
                  divisions: 29,
                  onChanged: (value) => _updateConfig(tenure: value.toInt()),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('1 Yr', style: TextStyle(color: Colors.white24, fontSize: 10)),
                    Text('30 Yrs', style: TextStyle(color: Colors.white24, fontSize: 10)),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        _buildInputCard(
          'Interest Rate',
          '${config.interestRate}%',
          Icons.trending_up,
          () => _showRatePicker(config),
        ),
      ],
    );
  }

  Widget _buildSalarySection(RepaymentConfig config) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Salary & Cashflow Simulation'),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              TextField(
                controller: _salaryController,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white),
                onChanged: (v) => _updateConfig(salary: config.salaryConfig.copyWith(monthlySalary: double.tryParse(v) ?? 0)),
                decoration: InputDecoration(
                  labelText: 'Starting Monthly Salary (Year 1)',
                  prefixText: '₹ ',
                  labelStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _growthController,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white),
                onChanged: (v) => _updateConfig(salary: config.salaryConfig.copyWith(annualGrowthPercent: double.tryParse(v) ?? 0)),
                decoration: InputDecoration(
                  labelText: 'Base Annual Hike (%)',
                  suffixText: '%',
                  labelStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  const Text('Career Phases', style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold)),
                  const Spacer(),
                  TextButton.icon(
                    onPressed: () => _showSalaryChangeDialog(),
                    icon: const Icon(Icons.add, size: 16, color: Colors.blueAccent),
                    label: const Text('Add Phase', style: TextStyle(color: Colors.blueAccent)),
                  ),
                ],
              ),
              if (config.salaryConfig.changes.isEmpty)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text('No custom salary phases added. Using base growth.', style: TextStyle(color: Colors.white38, fontSize: 12, fontStyle: FontStyle.italic)),
                )
              else
                ...config.salaryConfig.changes.map((change) => Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.blueAccent.withOpacity(0.3)),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 12,
                        backgroundColor: Colors.blueAccent.withOpacity(0.2),
                        child: Text('${change.startYear}', style: const TextStyle(fontSize: 10, color: Colors.blueAccent)),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Year ${change.startYear} Onwards', style: const TextStyle(color: Colors.white70, fontSize: 12)),
                          Text(currencyFormat.format(change.monthlySalary), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.redAccent, size: 16),
                        onPressed: () => _removeSalaryChange(change),
                      ),
                    ],
                  ),
                )),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMoratoriumTimelineHeader() {
    return const Row(
      children: [
        Text('MORATORIUM TIMELINE', style: TextStyle(color: Colors.greenAccent, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
        Spacer(),
        Text('Study Period', style: TextStyle(color: Colors.white24, fontSize: 11)),
      ],
    );
  }

  Widget _buildMoratoriumTimeline(List<Map<String, dynamic>> timeline, double initial) {
    return Column(
      children: timeline.map((sem) {
        bool hasLaptop = sem['laptop'] > 0;
        return InkWell(
          onTap: () => _showMoratoriumPrepaymentDialog(sem['sem']),
          borderRadius: BorderRadius.circular(16),
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.03),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white.withOpacity(0.05)),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 14,
                      backgroundColor: Colors.blueAccent.withOpacity(0.2),
                      child: Text('S${sem['sem']}', style: const TextStyle(color: Colors.blueAccent, fontSize: 10, fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(width: 12),
                    const Text('Tuition & Fees', style: TextStyle(color: Colors.white70, fontSize: 13)),
                    const Spacer(),
                    Text(currencyFormat.format(sem['tuition'] + sem['hostel'] + sem['misc']), style: const TextStyle(color: Colors.white)),
                    const SizedBox(width: 8),
                    const Icon(Icons.add_circle_outline, color: Colors.greenAccent, size: 16),
                  ],
                ),
                if (hasLaptop)
                  Padding(
                    padding: const EdgeInsets.only(top: 8, left: 40),
                    child: Row(
                      children: [
                        const Text('Hardware/Laptop', style: TextStyle(color: Colors.white38, fontSize: 12)),
                        const Spacer(),
                        Text(currencyFormat.format(sem['laptop']), style: const TextStyle(color: Colors.white38, fontSize: 12)),
                      ],
                    ),
                  ),
                if (sem['scholarship'] > 0)
                  Padding(
                    padding: const EdgeInsets.only(top: 8, left: 40),
                    child: Row(
                      children: [
                        const Text('Scholarship Applied', style: TextStyle(color: Colors.greenAccent, fontSize: 12)),
                        const Spacer(),
                        Text('- ${currencyFormat.format(sem['scholarship'])}', style: const TextStyle(color: Colors.greenAccent, fontSize: 12, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                if (sem['payment'] > 0)
                  Padding(
                    padding: const EdgeInsets.only(top: 8, left: 40),
                    child: Row(
                      children: [
                        const Icon(Icons.payment, color: Colors.amberAccent, size: 12),
                        const SizedBox(width: 4),
                        const Text('Prepayment Made', style: TextStyle(color: Colors.amberAccent, fontSize: 12)),
                        const Spacer(),
                        Text('- ${currencyFormat.format(sem['payment'])}', style: const TextStyle(color: Colors.amberAccent, fontSize: 12, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                const Divider(height: 24, color: Colors.white10),
                Row(
                  children: [
                    const Text('Principal Growth', style: TextStyle(color: Colors.white24, fontSize: 11)),
                    const Spacer(),
                    const Text('Outstanding: ', style: TextStyle(color: Colors.white24, fontSize: 11)),
                    Text(currencyFormat.format(sem['balance']), style: const TextStyle(color: Colors.white60, fontSize: 11, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildEMIPhaseHeader(double finalPrincipal) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.orangeAccent.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        'EMI PHASE BEGINS • FINAL PRINCIPAL: ${currencyFormat.format(finalPrincipal)}',
        style: const TextStyle(color: Colors.orangeAccent, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 0.5),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildResultGrid(Map<String, dynamic> result) {
    final schedule = result['schedule'] as List<EMIMonth>;
    final emi = schedule.isNotEmpty ? (schedule.first.principalComponent + schedule.first.interestComponent) : 0.0;

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 1.5,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      children: [
        _buildStatCard('Monthly EMI', currencyFormat.format(emi), Colors.greenAccent),
        _buildStatCard('Total Interest', currencyFormat.format(result['totalInterest']), Colors.orangeAccent),
        _buildStatCard('Tenure Remaining', '${(schedule.length / 12).toStringAsFixed(1)} Yrs', Colors.blueAccent),
        _buildStatCard('Total Payback', currencyFormat.format(result['totalAmount']), Colors.white),
      ],
    );
  }

  Widget _buildSavingsCard(Map<String, dynamic> result) {
    if (result['savings'] <= 0) return const SizedBox.shrink();
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.greenAccent.withOpacity(0.05),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.greenAccent.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.auto_awesome, color: Colors.greenAccent, size: 24),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('YOUR TOTAL SAVINGS', style: TextStyle(color: Colors.greenAccent, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1)),
                  Text(currencyFormat.format(result['savings']), style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'By making prepayments and salary allocations, you are saving ${currencyFormat.format(result['savings'])} in interest and finishing the loan ${result['monthsSaved']} months early!',
            style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailedSchedule(List<EMIMonth> schedule) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Annual Repayment Drill-down'),
        const SizedBox(height: 16),
        ...List.generate((schedule.length / 12).ceil(), (yearIdx) {
          final yearNum = yearIdx + 1;
          final months = schedule.sublist(yearIdx * 12, min((yearIdx + 1) * 12, schedule.length));
          
          return Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              title: Text('Year $yearNum', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              subtitle: Text('Balance: ${currencyFormat.format(months.last.closingBalance)}', style: const TextStyle(color: Colors.white38, fontSize: 12)),
              children: months.map((m) => InkWell(
                onTap: () => _showEMIPrepaymentDialog(m.monthIndex),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  margin: const EdgeInsets.only(bottom: 4),
                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.02), borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Month ${m.monthIndex}', style: const TextStyle(color: Colors.white38, fontSize: 11)),
                          if (m.monthlySalary > 0)
                            Text(
                              'Left: ${currencyFormat.format(m.monthlySalary - (m.principalComponent + m.interestComponent + m.prepayment))}',
                              style: const TextStyle(color: Colors.greenAccent, fontSize: 10, fontWeight: FontWeight.bold),
                            ),
                        ],
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Text(currencyFormat.format(m.principalComponent + m.interestComponent), style: const TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.bold)),
                              const SizedBox(width: 4),
                              const Icon(Icons.add_circle_outline, color: Colors.greenAccent, size: 12),
                            ],
                          ),
                          Text('P: ${currencyFormat.format(m.principalComponent)} | I: ${currencyFormat.format(m.interestComponent)}', style: const TextStyle(color: Colors.white24, fontSize: 10)),
                          if (m.prepayment > 0)
                            Text('Prepaid: ${currencyFormat.format(m.prepayment)}', style: const TextStyle(color: Colors.amberAccent, fontSize: 9)),
                        ],
                      ),
                    ],
                  ),
                ),
              )).toList(),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title.toUpperCase(),
      style: const TextStyle(color: Colors.greenAccent, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.2),
    );
  }

  Widget _buildInputCard(String label, String value, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), borderRadius: BorderRadius.circular(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: Colors.white24, size: 20),
            const SizedBox(height: 12),
            Text(label, style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 12)),
            const SizedBox(height: 4),
            Text(value, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label, style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 11)),
          const SizedBox(height: 4),
          FittedBox(fit: BoxFit.scaleDown, child: Text(value, style: TextStyle(color: color, fontSize: 18, fontWeight: FontWeight.bold))),
        ],
      ),
    );
  }



  void _showRatePicker(RepaymentConfig config) {
    final controller = TextEditingController(text: config.interestRate.toString());
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E293B),
        title: const Text('Interest Rate', style: TextStyle(color: Colors.white)),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          autofocus: true,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(suffixText: '% p.a.', suffixStyle: TextStyle(color: Colors.white24)),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(onPressed: () {
            _updateConfig(rate: double.tryParse(controller.text));
            Navigator.pop(context);
          }, child: const Text('Set')),
        ],
      ),
    );
  }

  Widget _buildDisplayCard(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05), 
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.white24, size: 20),
          const SizedBox(height: 12),
          Text(label, style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 12)),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  void _showMoratoriumPrepaymentDialog(int semNumber) {
    final amountController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E293B),
        title: Text('Add Prepayment - Semester $semNumber', style: const TextStyle(color: Colors.white)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Making a prepayment during moratorium reduces the principal and saves on future interest accumulation.',
              style: TextStyle(color: Colors.white60, fontSize: 12),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              autofocus: true,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Prepayment Amount',
                prefixText: '₹ ',
                labelStyle: TextStyle(color: Colors.white60),
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              final amount = double.tryParse(amountController.text) ?? 0;
              if (amount > 0) {
                final current = ref.read(moratoriumConfigProvider);
                final yearOffset = (semNumber - 1) * 0.5; // Sem 1 = 0, Sem 2 = 0.5, Sem 3 = 1, etc.
                final newPayment = MoratoriumPayment(amount: amount, yearOffset: yearOffset);
                _updateMoratoriumPayments([...current.payments, newPayment]);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Prepayment of ${currencyFormat.format(amount)} added for Semester $semNumber')),
                );
              }
            },
            child: const Text('Add Prepayment', style: TextStyle(color: Colors.greenAccent)),
          ),
        ],
      ),
    );
  }

  void _showEMIPrepaymentDialog(int monthIndex) {
    final amountController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E293B),
        title: Text('Add Prepayment - Month $monthIndex', style: const TextStyle(color: Colors.white)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'EMI prepayments reduce your outstanding principal and can save significant interest over the loan tenure.',
              style: TextStyle(color: Colors.white60, fontSize: 12),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              autofocus: true,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Prepayment Amount',
                prefixText: '₹ ',
                labelStyle: TextStyle(color: Colors.white60),
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              final amount = double.tryParse(amountController.text) ?? 0;
              if (amount > 0) {
                final prepaymentDate = DateTime.now().add(Duration(days: monthIndex * 30));
                final newPrepayment = Prepayment(
                  amount: amount,
                  date: prepaymentDate,
                  monthIndex: monthIndex,
                  mode: PrepaymentMode.lumpSum,
                  reduceTenure: true,
                );
                // Add to prepayments in provider
                final currentConfig = ref.read(repaymentConfigProvider);
                final updatedPrepayments = [...currentConfig.prepayments, newPrepayment];
                
                _updateConfig(prepayments: updatedPrepayments);
                
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('EMI prepayment of ${currencyFormat.format(amount)} added for Month $monthIndex')),
                );
              }
            },
            child: const Text('Add Prepayment', style: TextStyle(color: Colors.greenAccent)),
          ),
        ],
      ),
    );
  }

  void _showSalaryChangeDialog() {
    final yearController = TextEditingController();
    final salaryController = TextEditingController();
    final growthController = TextEditingController(text: '0');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E293B),
        title: const Text('Add Career Phase', style: TextStyle(color: Colors.white)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             const Text(
              'Define a new career phase with a updated total salary.',
              style: TextStyle(color: Colors.white60, fontSize: 12),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: yearController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Start Year (e.g. 3)',
                labelStyle: TextStyle(color: Colors.white60),
                border: OutlineInputBorder(),
                helperText: 'Years from start of loan repayment',
                helperStyle: TextStyle(color: Colors.white38),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: salaryController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'New Monthly Salary',
                prefixText: '₹ ',
                labelStyle: TextStyle(color: Colors.white60),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
             TextField(
              controller: growthController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Expected Growth (%)',
                suffixText: '%',
                labelStyle: TextStyle(color: Colors.white60),
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              final year = int.tryParse(yearController.text) ?? 0;
              final salary = double.tryParse(salaryController.text) ?? 0;
              final growth = double.tryParse(growthController.text) ?? 0;
              
              if (year > 1 && salary > 0) {
                 _addSalaryChange(SalaryChange(
                   startYear: year,
                   monthlySalary: salary,
                   annualGrowthPercent: growth,
                 ));
                 Navigator.pop(context);
              }
            },
            child: const Text('Add Phase', style: TextStyle(color: Colors.greenAccent)),
          ),
        ],
      ),
    );
  }

  void _updateMoratoriumPayments(List<MoratoriumPayment> payments) {
    final current = ref.read(moratoriumConfigProvider);
    ref.read(moratoriumConfigProvider.notifier).setState(current.copyWith(payments: payments));
  }
  
  int min(int a, int b) => a < b ? a : b;
}
