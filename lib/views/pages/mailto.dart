part of 'pages.dart';

class MailTo extends StatefulWidget {
  const MailTo({super.key});

  @override
  State<MailTo> createState() => _MailToState();
}

final ctrlEmail = TextEditingController();

@override
void dispose() {
  ctrlEmail.dispose();
}

class _MailToState extends State<MailTo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Send Mail"),
      ),
      body: Center(
        child: Form(
          child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: "Email",
                prefixIcon: Icon(Icons.email_outlined),
                hintText: "Email",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              controller: ctrlEmail,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                return !EmailValidator.validate(value.toString())
                    ? 'Email tidak valid!'
                    : null;
              }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await EmailService.sendMail(ctrlEmail.text.toString()).then((value) {
            var result = json.decode(value.body);
            Fluttertoast.showToast(
                msg: result['message'],
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor:
                    result['code'] == 200 ? Colors.green : Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          });
        },
        tooltip: 'Send mail',
        child: const Icon(Icons.send_rounded),
      ),
    );
  }
}
