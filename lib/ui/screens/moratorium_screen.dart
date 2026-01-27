import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../domain/models/college_models.dart';
import '../../domain/providers/finance_providers.dart';

class MoratoriumScreen extends ConsumerStatefulWidget {
  const MoratoriumScreen({super.key});

  @override
  ConsumerState<MoratoriumScreen> createState() => _MoratoriumScreenState();
}

class _MoratoriumScreenState extends ConsumerState<MoratoriumScreen> {
  final currencyFormat = NumberFormat.currency(locale: 'en_IN', symbol: '₹', decimalDigits: 0);
  late TextEditingController _durationController;
  late TextEditingController _rateController;

  @override
  void initState() {
    super.initState();
    final config = ref.read(moratoriumConfigProvider);
    _durationController = TextEditingController(text: config.durationYears.toString());
    _rateController = TextEditingController(text: config.interestRate.toString());
  }

  @override
  void dispose() {
    _durationController.dispose();
    _rateController.dispose();
    super.dispose();
  }

  void _updateConfig({double? duration, double? rate, InterestType? type, List<MoratoriumPayment>? payments}) {
    final current = ref.read(moratoriumConfigProvider);
    ref.read(moratoriumConfigProvider.notifier).setState(current.copyWith(
      durationYears: duration ?? current.durationYears,
      interestRate: rate ?? current.interestRate,
      interestType: type ?? current.interestType,
      payments: payments ?? current.payments,
    ));
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(moratoriumConfigProvider, (previous, next) {
      if (previous?.durationYears != next.durationYears) {
         if (double.tryParse(_durationController.text) != next.durationYears) {
            _durationController.text = next.durationYears.toString();
         }
      }
      if (previous?.interestRate != next.interestRate) {
         if (double.tryParse(_rateController.text) != next.interestRate) {
            _rateController.text = next.interestRate.toString();
         }
      }
    });

    final impact = ref.watch(moratoriumImpactProvider);
    final initialPrincipal = ref.watch(loanPrincipalProvider);
    final config = ref.watch(moratoriumConfigProvider);
    final college = ref.watch(activeCollegeProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        title: const Text('Moratorium Period'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPrincipalCard(initialPrincipal),
            const SizedBox(height: 32),
            _buildSectionTitle('Moratorium Settings'),
            const SizedBox(height: 16),
            _buildDurationInput(),
            const SizedBox(height: 16),
            _buildRateInput(),
            const SizedBox(height: 16),
            _buildInterestTypeToggle(config),
            const SizedBox(height: 32),
            _buildSectionTitle('Payments During Moratorium (Optional)'),
            const SizedBox(height: 16),
            _buildPaymentsList(config),
            const SizedBox(height: 32),
            _buildResultSummary(impact),
            const SizedBox(height: 32),
            _buildAIRecommendations(impact, initialPrincipal, college),
            const SizedBox(height: 100),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(impact),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title.toUpperCase(),
      style: const TextStyle(color: Colors.greenAccent, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.2),
    );
  }

  Widget _buildPrincipalCard(double initialPrincipal) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Loan Principal Before Moratorium',
            style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 14),
          ),
          const SizedBox(height: 8),
          Text(
            currencyFormat.format(initialPrincipal),
            style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          const Text(
            '(Total Net Cost - Scholarships)',
            style: TextStyle(color: Colors.white24, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildDurationInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Duration (Years)', style: TextStyle(color: Colors.white70)),
        const SizedBox(height: 8),
        TextField(
          controller: _durationController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          style: const TextStyle(color: Colors.white),
          onChanged: (v) => _updateConfig(duration: double.tryParse(v)),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white.withOpacity(0.05),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
            helperText: 'For 4-year degrees, 4.5 years is typical (Course + 6 months)',
            helperStyle: TextStyle(color: Colors.white.withOpacity(0.3)),
          ),
        ),
      ],
    );
  }

  Widget _buildRateInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Interest Rate (% p.a.)', style: TextStyle(color: Colors.white70)),
        const SizedBox(height: 8),
        TextField(
          controller: _rateController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          style: const TextStyle(color: Colors.white),
          onChanged: (v) => _updateConfig(rate: double.tryParse(v)),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white.withOpacity(0.05),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
            suffixIcon: const Icon(Icons.percent, color: Colors.white24),
            helperText: 'Banks usually charge simple interest during moratorium',
            helperStyle: TextStyle(color: Colors.white.withOpacity(0.3)),
          ),
        ),
      ],
    );
  }

  Widget _buildInterestTypeToggle(MoratoriumConfig config) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Interest Type', style: TextStyle(color: Colors.white70)),
                Text('Simple is recommended', style: TextStyle(color: Colors.greenAccent, fontSize: 10)),
              ],
            ),
          ),
          const SizedBox(width: 8),
          SegmentedButton<InterestType>(
            segments: const [
              ButtonSegment(value: InterestType.simple, label: Text('Simple')),
              ButtonSegment(value: InterestType.compound, label: Text('Compound')),
            ],
            selected: {config.interestType},
            onSelectionChanged: (Set<InterestType> newSelection) {
              _updateConfig(type: newSelection.first);
            },
            style: SegmentedButton.styleFrom(
              selectedBackgroundColor: Colors.greenAccent,
              selectedForegroundColor: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentsList(MoratoriumConfig config) {
    return Column(
      children: [
        ...config.payments.asMap().entries.map((entry) {
          int idx = entry.key;
          MoratoriumPayment p = entry.value;
          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.03),
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              title: Text(currencyFormat.format(p.amount), style: const TextStyle(color: Colors.white)),
              subtitle: Text('Paid at Year ${p.yearOffset}', style: const TextStyle(color: Colors.white38, fontSize: 12)),
              trailing: IconButton(
                icon: const Icon(Icons.remove_circle_outline, color: Colors.redAccent, size: 20),
                onPressed: () {
                  final newPayments = List<MoratoriumPayment>.from(config.payments)..removeAt(idx);
                  _updateConfig(payments: newPayments);
                },
              ),
            ),
          );
        }).toList(),
        OutlinedButton.icon(
          onPressed: _showAddPaymentDialog,
          icon: const Icon(Icons.add_circle_outline),
          label: const Text('Add Payment Made during Moratorium'),
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.greenAccent,
            side: const BorderSide(color: Colors.greenAccent),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ],
    );
  }

  void _showAddPaymentDialog() {
    final amountController = TextEditingController();
    final yearController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E293B),
        title: const Text('Add Payment', style: TextStyle(color: Colors.white)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              autofocus: true,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(labelText: 'Amount (₹)', labelStyle: TextStyle(color: Colors.white60)),
            ),
            TextField(
              controller: yearController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(labelText: 'Year of Payment (offset)', labelStyle: TextStyle(color: Colors.white60)),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              final amount = double.tryParse(amountController.text) ?? 0;
              final year = double.tryParse(yearController.text) ?? 0;
              if (amount > 0) {
                final current = ref.read(moratoriumConfigProvider);
                _updateConfig(payments: [...current.payments, MoratoriumPayment(amount: amount, yearOffset: year)]);
              }
              Navigator.pop(context);
            },
            child: const Text('Add', style: TextStyle(color: Colors.greenAccent)),
          ),
        ],
      ),
    );
  }

  Widget _buildResultSummary(Map<String, dynamic> impact) {
    double interest = impact['totalInterest'];
    double finalPrincipal = impact['finalPrincipal'];
    double payments = impact['totalPayments'];

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blueAccent.withOpacity(0.1), Colors.greenAccent.withOpacity(0.1)],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        children: [
          _buildResultRow('Interest Accrued', currencyFormat.format(interest), Colors.orangeAccent),
          
          // Year-wise breakup
          Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              title: const Text('View Year-wise Breakup', style: TextStyle(color: Colors.white38, fontSize: 12)),
              childrenPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              tilePadding: EdgeInsets.zero,
              children: (impact['yearWise'] as List<Map<String, double>>).map((y) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Year ${y['year']!.toInt()}', style: const TextStyle(color: Colors.white24, fontSize: 12)),
                      Text(currencyFormat.format(y['interest']), style: const TextStyle(color: Colors.white38, fontSize: 12)),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),

          if (payments > 0)
            _buildResultRow('Total Payments', '- ${currencyFormat.format(payments)}', Colors.greenAccent),
          const Divider(height: 32, color: Colors.white10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(child: Text('Principal After Moratorium', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
              const SizedBox(width: 8),
              Text(
                currencyFormat.format(finalPrincipal),
                style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildResultRow(String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(label, style: const TextStyle(color: Colors.white70))),
          const SizedBox(width: 8),
          Text(value, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildAIRecommendations(Map<String, dynamic> impact, double initialPrincipal, CollegeEntity? college) {
    final config = ref.watch(moratoriumConfigProvider);
    final List<String> recs = [];

    // Calculate saving if duration reduced by 0.5 years
    double reducedDuration = config.durationYears - 0.5;
    if (reducedDuration > 0) {
      double reducedInterest = initialPrincipal * (config.interestRate / 100) * reducedDuration;
      double savings = impact['totalInterest'] - reducedInterest;
      if (savings > 0) {
        recs.add('Reducing moratorium by 6 months can save ${currencyFormat.format(savings)}');
      }
    }

    if (impact['totalPayments'] < 100000) {
      recs.add('Paying just ₹2,000 monthly during moratorium can reduce final principal by ₹${_formatCompact(2000 * config.durationYears * 12)}');
    }

    if (config.durationYears > (college?.durationYears ?? 0) + 1) {
      recs.add('⚠️ Caution: Moratorium period is significantly longer than course duration.');
    }

    if (recs.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.lightbulb_outline, color: Colors.amberAccent, size: 16),
            const SizedBox(width: 8),
            Expanded(child: _buildSectionTitle('Smart Recommendations')),
          ],
        ),
        const SizedBox(height: 12),
        ...recs.map((r) => Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: r.contains('⚠️') ? Colors.redAccent.withOpacity(0.1) : Colors.amberAccent.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(r, style: TextStyle(color: r.contains('⚠️') ? Colors.redAccent : Colors.amberAccent, fontSize: 13)),
        )),
      ],
    );
  }

  String _formatCompact(double value) {
    if (value >= 100000) return '${(value / 100000).toStringAsFixed(1)}L';
    if (value >= 1000) return '${(value / 1000).toStringAsFixed(1)}k';
    return value.toStringAsFixed(0);
  }

  Widget _buildBottomNav(Map<String, dynamic> impact) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 10, offset: const Offset(0, -5))],
      ),
      child: ElevatedButton(
        onPressed: () => context.push('/loan-analysis'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.greenAccent,
          foregroundColor: Colors.black,
          minimumSize: const Size(double.infinity, 56),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        child: const Text('Proceed to Final Analysis', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
