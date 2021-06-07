import 'package:calendar/index.dart';
class CardChip extends StatelessWidget {
  CardChip({
    Key key,
    this.color = Colors.grey,
    @required this.text,
  }) : super(key: key);

  final String text;
  Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 5),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.4),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11,
        ),
      ),
    );
  }
}
