import 'package:flutter/material.dart';
import '../design/themes/colors.dart';
import 'custom_header.dart';

class PageScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final bool showBackButton;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? bottomNavigationBar;
  final bool useLogoList;
  final bool resizeToAvoidBottomInset;
  final PreferredSizeWidget? appBar;
  final bool ensureScrollable;

  const PageScaffold({
    Key? key,
    required this.title,
    required this.body,
    this.showBackButton = true,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.bottomNavigationBar,
    this.useLogoList = true,
    this.resizeToAvoidBottomInset = true,
    this.appBar,
    this.ensureScrollable = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: appBar,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      body: Column(
        children: [
          // Custom header
          CustomHeader(
            title: title,
            backButton: showBackButton,
            useLogoList: useLogoList,
          ),

          // Main content - Use Expanded to fill the remaining space
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(MediaQuery
                      .of(context)
                      .size
                      .width * 0.05),
                  topRight: Radius.circular(MediaQuery
                      .of(context)
                      .size
                      .width * 0.05),
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(MediaQuery
                      .of(context)
                      .size
                      .width * 0.05),
                  topRight: Radius.circular(MediaQuery
                      .of(context)
                      .size
                      .width * 0.05),
                ),
                child: ensureScrollable
                    ? _buildScrollableContent(context, body)
                    : body,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      bottomNavigationBar: bottomNavigationBar,
    );
  }

  // Helper method to ensure content is scrollable
  Widget _buildScrollableContent(BuildContext context, Widget content) {
    // Check if content is already a scrollable widget
    if (content is ScrollView) {
      return content;
    }

    // If it's already wrapped in a SingleChildScrollView, return as is
    if (content is SingleChildScrollView) {
      return content;
    }

    // Otherwise, wrap in a SingleChildScrollView to ensure scrollability
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      // Ensure the content can fill available height but doesn't cause flex issues
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight:
          MediaQuery.of(context).size.height *
              0.7, // Make minimum height responsive to device
          maxWidth: MediaQuery.of(context).size.width,
        ),
        child: content, // Direct content without IntrinsicHeight
      ),
    );
  }
}
