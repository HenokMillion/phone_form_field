import 'package:flutter/material.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:phone_form_field/src/custom_iso_code.dart';

/// Example showing how to use the CustomIsoCode with PhoneFormField
class CustomIsoCodeExample extends StatelessWidget {
  const CustomIsoCodeExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Using CustomIsoCode'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Using CustomIsoCode to exclude Taiwan and other countries:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Create a PhoneFormField with a custom CountrySelectorNavigator
            PhoneFormField(
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
              ),
              countrySelectorNavigator:
                  CountrySelectorNavigator.modalBottomSheet(
                // This will use the filtered countries list automatically
                searchAutofocus: true,
              ),
              // Use a controller if you need to access the CustomIsoCode
              controller: PhoneController(
                initialValue: PhoneNumber(
                  isoCode: IsoCode.US,
                  nsn: '',
                ),
              ),
            ),

            const SizedBox(height: 32),
            const Text(
              'Using CustomIsoCode directly:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Example of using CustomIsoCode in a dropdown
            DropdownButton<CustomIsoCode>(
              value: CustomIsoCode.US,
              onChanged: (CustomIsoCode? newValue) {
                if (newValue != null) {
                  // Use the custom code
                  print('Selected country: ${newValue.name}');

                  // Convert to original IsoCode if needed
                  final originalCode = newValue.toOriginal();
                  print('Original IsoCode: ${originalCode.name}');
                }
              },
              items: CustomIsoCode.values
                  .map<DropdownMenuItem<CustomIsoCode>>((CustomIsoCode value) {
                return DropdownMenuItem<CustomIsoCode>(
                  value: value,
                  child: Text(value.name),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
