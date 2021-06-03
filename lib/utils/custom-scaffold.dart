import 'package:calendar/index.dart';
import 'package:calendar/user-utils/bottom-bar.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({
    Key key,
    this.isLoading = false,
    this.children = const [],
    this.padding = const EdgeInsets.symmetric(horizontal: 10),
    this.appBar,
    this.isScrollable = false,
    this.bottomBar,
    this.floatingAppButton,
  }) : super(key: key);
  final bool isLoading;
  final List<Widget> children;
  final EdgeInsetsGeometry padding;
  final CustomAppBar appBar;
  final bool isScrollable;
  final BottomBar bottomBar;
  final FloatingAppButton floatingAppButton;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 500),
                child: Column(
                  children: [
                    appBar == null ? Container() : appBar,
                    Expanded(
                      child: isScrollable
                          ? ListView(
                              padding: padding,
                              children: children,
                            )
                          : Padding(
                              padding: padding,
                              child: Column(
                                children: children,
                              ),
                            ),
                    )
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: bottomBar,
          floatingActionButton: floatingAppButton,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          extendBody: true,
        ),
        isLoading
            ? Container(
                height: double.infinity,
                width: double.infinity,
                color: Colors.black45,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Container()
      ],
    );
  }
}
