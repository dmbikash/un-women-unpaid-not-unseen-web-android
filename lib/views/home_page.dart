import 'package:flutter/material.dart';
import '../design/text/textStyles.dart';
import '../services/languages.dart';
import '../widgets/page_scaffold.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final appTitle = i18n[language]?['unpaid_work_calculator']?['app_title'] ??
        'Unpaid Work Calculator';
    final introText = i18n[language]?['unpaid_work_calculator']?['intro_text'] ??
        'Calculate the value of your unpaid work';

    return PageScaffold(
      title: appTitle,
      showBackButton: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(MediaQuery
              .of(context)
              .size
              .width * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                introText,
                style: ThemeTextStyles.normalTitle,
              ),
              SizedBox(height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.02),
              Expanded(
                child: ListView(
                  children: [
                    SizedBox(height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.02),
                    SizedBox(height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.02),
                    SizedBox(height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.02),
                    SizedBox(height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.02),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
