import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/exports.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final bool isAdmin = true;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _organizationController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _organizationFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _organizationController.dispose();
    _confirmPasswordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _organizationFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  void _handleFocus(FocusNode focusNode) {
    setState(() => focusNode.requestFocus());
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

  Widget _buildLoginText() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: AppTheme.simpleText,
        children: [
          const TextSpan(text: "Already have an account? "),
          TextSpan(
            text: "Login now",
            style: const TextStyle(
              color: AppColours.primaryBlue,
              decoration: TextDecoration.underline,
              fontWeight: FontWeight.w600,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                // TODO - Handle Login tap
              },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColours.white,
      appBar: isAdmin
          ? const GlintEventAuthAppbar()
          : AppBar(backgroundColor: AppColours.white),
      body: AuthStackedIllustrationScreen(
        isAdmin: isAdmin,
        body: Column(
          children: [
            if (!isAdmin)
              Center(
                child: SvgPicture.asset(
                    'lib/assets/images/auth/glint_create_account.svg'),
              ),
            const Gap(40.0),
            if (isAdmin)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 40.0),
                  child: Column(
                    children: [
                      const Spacer(),
                      Text(
                        'Create Account',
                        style: AppTheme.headingThree.copyWith(
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                      const Gap(32.0),
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
                        hintText: 'Organization (ex: Hotel Vistara)',
                      ),
                      const Gap(20.0),
                      _buildTextField(
                        controller: _passwordController,
                        type: IconTextFieldType.password,
                        focusNode: _passwordFocusNode,
                        hintText: 'Create Password',
                      ),
                      const Spacer(
                        flex: 5,
                      ),
                      GlintAuthActionButton(
                        label: 'Create Account',
                        onPressed: () =>
                            debugPrint('Create account button pressed'),
                      ),
                      const Gap(16.0),
                      _buildLoginText(),
                    ],
                  ),
                ),
              ),
            if (!isAdmin) ...[
              _buildTextField(
                controller: _emailController,
                type: IconTextFieldType.email,
                focusNode: _emailFocusNode,
                hintText: 'Enter Email',
              ),
              const Gap(20.0),
              _buildTextField(
                controller: _passwordController,
                type: IconTextFieldType.password,
                focusNode: _passwordFocusNode,
                hintText: 'Create Password',
              ),
              const Gap(20.0),
              _buildTextField(
                controller: _confirmPasswordController,
                type: IconTextFieldType.password,
                focusNode: _confirmPasswordFocusNode,
                hintText: 'Confirm Password',
              ),
              const Gap(60.0),
              GlintAuthActionButton(
                label: 'Sign up',
                onPressed: () => debugPrint('Sign up button pressed'),
              ),
              const Gap(16.0),
              _buildLoginText(),
            ],
          ],
        ),
      ),
    );
  }
}
