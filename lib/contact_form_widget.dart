import 'package:flutter/material.dart';

class ContactFormWidget extends StatefulWidget {
  @override
  _ContactFormWidgetState createState() => _ContactFormWidgetState();
}

class _ContactFormWidgetState extends State<ContactFormWidget> {
  final _formKey = GlobalKey<FormState>();
  String? _name;
  String? _email;
  String? _message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Text(
              'השאר את פרטיך',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(labelText: 'השם שלך'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'אנא הכנס את שמך';
                }
                return null;
              },
              onSaved: (value) => _name = value,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'האימייל שלך'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'אנא הכנס את האימייל שלך';
                }
                if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                  return 'אנא הכנס כתובת אימייל תקינה';
                }
                return null;
              },
              onSaved: (value) => _email = value,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'ההודעה שלך'),
              maxLines: 3,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'אנא הכנס את הודעתך';
                }
                return null;
              },
              onSaved: (value) => _message = value,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitForm,
              child: Text('שלח'),
            ),
          ],
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Here you would typically send this data to your server
      print('Form submitted: $_name, $_email, $_message');
      
      // Show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('תודה על הודעתך! נחזור אליך בהקדם.')),
      );
      
      // Clear the form
      _formKey.currentState!.reset();
    }
  }
}