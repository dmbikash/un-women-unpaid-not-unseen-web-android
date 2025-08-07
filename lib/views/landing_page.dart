import 'package:flutter/material.dart';
import '../design/themes/colors.dart';
import '../design/text/textStyles.dart';
import '../controller/routes.dart';
import '../providers/question_provider_principal.dart';
import '../services/languages.dart';
import 'package:provider/provider.dart';
import '../services/language_service.dart';
import 'package:flutter/services.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

late QuestionProviderPrincipal questionProviderPrincipal;

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    questionProviderPrincipal = Provider.of<QuestionProviderPrincipal>(context,listen: false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final langService = Provider.of<LanguageServiceMobile>(context);

    return WillPopScope(
      // When back button is pressed, exit the app directly
      onWillPop: () async {
        // Force close the app when back button is pressed
        SystemNavigator.pop();
        return false; // Return false to prevent default back navigation
      },
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: screenHeight * 0.05),

                // Logo - no animation
                Image.asset(
                  'assets/logo/unpaid_not_unseen.png',
                  height: screenHeight * 0.15,
                ),

                SizedBox(height: screenHeight * 0.06),

                // Title - no animation
                Text(
                  i18n[langService
                          .currentLanguage]?['landing_page']?['title'] ??
                      "The Value of Unpaid Work",
                  style: ThemeTextStyles.heading.copyWith(
                    fontSize: screenWidth * 0.06,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: screenHeight * 0.04),

                // Description - no animation
                Text(
                  i18n[langService
                          .currentLanguage]?['landing_page']?['description'] ??
                      "Every day, millions of women around the world perform vital work that sustains families and communities, yet remains unseen and unpaid. From preparing meals and nurturing children to caring for elderly relatives, these essential contributions are the invisible foundation of our society.",
                  style: ThemeTextStyles.body.copyWith(
                    fontSize: screenWidth * 0.04,
                    height: 1.6,
                    color: Colors.white.withOpacity(0.9),
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: screenHeight * 0.04),

                // Message - no animation
                Text(
                  i18n[langService
                          .currentLanguage]?['landing_page']?['message'] ??
                      "It's time to recognize the immense value of this labor, and ensure that the hands that nurture our world are truly valued.",
                  style: ThemeTextStyles.body.copyWith(
                    fontSize: screenWidth * 0.04,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.italic,
                    height: 1.6,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: screenHeight * 0.06),

                // Start button - no animation

                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        //controller: provider.nameController,
                        controller: questionProviderPrincipal.userName,
                        decoration: InputDecoration(
                          hintText: 'Enter your name',
                          filled: true,
                          fillColor: Colors.white,
                          label: Text("Name"),
                          labelStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w500,backgroundColor: Colors.white),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    Expanded(child: _buildDropdown("Gender", null,[ "Woman","Man"], (gender){
                      questionProviderPrincipal.selectedGender = gender;
                    })),
                  ],
                ),
                const SizedBox(height: 24),

                SizedBox(
                  width: screenWidth * 0.92,
                  height: screenHeight * 0.07,
                  child: ElevatedButton(
                    onPressed: () {

                      if(questionProviderPrincipal.selectedGender==null || questionProviderPrincipal.userName==""){
                        if(questionProviderPrincipal.userName==""){
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Please Enter Name '),
                              duration: Duration(seconds: 2), // optional
                            ),
                          );
                        }
                        if(questionProviderPrincipal.selectedGender==null ){
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Please Select Gender '),
                              duration: Duration(seconds: 2), // optional
                            ),
                          );
                        }


                      }else{
                        questionProviderPrincipal.initStart();
                        Navigator.pushNamed(context, WebRoutes.questions);

                      }

                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: AppColors.primary,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      i18n[langService
                              .currentLanguage]?['landing_page']?['start_button'] ??
                          "START",
                      style: ThemeTextStyles.button.copyWith(
                        fontSize: screenWidth * 0.04,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: screenHeight * 0.02),

                // Language switch button - no animation
                SizedBox(
                  width: screenWidth * 0.92,
                  height: screenHeight * 0.07,
                  child: ElevatedButton(
                    onPressed: () {
                      langService.toggleLanguage();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary.withOpacity(0.2),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(color: Colors.white),
                      ),
                    ),
                    child: Text(
                      langService.isEnglish()
                          ? 'বাংলা ভাষায় দেখুন' // Show in Bengali
                          : 'View in English', // Show in English
                      style: ThemeTextStyles.button.copyWith(
                        fontSize: screenWidth * 0.04,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: screenHeight * 0.05),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown(
      String label,
      String? value,
      List<String> options,
      void Function(String?) onChanged,
      ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownButtonFormField<String>(
        value: value,
        isExpanded: true,
        items: options
            .map((option) => DropdownMenuItem(
          value: option,
          child: Text(option, style: TextStyle(color: Colors.black)),
        ))
            .toList(),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w500,backgroundColor: Colors.white,),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.blue.withOpacity(0.4)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.white, width: 1.5),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.red.shade700, width: 1.5),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.red.shade700, width: 1.5),
          ),
        ),
        onChanged: onChanged,
        validator: (value) => value == null || value.isEmpty
            ? 'Please select $label'
            : null,
      ),
    );
  }
}
