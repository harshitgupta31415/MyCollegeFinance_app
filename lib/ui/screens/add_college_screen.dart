import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../domain/models/college_models.dart';
import '../../domain/providers/finance_providers.dart';

class AddCollegeScreen extends ConsumerStatefulWidget {
  const AddCollegeScreen({super.key});

  @override
  ConsumerState<AddCollegeScreen> createState() => _AddCollegeScreenState();
}

class _AddCollegeScreenState extends ConsumerState<AddCollegeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _regionController = TextEditingController(); // Optional
  final _customCourseController = TextEditingController();
  final _avgPackageController = TextEditingController();
  final _notesController = TextEditingController();
  
  String? _selectedState;
  String? _selectedCourse;
  bool _isOtherCourseSelected = false;
  int _durationYears = 4;
  bool _isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      final activeCollege = ref.read(activeCollegeProvider);
      if (activeCollege != null) {
        _nameController.text = activeCollege.collegeName;
        _avgPackageController.text = activeCollege.averagePackage?.toString() ?? "";
        _durationYears = activeCollege.durationYears;
        _notesController.text = activeCollege.notes ?? "";
        
        // Location logic
        final parts = activeCollege.location.split(', ');
        if (parts.length > 1) {
          _regionController.text = parts[0];
          _selectedState = parts[1];
        } else {
          _selectedState = activeCollege.location;
        }

        // Course logic
        if (_courseBranches.contains(activeCollege.courseName)) {
          _selectedCourse = activeCollege.courseName;
        } else {
          _selectedCourse = 'Other';
          _isOtherCourseSelected = true;
          _customCourseController.text = activeCollege.courseName;
        }
      }
      _isInitialized = true;
    }
  }

  void _fillMockData() {
    setState(() {
      _nameController.text = "Amity University";
      _selectedState = "Uttar Pradesh";
      _regionController.text = "Noida";
      _selectedCourse = "B.Tech Computer Science (CSE)";
      _durationYears = 4;
      _avgPackageController.text = "1200000";
    });
  }

  static const List<String> _indianStates = [
    // Top Priority (Most colleges)
    'Maharashtra', 'Karnataka', 'Tamil Nadu', 'Telangana', 'Uttar Pradesh', 'Delhi', 'Gujarat', 'Rajasthan',
    '---', // Divider
    'Andhra Pradesh', 'Arunachal Pradesh', 'Assam', 'Bihar', 'Chhattisgarh',
    'Goa', 'Haryana', 'Himachal Pradesh', 'Jharkhand',
    'Kerala', 'Madhya Pradesh', 'Manipur', 'Meghalaya', 'Mizoram',
    'Nagaland', 'Odisha', 'Punjab', 'Sikkim',
    'Tripura', 'Uttarakhand', 'West Bengal',
    'Andaman and Nicobar Islands', 'Chandigarh', 'Dadra and Nagar Haveli and Daman and Diu',
    'Jammu and Kashmir', 'Ladakh', 'Lakshadweep', 'Puducherry'
  ];

  static const List<String> _courseBranches = [
    // Top Priority
    'B.Tech Computer Science (CSE)',
    'B.Tech IT',
    'B.Tech AI & Machine Learning',
    'B.Tech Data Science',
    '---', // Divider
    'B.Tech Electronics & Comm. (ECE)',
    'B.Tech Mechanical Engineering (ME)',
    'B.Tech Civil Engineering (CE)',
    'B.Tech Electrical Engineering (EE)',
    'B.Tech Chemical Engineering',
    'MBA',
    'BBA',
    'MBBS',
    'Other'
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _regionController.dispose();
    _customCourseController.dispose();
    _avgPackageController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New College'),
        actions: [
          if (kDebugMode)
            TextButton.icon(
              onPressed: _fillMockData,
              icon: const Icon(Icons.auto_fix_high, color: Colors.green),
              label: const Text('Fast Fill', style: TextStyle(color: Colors.green)),
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'College Details',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
              ),
              const SizedBox(height: 24),
              _buildTextField('College Name', _nameController, Icons.school),
              const SizedBox(height: 16),
              _buildDropdown('Location (State)', _indianStates, _selectedState, (val) {
                if (val != '---') setState(() => _selectedState = val);
              }, Icons.location_on),
              const SizedBox(height: 16),
              _buildTextField('Region/City (Optional)', _regionController, Icons.map, required: false),
              const SizedBox(height: 16),
              _buildDropdown('Course Name', _courseBranches, _selectedCourse, (val) {
                if (val != '---') {
                  setState(() {
                    _selectedCourse = val;
                    _isOtherCourseSelected = val == 'Other';
                  });
                }
              }, Icons.book),
              if (_isOtherCourseSelected) ...[
                const SizedBox(height: 16),
                _buildTextField('Custom Course', _customCourseController, Icons.edit_note),
              ],
              const SizedBox(height: 20),
              _buildTextField('Avg Package (LPA/Year)', _avgPackageController, Icons.payments, required: false, isNumber: true),
              const SizedBox(height: 20),
              _buildTextField('Notes / Points (Optional)', _notesController, Icons.note_add, required: false),
              const SizedBox(height: 28),
              const Text('Course Duration', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: [
                  for (int i = 1; i <= 6; i++)
                    ChoiceChip(
                      label: Text('$i Years'),
                      selected: _durationYears == i,
                      onSelected: (selected) {
                        if (selected) setState(() => _durationYears = i);
                      },
                    ),
                ],
              ),
              const SizedBox(height: 48),
              ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Continue to Fee Input', style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, IconData icon, {bool required = true, bool isNumber = false}) {
    return TextFormField(
      controller: controller,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.green),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Colors.white.withOpacity(0.05),
      ),
      validator: required ? (value) => value == null || value.isEmpty ? 'Required' : null : null,
    );
  }

  Widget _buildDropdown(String label, List<String> items, String? value, ValueChanged<String?> onChanged, IconData icon) {
    return DropdownButtonFormField<String>(
      isExpanded: true,
      value: value,
      items: items.map((item) => DropdownMenuItem(
        value: item, 
        enabled: item != '---',
        child: item == '---' 
          ? const Divider(thickness: 1, color: Colors.grey) 
          : Text(item, overflow: TextOverflow.ellipsis)
      )).toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.green),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Colors.white.withOpacity(0.05),
      ),
      validator: (value) => value == null ? 'Required' : null,
      menuMaxHeight: 350,
    );
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final finalCourseName = _isOtherCourseSelected 
          ? _customCourseController.text 
          : _selectedCourse!;

      final fullLocation = _regionController.text.isNotEmpty 
          ? '${_regionController.text}, $_selectedState' 
          : _selectedState!;

      final activeCollege = ref.read(activeCollegeProvider);
      final college = (activeCollege ?? CollegeEntity(
        collegeId: DateTime.now().millisecondsSinceEpoch.toString(),
        collegeName: _nameController.text,
        location: fullLocation,
        courseName: finalCourseName,
        durationYears: _durationYears,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        collectionId: 'priority',
      )).copyWith(
        collegeName: _nameController.text,
        location: fullLocation,
        courseName: finalCourseName,
        durationYears: _durationYears,
        averagePackage: double.tryParse(_avgPackageController.text),
        notes: _notesController.text,
        updatedAt: DateTime.now(),
      );
      
      ref.read(activeCollegeProvider.notifier).state = college;
      
      // Reset other providers for fresh start
      ref.invalidate(collegeFeesProvider);
      ref.invalidate(collegeScholarshipsProvider);
      ref.invalidate(repaymentConfigProvider);
      ref.invalidate(moratoriumConfigProvider);
      ref.invalidate(moratoriumTimelineProvider);
      ref.invalidate(moratoriumImpactProvider);
      ref.invalidate(repaymentScheduleProvider);
      
      // Navigate to Fee Input
      context.push('/fee-input');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('College Saved! Next: Configure Fees.')),
      );
    }
  }
}
