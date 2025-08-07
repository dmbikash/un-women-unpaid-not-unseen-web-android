import 'package:flutter/material.dart';
import '../design/themes/colors.dart';
import '../design/text/textStyles.dart';
import '../services/languages.dart';
import '../controller/routes.dart';
import '../widgets/page_scaffold.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final _formKey = GlobalKey<FormState>();
  double _inputValue = 0;
  final String _inputLabel = "";

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      title: i18n[language]?['unpaid_work_calculator']?['cards']?['calculate']?['title'] ??
              'Calculate',
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(MediaQuery
              .of(context)
              .size
              .width * 0.04),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  color: AppColors.container,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(MediaQuery
                        .of(context)
                        .size
                        .width * 0.04),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Enter Value",
                          style: ThemeTextStyles.heading,
                        ),
                        SizedBox(height: MediaQuery
                            .of(context)
                            .size
                            .height * 0.02),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "Value",
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: AppColors.white,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a value';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            _inputValue = double.tryParse(value) ?? 0;
                          },
                        ),
                        SizedBox(height: MediaQuery
                            .of(context)
                            .size
                            .height * 0.02),
                      ],
                    ),
                  ),
                ),

                const Spacer(),

                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.pushNamed(context, WebRoutes.result);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: EdgeInsets.symmetric(vertical: MediaQuery
                        .of(context)
                        .size
                        .height * 0.02),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    i18n[language]?['unpaid_work_calculator']?['buttons']?['calculate'] ??
                        'Calculate',
                    style: ThemeTextStyles.button,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
