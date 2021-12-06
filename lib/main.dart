import 'dart:ui';
import "package:flutter/material.dart";
import "package:bitsdojo_window/bitsdojo_window.dart";

/*  
    IMPORTANT: Copy below code to "./windows/runner/main.cpp"
    #include <bitsdojo_window_windows/bitsdojo_window_plugin.h>
    auto bdw = bitsdojo_window_configure(BDW_CUSTOM_FRAME | BDW_HIDE_ON_STARTUP);
*/

const appTitle = "NOVA";
const appDesc = "Nutritionist Ordering Validate Application";

void main() {
    runApp(
        AppRoot()
    );

    doWhenWindowReady(() {
        appWindow.alignment = Alignment.center;
        appWindow.minSize = Size(1600, 900);
        appWindow.size = Size(1600, 900);
        appWindow.title = appTitle;
        appWindow.show();
    });
}

class AppRoot extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                primarySwatch: Colors.pink,
                fontFamily: "Square"
            ),
            home: Scaffold(
                body: WindowBorder(
                    color: Colors.black,
                    child: Row(
                        children: [
                            LeftSide(),
                            RightSide()
                        ],
                    )
                )
            )
        );
    }
}

class LeftSide extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return SizedBox(
            width: 425,
            child: Container(
                color: Colors.blue.shade900,
                child: Column(
                    children: [
                        WindowTitleBarBox(
                            child: MoveWindow(),
                        ),
                        Expanded(
                            child: Container(
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                        LoginSection()
                                    ]
                                )
                            )
                        )
                    ],
                )
            )
        );
    }
}

class RightSide extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return Expanded(
            child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            "assets/images/intro.png"
                        ),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                            Colors.blue.shade900,
                            BlendMode.multiply
                        )
                    )
                ),
                child: Column(
                    children: [
                        WindowTitleBarBox(
                            child: Row(
                                children: [
                                    Expanded(
                                        child: MoveWindow()
                                    ),
                                    WindowButtons()
                                ],
                            ),
                        ),
                        Expanded(
                            child: Stack(
                                children: [
                                    IntroSection(),
                                    Positioned(
                                        right: 0,
                                        bottom: 0,
                                        child: Padding(
                                            padding: EdgeInsets.all(16),
                                            child: FlutterLogo(
                                                size: 50,
                                            ),
                                        )
                                    )
                                ],
                            )
                        )
                    ],
                )
            )
        );
    }
}

class WindowButtons extends StatelessWidget {
    @override
    final btnColors = WindowButtonColors(
        iconNormal: Colors.black,
        mouseOver: Colors.transparent,
        mouseDown: Colors.transparent,
        iconMouseOver: Colors.black,
        iconMouseDown: Colors.black
    );

    final closeBtnColors = WindowButtonColors(
        iconNormal: Colors.pinkAccent.shade400,
        mouseOver: Colors.transparent,
        mouseDown: Colors.transparent,
        iconMouseOver: Colors.pinkAccent.shade400,
        iconMouseDown: Colors.pinkAccent.shade400
    );

    Widget build(BuildContext context) {
        return Row(
            children: [
                MinimizeWindowButton(
                    colors: btnColors,
                ),
                MaximizeWindowButton(
                    colors: btnColors,
                ),
                CloseWindowButton(
                    colors: closeBtnColors,
                    onPressed: () => {
                        showDialog(
                            context: context,
                            builder: (BuildContext ctxSlave) => AlertDialog(
                                content: Text(
                                    "어플리케이션을 종료할까요?",
                                    style: TextStyle(
                                        fontFamily: "Air"
                                    ),
                                ),
                                actions: [
                                    TextButton(
                                        onPressed: () => Navigator.pop(ctxSlave),
                                        child: Text("Cancel")
                                    ),
                                    TextButton(
                                        onPressed: () => {
                                            appWindow.close()
                                        },
                                        child: Text("OK")
                                    )
                                ],
                            )
                        )
                    },
                )
            ],
        );
    }
}

// Login
class LoginSection extends StatelessWidget {
    @override
    void rejectRequest(BuildContext ctxMaster, String messageText) {
        showDialog(
            context: ctxMaster,
            builder: (BuildContext ctxSlave) => AlertDialog(
                content: Text(
                    messageText,
                    style: TextStyle(
                        fontFamily: "Air"
                    ),
                ),
                actions: [
                    TextButton(
                        onPressed: () => Navigator.pop(ctxSlave),
                        child: Text("OK")
                    )
                ],
            )
        );
    }

    final contId = TextEditingController();
    final contPw = TextEditingController();

    TextFormField getField(String hintText, TextEditingController controller, bool obscureText) {
        OutlineInputBorder borderStyle = OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
                color: Colors.transparent
            )
        );

        return TextFormField(
            controller: controller,
            obscureText: obscureText,
            cursorWidth: 6,
            cursorColor: Colors.black,
            cursorRadius: Radius.circular(3),
            style: TextStyle(
                fontSize: 28,
                fontFamily: "Roboto",
                fontWeight: FontWeight.w700,
                fontFeatures: [FontFeature.enable("dlig")]
            ),
            decoration: InputDecoration(
                filled: true,
                hintText: hintText,
                border: borderStyle,
                fillColor: Colors.white,
                focusedBorder: borderStyle,
                enabledBorder: borderStyle,
                hintStyle: TextStyle(
                    color: Colors.black12,
                    fontWeight: FontWeight.w400
                )
            ),
        );
    }

    Widget build(BuildContext context) {
        return Container(
            padding: EdgeInsets.symmetric(
                horizontal: 28,
                vertical: 0
            ),
            child: Column(
                children: [
                    getField("Identification", contId, false),
                    SizedBox(height: 16),
                    getField("Password", contPw, true),
                    SizedBox(height: 16),
                    ElevatedButton(
                        child: Text(
                            "LOGIN",
                            style: TextStyle(
                                fontSize: 16,
                                letterSpacing: 8,
                                color: Colors.black,
                                fontFamily: "Roboto",
                                fontWeight: FontWeight.w500
                            ),
                        ),
                        onPressed: () {
                            if (contId.text == "msgfree" && contPw.text == "1234") {
                                print("pass");
                            } else if (contId.text == "" || contPw.text == "") {
                                rejectRequest(
                                    context,
                                    "아이디와 패스워드를 입력해주세요"
                                );
                            } else {
                                rejectRequest(
                                    context,
                                    "유효하지 않은 계정이에요\n\n테스트 계정 => ID: msgfree, PW: 1234"
                                );
                            }
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Colors.lightGreenAccent.shade700,
                            minimumSize: Size(
                                double.infinity, 74
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)
                            )
                        ),
                    )
                ]
            )
        );
    }
}

// Intro
class IntroSection extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
                Text(
                    appTitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        letterSpacing: 8,
                        color: Colors.white,
                        fontFamily: "Comfortaa",
                        fontWeight: FontWeight.w300,
                        fontSize: 72,
                        shadows: [
                            Shadow(
                                color: Colors.black,
                                offset: Offset(1, 1),
                                blurRadius: 2
                            )
                        ]
                    ),
                ),
                Text(
                    appDesc,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                        fontFamily: "Comfortaa",
                        fontSize: 20,
                        shadows: [
                            Shadow(
                                color: Colors.black,
                                offset: Offset(1, 1),
                                blurRadius: 2
                            )
                        ]
                    )
                )
            ],
        );
    }
}