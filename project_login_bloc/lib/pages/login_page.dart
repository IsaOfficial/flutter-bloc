import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth_bloc.dart'; // Pastikan jalur import sesuai dengan struktur project Anda
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isVisible = true;

  void toggleVisible() {
    setState(() {
      isVisible = !isVisible;
    });
  }

  void _login() {
    final email = _emailController.text;
    final password = _passwordController.text;

    context
        .read<AuthBloc>()
        .add(AuthLoginRequested(email: email, password: password));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: "Email",
                hintText: "Enter your email",
                hintStyle: TextStyle(color: Color.fromARGB(255, 175, 175, 175)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Colors.blue),
                ),
                suffixIcon: Icon(Icons.email),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
                controller: _passwordController,
                obscureText: isVisible,
                decoration: InputDecoration(
                  labelText: "Password",
                  hintText: "Enter your password",
                  hintStyle: const TextStyle(
                      color: Color.fromARGB(255, 175, 175, 175)),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  suffixIcon: IconButton(
                      onPressed: toggleVisible,
                      icon: isVisible
                          ? const Icon(Icons.visibility)
                          : const Icon(Icons.visibility_off)),
                )),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: _login, child: const Text("Login")),
            const SizedBox(height: 10),
            BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthSuccess) {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => HomePage(uid: state.uid),
                  ));
                }
              },
              child: BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state is AuthInitial) {
                    return Container();
                  } else if (state is AuthFailure) {
                    return Text(state.error,
                        style: const TextStyle(color: Colors.red));
                  }
                  return Container();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
