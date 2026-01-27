import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../domain/models/college_models.dart';
import '../../domain/providers/finance_providers.dart';

class ScholarshipScreen extends ConsumerStatefulWidget {
  const ScholarshipScreen({super.key});

  @override
  ConsumerState<ScholarshipScreen> createState() => _ScholarshipScreenState();
}

class _ScholarshipScreenState extends ConsumerState<ScholarshipScreen> {
  final List<Scholarship> _scholarships = [];
  final currencyFormat = NumberFormat.currency(locale: 'en_IN', symbol: '₹', decimalDigits: 0);

  @override
  void initState() {
    super.initState();
    // Load existing scholarships if any
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final existing = ref.read(collegeScholarshipsProvider);
      if (existing.isNotEmpty) {
        setState(() {
          _scholarships.clear();
          _scholarships.addAll(existing);
        });
      }
    });
  }

  void _addScholarship({Scholarship? existing, int? index}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _ScholarshipForm(
        initialScholarship: existing,
        onSave: (scholarship) {
          setState(() {
            if (index != null) {
              _scholarships[index] = scholarship;
            } else {
              _scholarships.add(scholarship);
            }
          });
          ref.read(collegeScholarshipsProvider.notifier).state = [..._scholarships];
        },
      ),
    );
  }

  void _removeScholarship(int index) {
    setState(() => _scholarships.removeAt(index));
    ref.read(collegeScholarshipsProvider.notifier).state = [..._scholarships];
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final college = ref.watch(activeCollegeProvider);
    
    double totalScholarship = _scholarships.fold(0, (sum, item) {
      if (item.valueType == ScholarshipValueType.amount) {
        double multiplier = 1.0;
        if (item.frequency == ScholarshipFrequency.perSemester) {
          multiplier = item.applicableSemesters.length.toDouble();
        } else if (item.frequency == ScholarshipFrequency.perYear) {
          multiplier = item.applicableYears.length.toDouble();
        }
        return sum + (item.value * multiplier);
      } else {
        // Simple approximation for the summary percent scholarships
        return sum + (item.applicableYears.length * 25000); 
      }
    });

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A), // Dark Navy
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 220,
            pinned: true,
            backgroundColor: const Color(0xFF1E293B),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF0F172A), Color(0xFF1E293B)],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Scholarships & Aid',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Maximize your funding to reduce loan burden.',
                        style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 16),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          _buildSummaryItem(
                            'Total Aid',
                            currencyFormat.format(totalScholarship),
                            Icons.account_balance_wallet,
                            Colors.greenAccent,
                          ),
                          const SizedBox(width: 16),
                          _buildSummaryItem(
                            'Active',
                            '${_scholarships.length} Items',
                            Icons.verified,
                            Colors.blueAccent,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Your Applied Scholarships',
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  if (_scholarships.isEmpty)
                    _buildEmptyState()
                  else
                    ...List.generate(_scholarships.length, (index) => _buildScholarshipCard(index)),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addScholarship,
        backgroundColor: Colors.greenAccent,
        foregroundColor: Colors.black,
        icon: const Icon(Icons.add),
        label: const Text('Add Scholarship', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: const Color(0xFF1E293B),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 10, offset: const Offset(0, -5))
          ],
        ),
        child: ElevatedButton(
          onPressed: () => context.push('/moratorium-period'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.greenAccent,
            foregroundColor: Colors.black,
            minimumSize: const Size(double.infinity, 56),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
          child: const Text('Continue to Moratorium', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(height: 8),
            Text(label, style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 12)),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(value, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.1), style: BorderStyle.none),
      ),
      child: Column(
        children: [
          Icon(Icons.card_giftcard, size: 64, color: Colors.white.withOpacity(0.2)),
          const SizedBox(height: 16),
          const Text(
            'No Scholarships Added',
            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Add any aid, grants or discounts you have received.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white.withOpacity(0.5)),
          ),
          const SizedBox(height: 24),
          OutlinedButton(
            onPressed: _addScholarship,
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.greenAccent,
              side: const BorderSide(color: Colors.greenAccent),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Add Scholarship'),
          ),
        ],
      ),
    );
  }

  Widget _buildScholarshipCard(int index) {
    final s = _scholarships[index];
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Dismissible(
          key: Key(s.scholarshipId),
          direction: DismissDirection.endToStart,
          background: Container(
            color: Colors.redAccent,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          onDismissed: (_) => _removeScholarship(index),
          child: ListTile(
            contentPadding: const EdgeInsets.all(16),
            leading: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.greenAccent.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.stars, color: Colors.greenAccent),
            ),
            title: Text(s.name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text(
                  '${s.valueType == ScholarshipValueType.percent ? '${s.value}%' : currencyFormat.format(s.value)} • ${s.provider.name.toUpperCase()}',
                  style: TextStyle(color: Colors.white.withOpacity(0.6)),
                ),
                const SizedBox(height: 4),
                Text(
                  'Applies to ${s.feeComponents.length} components • ${s.applicableYears.length} years',
                  style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 12),
                ),
              ],
            ),
            onTap: () => _addScholarship(existing: s, index: index),
            trailing: const Icon(Icons.chevron_right, color: Colors.white24),
          ),
        ),
      ),
    );
  }
}

class _ScholarshipForm extends ConsumerStatefulWidget {
  final Scholarship? initialScholarship;
  final Function(Scholarship) onSave;
  const _ScholarshipForm({this.initialScholarship, required this.onSave});

  @override
  ConsumerState<_ScholarshipForm> createState() => _ScholarshipFormState();
}

class _ScholarshipFormState extends ConsumerState<_ScholarshipForm> {
  final _nameController = TextEditingController();
  final _valueController = TextEditingController();
  
  @override
  void initState() {
    super.initState();
    if (widget.initialScholarship != null) {
      final s = widget.initialScholarship!;
      _nameController.text = s.name;
      _valueController.text = s.value.toString();
      _provider = s.provider;
      _category = s.category;
      _valueType = s.valueType;
      _frequency = s.frequency;
      _basis = s.basis;
      _status = s.status;
      _selectedSemesters = List.from(s.applicableSemesters);
      _selectedComponents = List.from(s.feeComponents);
      _expandedYears = s.applicableYears.isNotEmpty ? [s.applicableYears.first] : [1];
      _minCgpa = s.minCgpa;
      _incomeCriteria = s.incomeCriteriaMet;
    }
  }
  
  ScholarshipProvider _provider = ScholarshipProvider.government;
  ScholarshipCategory _category = ScholarshipCategory.tuitionWaiver;
  ScholarshipValueType _valueType = ScholarshipValueType.amount;
  ScholarshipFrequency _frequency = ScholarshipFrequency.perYear;
  ScholarshipBasis _basis = ScholarshipBasis.tuitionOnly;
  ScholarshipStatus _status = ScholarshipStatus.confirmed;
  
  List<int> _expandedYears = [1];
  List<int> _selectedSemesters = [1, 2];
  List<FeeComponent> _selectedComponents = [FeeComponent.tuition];
  
  double? _minCgpa;
  bool _incomeCriteria = false;
  bool _showNameError = false;

  void _submit() {
    if (_nameController.text.trim().isEmpty) {
      setState(() => _showNameError = true);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter scholarship name')),
      );
      return;
    }
    
    // Derive applicable years from selected semesters
    final applicableYears = _selectedSemesters.map((s) => ((s - 1) / 2).floor() + 1).toSet().toList()..sort();

    final scholarship = (widget.initialScholarship ?? Scholarship(
      scholarshipId: DateTime.now().millisecondsSinceEpoch.toString(),
      name: '',
      provider: ScholarshipProvider.government,
      category: ScholarshipCategory.tuitionWaiver,
      valueType: ScholarshipValueType.amount,
      value: 0,
      frequency: ScholarshipFrequency.perYear,
      basis: ScholarshipBasis.tuitionOnly,
      applicableYears: [],
      applicableSemesters: [],
      feeComponents: [],
      status: ScholarshipStatus.confirmed,
    )).copyWith(
      name: _nameController.text,
      provider: _provider,
      category: _category,
      valueType: _valueType,
      value: double.tryParse(_valueController.text) ?? 0,
      frequency: _frequency,
      basis: _basis,
      applicableYears: applicableYears,
      applicableSemesters: _selectedSemesters,
      feeComponents: _selectedComponents,
      status: _status,
      minCgpa: _minCgpa,
      incomeCriteriaMet: _incomeCriteria,
    );
    
    widget.onSave(scholarship);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: const BoxDecoration(
        color: Color(0xFF1E293B),
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        children: [
          _buildFormHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle('Basic Information'),
                  _buildTextField(
                    'Scholarship Name', 
                    _nameController, 
                    Icons.edit, 
                    error: _showNameError,
                    onChanged: (v) {
                      if (_showNameError && v.isNotEmpty) {
                        setState(() => _showNameError = false);
                      }
                    }
                  ),
                  const SizedBox(height: 16),
                  _buildDropdown<ScholarshipProvider>(
                    'Provider', 
                    ScholarshipProvider.values, 
                    _provider, 
                    (v) => setState(() => _provider = v!)
                  ),
                  const SizedBox(height: 16),
                  _buildDropdown<ScholarshipCategory>(
                    'Benefit Type', 
                    ScholarshipCategory.values, 
                    _category, 
                    (v) => setState(() => _category = v!)
                  ),
                  
                  const SizedBox(height: 32),
                  _buildSectionTitle('Amount & Calculation'),
                  _buildValueInput(),
                  
                  const SizedBox(height: 32),
                  _buildSectionTitle('Coverage & Duration'),
                  _buildYearSelection(),
                  const SizedBox(height: 16),
                  _buildComponentSelection(),
                  
                  const SizedBox(height: 32),
                  _buildSectionTitle('Conditions & Eligibility'),
                  _buildConditionToggle('Income Criteria Applicable', _incomeCriteria, (v) => setState(() => _incomeCriteria = v)),
                  const SizedBox(height: 12),
                  _buildCgpaInput(),
                  
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.greenAccent,
                      foregroundColor: Colors.black,
                      minimumSize: const Size(double.infinity, 56),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    child: const Text('Add Scholarship', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.1))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('New Scholarship', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(color: Colors.greenAccent, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.5),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, IconData icon, {bool error = false, ValueChanged<String>? onChanged}) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: error ? Colors.redAccent : Colors.white.withOpacity(0.5)),
        prefixIcon: Icon(icon, color: error ? Colors.redAccent : Colors.white.withOpacity(0.5)),
        filled: true,
        fillColor: Colors.white.withOpacity(0.05),
        enabledBorder: error 
          ? OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: Colors.redAccent))
          : null,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
      ),
    );
  }

  Widget _buildDropdown<T extends Enum>(String label, List<T> values, T current, ValueChanged<T?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 12)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(16),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<T>(
              value: current,
              isExpanded: true,
              dropdownColor: const Color(0xFF1E293B),
              style: const TextStyle(color: Colors.white),
              items: values.map((e) => DropdownMenuItem(
                value: e,
                child: Text(e.name.toUpperCase().replaceAll('WAIVER', ' WAIVER')),
              )).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildValueInput() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 2,
              child: _buildTextField('Amount', _valueController, Icons.payments),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<ScholarshipValueType>(
                    value: _valueType,
                    dropdownColor: const Color(0xFF1E293B),
                    style: const TextStyle(color: Colors.white, fontSize: 13),
                    items: ScholarshipValueType.values.map((v) => DropdownMenuItem(
                      value: v,
                      child: Text(v == ScholarshipValueType.amount ? 'FIXED' : '% AGE'),
                    )).toList(),
                    onChanged: (v) => setState(() => _valueType = v!),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        if (_valueType == ScholarshipValueType.amount)
          _buildDropdown<ScholarshipFrequency>(
            'Frequency', 
            ScholarshipFrequency.values, 
            _frequency, 
            (v) => setState(() => _frequency = v!)
          )
        else
          _buildDropdown<ScholarshipBasis>(
            'Calculate Based On', 
            ScholarshipBasis.values, 
            _basis, 
            (v) => setState(() => _basis = v!)
          ),
      ],
    );
  }

  Widget _buildYearSelection() {
    final college = ref.watch(activeCollegeProvider);
    final duration = college?.durationYears ?? 4;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Applied Semesters (Grouped by Year)', style: TextStyle(color: Colors.white, fontSize: 14)),
        const SizedBox(height: 12),
        ...List.generate(duration, (yearIndex) {
          final year = yearIndex + 1;
          final isExpanded = _expandedYears.contains(year);
          final s1 = (year - 1) * 2 + 1;
          final s2 = (year - 1) * 2 + 2;
          
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    if (isExpanded) _expandedYears.remove(year);
                    else _expandedYears.add(year);
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.03),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: isExpanded ? Colors.greenAccent.withOpacity(0.3) : Colors.white.withOpacity(0.05)),
                  ),
                  child: Row(
                    children: [
                      Icon(isExpanded ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_right, 
                           color: isExpanded ? Colors.greenAccent : Colors.white38, size: 18),
                      const SizedBox(width: 8),
                      Text('Year $year', style: TextStyle(
                        color: isExpanded ? Colors.greenAccent : Colors.white70,
                        fontWeight: isExpanded ? FontWeight.bold : FontWeight.normal
                      )),
                      const Spacer(),
                      if (_selectedSemesters.contains(s1) || _selectedSemesters.contains(s2))
                        const Icon(Icons.check_circle, color: Colors.greenAccent, size: 14),
                    ],
                  ),
                ),
              ),
              if (isExpanded)
                Padding(
                  padding: const EdgeInsets.only(left: 24, bottom: 16),
                  child: Wrap(
                    spacing: 8,
                    children: [s1, s2].map((sem) {
                      final isSelected = _selectedSemesters.contains(sem);
                      return FilterChip(
                        label: Text('Sem $sem'),
                        selected: isSelected,
                        selectedColor: Colors.blueAccent.withOpacity(0.2),
                        checkmarkColor: Colors.blueAccent,
                        labelStyle: TextStyle(color: isSelected ? Colors.blueAccent : Colors.white60, fontSize: 13),
                        backgroundColor: Colors.white.withOpacity(0.05),
                        onSelected: (v) {
                          setState(() {
                            if (v) _selectedSemesters.add(sem);
                            else _selectedSemesters.remove(sem);
                          });
                        },
                      );
                    }).toList(),
                  ),
                ),
            ],
          );
        }),
      ],
    );
  }

  Widget _buildComponentSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Eligible Fee Components', style: TextStyle(color: Colors.white, fontSize: 14)),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 4,
          children: FeeComponent.values.map((c) {
            final isSelected = _selectedComponents.contains(c);
            return FilterChip(
              label: Text(c.name.toUpperCase()),
              padding: const EdgeInsets.symmetric(horizontal: 4),
              selected: isSelected,
              selectedColor: Colors.blueAccent.withOpacity(0.2),
              checkmarkColor: Colors.blueAccent,
              labelStyle: TextStyle(color: isSelected ? Colors.blueAccent : Colors.white60, fontSize: 11),
              backgroundColor: Colors.white.withOpacity(0.05),
              onSelected: (v) {
                setState(() {
                  if (v) _selectedComponents.add(c);
                  else _selectedComponents.remove(c);
                });
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildConditionToggle(String label, bool value, ValueChanged<bool> onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 14)),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: Colors.greenAccent,
        ),
      ],
    );
  }

  Widget _buildCgpaInput() {
    return Row(
      children: [
        const Expanded(
          child: Text('Minimum CGPA Required', style: TextStyle(color: Colors.white, fontSize: 14)),
        ),
        SizedBox(
          width: 80,
          child: TextField(
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: '0.0',
              hintStyle: TextStyle(color: Colors.white.withOpacity(0.2)),
              filled: true,
              fillColor: Colors.white.withOpacity(0.05),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              contentPadding: const EdgeInsets.symmetric(vertical: 8),
            ),
            onChanged: (v) => _minCgpa = double.tryParse(v),
          ),
        ),
      ],
    );
  }
}
