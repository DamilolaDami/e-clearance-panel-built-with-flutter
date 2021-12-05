import 'package:flutter/material.dart';
import '../module/extension.dart';
enum ButtonType{Save, New, Delete, Cancel, Other}
class Label extends StatelessWidget {
  final String title;
  final double? fontSize;

  final Color? color;
 
  final bool bold;

  const Label(this.title, {Key? key, this.fontSize, this.color,  this.bold = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
     title,
      style: TextStyle(
        fontSize: fontSize ?? 16,
        color: color ?? Colors.black,
        fontWeight: bold ? FontWeight.bold : FontWeight.normal,

    ));
  }
}


class Button extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final Icon? icon;
  final Color? color;
  final EdgeInsets? padding;
  final ButtonType? buttontype;
  const Button(
      {Key? key,  
      required this.title,
      this.onTap,
      this.buttontype,
      this.icon,
      this.color,
      this.padding,}
     )
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: ElevatedButton(
      
        onPressed: onTap,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(this.buttontype == color ? Colors.blue:
          this.buttontype == ButtonType.Cancel ? Colors.deepOrangeAccent:
          this.buttontype == ButtonType.Delete ? Colors.red:
          this.buttontype == ButtonType.New ? Colors.green:
          this.buttontype == ButtonType.Save ? Colors.blue:
          Colors.blue),
        
        ),
        child: this.buttontype != null? 
             Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(this.buttontype == ButtonType.Save ? Icons.save:
                  this.buttontype == ButtonType.Cancel ?Icons.cancel:
                  this.buttontype == ButtonType.Delete ?Icons.delete:
                  this.buttontype == ButtonType.New ?Icons.add_box:
                 Icons.help_center,

                  ),
                  const SizedBox(width: 8),
                  this.buttontype == ButtonType.Save ?
                  "".toLabel():
                  this.buttontype == ButtonType.Cancel ?
                  "".toLabel():
                  this.buttontype == ButtonType.Delete ?
                  "".toLabel():
                  this.buttontype == ButtonType.New ?
                  "".toLabel():
                  title.toLabel()

                ],
              )
            : this.buttontype != null ?
            Row(children: [
              this.icon!,
              const SizedBox(width: 8),
              title.toLabel()
            ],):
            title.toLabel(),
      ),
    );
  }
}

class Edit extends StatelessWidget {
  final String? hint;
  final Function(String)? onChange;
  final bool? autoFocus;
  final bool password;
  final TextEditingController? controller;
  const Edit({ this.hint, this.onChange, this.autoFocus = false, this.password = false, this.controller, Key? key} ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
         border: OutlineInputBorder(
           gapPadding: 20,
           borderRadius: BorderRadius.circular(8)
         ),
         labelText: hint,
         labelStyle: TextStyle(
           fontSize: 16,
           color: Colors.grey.shade700,
         ),
      ),
      obscureText: password,
      controller: controller,
      onChanged: onChange,

    );
  }
}
