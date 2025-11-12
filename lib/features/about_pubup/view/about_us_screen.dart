// screens/AboutUsScreen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:new_pubup_partner/features/about_pubup/bloc/about_us_bloc.dart';
import 'package:new_pubup_partner/features/about_pubup/event/about_us_event.dart';
import 'package:new_pubup_partner/features/about_pubup/state/about_us_state.dart';

import '../../../config/theme.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  late AboutUsBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = AboutUsBloc();
    bloc.add(GetAboutUsEvent());
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
        backgroundColor: AppColors.themeColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: BlocProvider.value(
        value: bloc,
        child: BlocBuilder<AboutUsBloc, AboutUsState>(
          builder: (context, state) {
            if (state is AboutUsLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is AboutUsSuccessState) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header with Title
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.themeColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.themeColor.withOpacity(0.2)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state.aboutUsModel.title,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Updated: ${state.aboutUsModel.createdAt}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Description Section
                    const Text(
                      'Description',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: Html(
                        data: state.aboutUsModel.description,
                        style: {
                          'body': Style(
                            fontSize: FontSize(16),
                            color: Colors.black87,
                            lineHeight: LineHeight.number(1.5),
                          ),
                          'h2': Style(
                            fontSize: FontSize(20),
                            fontWeight: FontWeight.bold,
                            margin: Margins(
                              top: Margin(0.5, Unit.em),
                              bottom: Margin(0.5, Unit.em),
                            ),
                          ),
                          'p': Style(
                            margin: Margins(
                              top: Margin(0.25, Unit.em),
                              bottom: Margin(0.25, Unit.em),
                            ),
                          ),
                        },
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is AboutUsErrorState) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Colors.red[300],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Failed to load About Us',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.red[700],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      state.errorMsg,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: () {
                        bloc.add(GetAboutUsEvent());
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text('Retry'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.themeColor,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              );
            }
            return const Center(
              child: Text('Press to load About Us'),
            );
          },
        ),
      ),
    );
  }
}