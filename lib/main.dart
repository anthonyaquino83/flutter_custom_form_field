import 'package:flutter/material.dart';
// p1 - colocar o checkbox dentro de um formfield
// p2 - renomear o field para formFieldState
// p3 - atualizar o valor do formFieldState com o novo valor
// p4 - criar a validação do checkbox
// p5 - atribuir um valor inicial para o formfield
// p6 - colocar o checkbox dentro de uma coluna e acrescentar o texto de erro
// p7 - alterar o estilo da mensagem de erro

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Custom FormField'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  bool _checkboxValue = false;

  void _toggleCheckbox() {
    setState(() {
      _checkboxValue = !_checkboxValue;
    });
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      print('formulário válido');
    } else {
      print('formulário inválido');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Preencha o formulário e aceite os termos de responsabilidade.',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Nome'),
                  validator: (value) =>
                      value!.isEmpty ? 'Campo obrigatório' : null,
                  onFieldSubmitted: (value) {
                    _submit();
                  },
                ),
                FormField(
                  initialValue: false,
                  validator: (value) => value == false
                      ? 'Aceite o termo de responsabilidade'
                      : null,
                  builder: (formFieldState) {
                    return Column(
                      children: [
                        CheckboxListTile(
                          title: const Text(
                            'Eu aceito os termos de responsabilidade',
                          ),
                          value: _checkboxValue,
                          onChanged: (value) {
                            formFieldState.didChange(value);
                            _toggleCheckbox();
                          },
                        ),
                        if (!formFieldState.isValid)
                          Text(
                            formFieldState.errorText ?? '',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.red.shade800,
                            ),
                          )
                      ],
                    );
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    _submit();
                  },
                  child: const Text('Salvar'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
