import 'package:example/barrel.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:responsive_frame/responsive_frame.dart';
import 'package:with_value/with_value.dart';

class Statistics extends StatefulWidget {
  const Statistics({super.key});

  @override
  State<Statistics> createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  void setSelectedPowerState(PowerStatEnum value, BuildContext context) {
    WithValueUpdate.of<StatisticsState>(context).setSelectedPowerStat(value);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SelectedSuperheroWrapper(
      builder: (BuildContext context, Superhero superhero) {
        return StatisticsStateWrapper(
          child: (context, state) {
            return Column(
              children: [
                const Chart(),
                StatsTile(
                  value: PowerStatEnum.intelligence,
                  groupValue: state.selectedPowerStat,
                  onTap: (value) => setSelectedPowerState(value, context),
                  title: Text(PowerStatEnum.intelligence.label),
                  leadingPath: 'assets/images/intelligence.png',
                  leadingColor: theme.colorScheme.tertiary,
                  trailing: Text(state.powerStats.intelligence.toString()),
                ),
                StatsTile(
                  onTap: (value) => setSelectedPowerState(value, context),
                  groupValue: state.selectedPowerStat,
                  value: PowerStatEnum.strength,
                  title: Text(PowerStatEnum.strength.label),
                  leadingPath: 'assets/images/strength.png',
                  leadingColor: theme.colorScheme.primary,
                  trailing: Text(state.powerStats.strength.toString()),
                ),
                StatsTile(
                  onTap: (value) => setSelectedPowerState(value, context),
                  groupValue: state.selectedPowerStat,
                  value: PowerStatEnum.speed,
                  title: Text(PowerStatEnum.speed.name),
                  leadingPath: 'assets/images/speed.png',
                  leadingColor: theme.colorScheme.tertiaryContainer,
                  trailing: Text(state.powerStats.speed.toString()),
                ),
                StatsTile(
                  onTap: (value) => setSelectedPowerState(value, context),
                  groupValue: state.selectedPowerStat,
                  value: PowerStatEnum.durability,
                  title: Text(PowerStatEnum.durability.label),
                  leadingPath: 'assets/images/durability.png',
                  leadingColor: theme.colorScheme.secondary,
                  trailing: Text(state.powerStats.durability.toString()),
                ),
                StatsTile(
                  onTap: (value) => setSelectedPowerState(value, context),
                  groupValue: state.selectedPowerStat,
                  value: PowerStatEnum.power,
                  title: Text(PowerStatEnum.power.label),
                  leadingPath: 'assets/images/power.png',
                  leadingColor: theme.colorScheme.secondaryContainer,
                  trailing: Text(state.powerStats.power.toString()),
                ),
                StatsTile(
                  onTap: (value) => setSelectedPowerState(value, context),
                  groupValue: state.selectedPowerStat,
                  value: PowerStatEnum.combat,
                  title: Text(PowerStatEnum.combat.label),
                  leadingPath: 'assets/images/combat.png',
                  leadingColor: theme.colorScheme.primaryContainer,
                  trailing: Text(state.powerStats.combat.toString()),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class StatsTile extends StatelessWidget {
  const StatsTile({
    required this.title,
    required this.trailing,
    required this.value,
    required this.groupValue,
    required this.onTap,
    required this.leadingPath,
    required this.leadingColor,
    super.key,
  });
  final Widget title;
  final PowerStatEnum value;
  final PowerStatEnum groupValue;
  final String leadingPath;
  final Color leadingColor;
  final Widget trailing;

  final void Function(PowerStatEnum value) onTap;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final selected = value == groupValue;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        contentPadding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
        selectedTileColor: Colors.transparent,
        selectedColor: theme.colorScheme.onSurface,
        selected: selected,
        onTap: () => onTap(value),
        titleTextStyle: theme.textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w600,
        ),
        subtitleTextStyle: theme.textTheme.bodySmall?.copyWith(
          fontWeight: FontWeight.w400,
        ),
        shape: (theme.listTileTheme.shape! as RoundedRectangleBorder).copyWith(
          side: BorderSide(
            width: 2,
            color: selected
                ? theme.colorScheme.primary
                : theme.colorScheme.secondaryContainer.withOpacity(0.3),
          ),
        ),
        leadingAndTrailingTextStyle: theme.textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w600,
        ),
        leading: _StatisticsTileLeading(
          theme: theme,
          leadingPath: leadingPath,
          leadingColor: leadingColor,
        ),
        title: title,
        trailing: trailing,
      ),
    );
  }
}

class _StatisticsTileLeading extends StatelessWidget {
  const _StatisticsTileLeading({
    required this.theme,
    required this.leadingPath,
    required this.leadingColor,
  });

  final ThemeData theme;
  final String leadingPath;
  final Color leadingColor;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Material(
          clipBehavior: Clip.antiAlias,
          borderRadius: kDefaultBorderRadius,
          color: leadingColor,
          child: Align(
            child: DecoratedBox(
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    spreadRadius: 10,
                    color: Colors.black38,
                  ),
                ],
              ),
              child: ImageIcon(
                AssetImage(leadingPath),
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Chart extends StatefulWidget {
  const Chart({super.key});

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  @override
  Widget build(BuildContext context) {
    final state =
        WithValueUpdate.of<StatisticsState>(context).selectedPowerStat;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Material(
        type: MaterialType.transparency,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              AppHeading(label: state.label),
              const AspectRatio(
                aspectRatio: 1,
                child: _BarChart(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BarChart extends StatelessWidget {
  const _BarChart();

  @override
  Widget build(BuildContext context) {
    final state = WithValueUpdate.of<StatisticsState>(context);

    final theme = Theme.of(context);
    return BarChart(
      BarChartData(
        barTouchData: barTouchData(
          theme,
          state.setSelectedPowerStat,
        ),
        titlesData: titlesData(theme),
        borderData: borderData,
        barGroups: barGroups(
          state.selectedPowerStat,
          state.powerStats,
          theme,
        ),
        gridData: const FlGridData(show: false),
        alignment: BarChartAlignment.spaceAround,
        maxY: 120,
      ),
      swapAnimationDuration: const Duration(milliseconds: 300),
    );
  }

  BarTouchData barTouchData(
    ThemeData theme,
    void Function(PowerStatEnum) onTouch,
  ) =>
      BarTouchData(
        touchCallback: (p0, p1) {
          final props = p1?.spot?.spot.props;
          if (props != null && props.isNotEmpty && props.first != null) {
            onTouch(PowerStatEnum.values[(props.first! as double).toInt()]);
          }
        },
        enabled: true,
        touchTooltipData: BarTouchTooltipData(
          getTooltipColor: (group) => Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 8,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.toY.round().toString(),
              TextStyle(
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.w300,
                fontSize: 10,
              ),
            );
          },
        ),
      );

  Widget getTitles(double value, TitleMeta meta, ThemeData theme) {
    final style = TextStyle(
      color: theme.colorScheme.onSurface,
      fontWeight: FontWeight.w400,
      fontSize: 10,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'INT';
      case 1:
        text = 'STR';
      case 2:
        text = 'SPE';
      case 3:
        text = 'DUR';
      case 4:
        text = 'POW';
      case 5:
        text = 'COM';
      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(text, style: style),
    );
  }

  FlTitlesData titlesData(ThemeData theme) => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: (value, meta) => getTitles(value, meta, theme),
          ),
        ),
        leftTitles: const AxisTitles(),
        topTitles: const AxisTitles(),
        rightTitles: const AxisTitles(),
      );

  FlBorderData get borderData => FlBorderData(
        show: false,
      );

  List<BarChartGroupData> barGroups(
    PowerStatEnum selectedPowerStat,
    PowerStats data,
    ThemeData theme,
  ) {
    return [
      BarChartGroupData(
        x: 0,
        barRods: [
          _BarData(
            value: PowerStatEnum.intelligence,
            groupValue: selectedPowerStat,
            toY: data.intelligence.toDouble(),
            colorOne: theme.colorScheme.tertiary,
            colorTwo: theme.colorScheme.tertiary,
            theme: theme,
          ),
        ],
        showingTooltipIndicators: [0],
      ),
      BarChartGroupData(
        x: 1,
        barRods: [
          _BarData(
            value: PowerStatEnum.strength,
            groupValue: selectedPowerStat,
            toY: data.strength.toDouble(),
            colorOne: theme.colorScheme.primary,
            colorTwo: theme.colorScheme.primary,
            theme: theme,
          ),
        ],
        showingTooltipIndicators: [0],
      ),
      BarChartGroupData(
        x: 2,
        barRods: [
          _BarData(
            value: PowerStatEnum.speed,
            groupValue: selectedPowerStat,
            toY: data.speed.toDouble(),
            colorOne: theme.colorScheme.tertiaryContainer,
            colorTwo: theme.colorScheme.tertiaryContainer,
            theme: theme,
          ),
        ],
        showingTooltipIndicators: [0],
      ),
      BarChartGroupData(
        x: 3,
        barRods: [
          _BarData(
            value: PowerStatEnum.durability,
            groupValue: selectedPowerStat,
            toY: data.durability.toDouble(),
            colorOne: theme.colorScheme.secondary,
            colorTwo: theme.colorScheme.secondary,
            theme: theme,
          ),
        ],
        showingTooltipIndicators: [0],
      ),
      BarChartGroupData(
        x: 4,
        barRods: [
          _BarData(
            value: PowerStatEnum.power,
            groupValue: selectedPowerStat,
            toY: data.power.toDouble(),
            colorOne: theme.colorScheme.secondaryContainer,
            colorTwo: theme.colorScheme.secondaryContainer,
            theme: theme,
          ),
        ],
        showingTooltipIndicators: [0],
      ),
      BarChartGroupData(
        x: 5,
        barRods: [
          _BarData(
            value: PowerStatEnum.combat,
            groupValue: selectedPowerStat,
            toY: data.combat.toDouble(),
            colorOne: theme.colorScheme.primaryContainer,
            colorTwo: theme.colorScheme.primaryContainer,
            theme: theme,
          ),
        ],
        showingTooltipIndicators: [0],
      ),
    ];
  }
}

class _BarData extends BarChartRodData {
  _BarData({
    required super.toY,
    required this.groupValue,
    required this.value,
    required this.colorOne,
    required this.colorTwo,
    required this.theme,
  });

  final PowerStatEnum value;
  final PowerStatEnum groupValue;
  final Color colorOne;
  final Color colorTwo;
  final ThemeData theme;

  bool get selected => value == groupValue;

  @override
  BorderRadius get borderRadius => const BorderRadius.all(Radius.circular(4));

  @override
  double get width => selected ? 40 : 25;

  @override
  BorderSide get borderSide => selected
      ? BorderSide(color: theme.colorScheme.primary.withOpacity(0.3), width: 3)
      : BorderSide(color: theme.colorScheme.primary.withOpacity(0.1));

  @override
  Gradient get gradient => LinearGradient(
        colors: selected
            ? [
                colorTwo.darken(20),
                colorOne.lighten(),
              ]
            : [
                colorTwo.darken(30).withOpacity(0.9),
                colorOne.lighten(20).withOpacity(0.9),
              ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );
}
