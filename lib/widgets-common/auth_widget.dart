import 'package:flutter/material.dart';
import 'package:tic_tac_toe/services/auth/auth_service.dart';
import 'package:tic_tac_toe/widgets-common/games_menu_widget.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Authentication'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text('Register'),
              onPressed: () async {
                // Await result from RegisterScreen
                final result = await Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const RegisterScreen()),
                );
                if (result == true) {
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context) => const MenuScreen())
                  );
                }
              },            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Login'),
              onPressed: () async {
                // Await result from LoginScreen
                final result = await Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
                if (result == true) {
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context) => const MenuScreen())
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  
  Future<void> _register() async {
    setState(() {
      _isLoading = true;
    });
    
    final authService = AuthService();
    Map<String, dynamic> userData = {
      'user': _userController.text,
      'password': _passwordController.text,
    };
    
    try {
      final response = await authService.createUser(userData);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registration Successful: $response')),
      );
      Navigator.of(context).pop();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registration Failed: $e')),
      );
    }
    
    setState(() {
      _isLoading = false;
    });
  }
  
  @override
  void dispose() {
    _userController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _userController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            _isLoading
              ? const CircularProgressIndicator()
              : ElevatedButton(
                  onPressed: _register,
                  child: const Text('Submit'),
                ),
          ],
        ),
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  
  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });
    
    final authService = AuthService();
    Map<String, dynamic> credentials = {
      'user': _userController.text,
      'password': _passwordController.text,
    };
    
    try {
      await authService.login(credentials);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Welcome ${credentials['user']}')),
      );
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const MenuScreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login Failed: $e')),
      );
    }
    
    setState(() {
      _isLoading = false;
    });
  }
  
  @override
  void dispose() {
    _userController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _userController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            _isLoading
              ? const CircularProgressIndicator()
              : ElevatedButton(
                  onPressed: _login,
                  child: const Text('Submit'),
                ),
          ],
        ),
      ),
    );
  }
}