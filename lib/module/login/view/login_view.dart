import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hyper_ui/shared/util/validator/validator.dart';
import 'package:hyper_ui/shared/widget/form/button/button.dart';
import 'package:hyper_ui/shared/widget/form/textfield/text_field.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../controller/login_controller.dart';
import '../state/login_state.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  LoginController controller = LoginController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    controller.initState();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => controller,
      child: BlocListener<LoginController, LoginState>(
        listener: (context, state) {},
        child: BlocBuilder<LoginController, LoginState>(
          builder: (context, state) {
            final bloc = context.read<LoginController>();
            return buildView(context, bloc, state);
          },
        ),
      ),
    );
  }

  Widget buildView(
    BuildContext context,
    LoginController controller,
    LoginState state,
  ) {
    return Scaffold(
      backgroundColor: Color(0xff1c1c1c1c),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        transform: Matrix4.translationValues(0.0, 10, 0),
                        child: Icon(
                          MdiIcons.cashRegister,
                          size: 42.0,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Pos",
                        style: GoogleFonts.blackOpsOne(
                          fontSize: 56.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Container(
                        transform: Matrix4.translationValues(0.0, -10, 0),
                        child: Text(
                          "Cafeku",
                          style: GoogleFonts.blackOpsOne(
                            fontSize: 16.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      //----
                      QTextField(
                        label: "Email",
                        validator: Validator.email,
                        suffixIcon: Icons.email,
                        value: null,
                        onChanged: (value) {
                          controller.state.email = value;
                        },
                      ),
                      QTextField(
                        label: "Password",
                        obscure: true,
                        validator: Validator.required,
                        suffixIcon: Icons.password,
                        value: null,
                        onChanged: (value) {
                          controller.state.password = value;
                        },
                      ),
                      QButton(
                        label: "Login",
                        onPressed: () {
                          bool isValid = formKey.currentState!.validate();
                          if (!isValid) {
                            return;
                          }

                          controller.login();
                        },
                      ),
                    ],
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
