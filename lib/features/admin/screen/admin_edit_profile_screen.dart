import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';

class AdminEditProfileScreen extends StatefulWidget {
  const AdminEditProfileScreen({super.key});

  @override
  State<AdminEditProfileScreen> createState() => _AdminEditProfileScreenState();
}

class _AdminEditProfileScreenState extends State<AdminEditProfileScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _organizationController = TextEditingController();
  final _contactController = TextEditingController();

  final _nameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _organizationFocusNode = FocusNode();
  final _contactFocusNode = FocusNode();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _organizationController.dispose();
    _contactController.dispose();
    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _organizationFocusNode.dispose();
    _contactFocusNode.dispose();
    super.dispose();
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required IconTextFieldType type,
    required FocusNode focusNode,
    required String hintText,
  }) {
    return AuthIconTextField(
      controller: controller,
      type: type,
      focusNode: focusNode,
      hintText: hintText,
      isTextFieldFocused: focusNode.hasFocus,
      onTap: () => _handleFocus(focusNode),
    );
  }

  void _handleFocus(FocusNode focusNode) {
    setState(() {
      focusNode.requestFocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColours.white,
      appBar: AppBar(
        titleSpacing: 32.0,
        scrolledUnderElevation: 0,
        title: const Text(
          'Edit Profile',
          style: AppTheme.heavyBodyText,
        ),
        centerTitle: false,
        backgroundColor: AppColours.white,
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Container(
              color: AppColours.gray60,
              height: 1.0,
            )),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 28.0,
          ),
          child: Column(
            children: [
              // top spacing
              const Gap(32.0),
              _buildTextField(
                controller: _nameController,
                type: IconTextFieldType.user,
                focusNode: _nameFocusNode,
                hintText: 'Enter Your Name',
              ),
              const Gap(20.0),
              _buildTextField(
                controller: _emailController,
                type: IconTextFieldType.email,
                focusNode: _emailFocusNode,
                hintText: 'Enter Email',
              ),
              const Gap(20.0),
              _buildTextField(
                controller: _organizationController,
                type: IconTextFieldType.organization,
                focusNode: _organizationFocusNode,
                hintText: 'Organization (ex: Hotel Vatsa)',
              ),
              const Gap(20.0),
              _buildTextField(
                controller: _contactController,
                type: IconTextFieldType.contact,
                focusNode: _contactFocusNode,
                hintText: 'Contact Number',
              ),
              const Gap(32.0),
              SizedBox(
                height: 52.0,
                width: double.infinity,
                child: GlintAuthActionButton(
                  label: 'Save',
                  onPressed: () {
                    // todo - handle admin edit profile functionality
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
