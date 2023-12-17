import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  
  String dropDownValue = 'Student';

// List of items in our dropdown menu
  var items = ['Admin', 'Student', 'Teacher'];
  bool _checkbox = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: ListView(
        children: [
          //email
          TextField(
            decoration: InputDecoration(
              border: const UnderlineInputBorder(),
              hintText: "Email",
              labelText: "example@exmple.com",
              prefix: IconButton(
                icon: const Icon(Icons.email_outlined),
                onPressed: () {},
              ),
              alignLabelWithHint: false,
              filled: true,
            ),
            keyboardType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.done,
          ),
          const SizedBox(
            height: 20,
          ),
//password
          TextField(
            obscureText: true,
            decoration: InputDecoration(
              border: const UnderlineInputBorder(),
              hintText: "Password",
              labelText: "Password",
              helperStyle: const TextStyle(color: Colors.green),
              suffixIcon: IconButton(
                icon: const Icon(Icons.visibility_off),
                onPressed: () {},
              ),
              alignLabelWithHint: false,
              filled: true,
            ),
            keyboardType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.done,
          ),
          CheckboxListTile(
            title: const Text(
              'Remember Password',
              style: TextStyle(color: Colors.grey),
            ),
            value: _checkbox,
            onChanged: (value) {
              // widget.callback(value!);
              setState(() => _checkbox = !_checkbox);
            },
          ),
          DropdownButton(
                    value: dropDownValue,
                    dropdownColor: const Color(0xfffff6f6),
                    hint: const Text("Student"),
                    underline: const SizedBox(),
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: Color(0xfff9703b),
                    ),
                    isExpanded: true,

                    // Array list of items
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    // After selecting the desired option,it will
                    // change button value to selected value
                    onChanged: (String? newValue) {
                      setState(() {
                        dropDownValue = newValue!;
                      });
                    },
                  ),
                  
                      const SizedBox(
                height: 12,
              ),
        ],
      ),
    );
  }
}