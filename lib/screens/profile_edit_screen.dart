import 'package:flutter/material.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController(text: 'محمد الحسن');
  final _email = TextEditingController(text: 'user@example.com');
  final _phone = TextEditingController(text: '+966500000000');

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _phone.dispose();
    super.dispose();
  }

  void _save() {
    if (_formKey.currentState?.validate() ?? false) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('تم حفظ المعلومات')));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('تعديل الملف الشخصي')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CircleAvatar(radius: 44, child: Icon(Icons.person, size: 48)),
              const SizedBox(height: 12),
              TextFormField(
                controller: _name,
                decoration: const InputDecoration(labelText: 'الاسم'),
                validator: (v) =>
                    (v == null || v.isEmpty) ? 'أدخل الاسم' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _email,
                decoration:
                    const InputDecoration(labelText: 'البريد الإلكتروني'),
                validator: (v) =>
                    (v == null || v.isEmpty) ? 'أدخل البريد' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _phone,
                decoration: const InputDecoration(labelText: 'رقم الجوال'),
                validator: (v) =>
                    (v == null || v.isEmpty) ? 'أدخل رقم الجوال' : null,
              ),
              const Spacer(),
              ElevatedButton(onPressed: _save, child: const Text('حفظ'))
            ],
          ),
        ),
      ),
    );
  }
}
