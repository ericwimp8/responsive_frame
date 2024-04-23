import 'package:example/barrel.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:responsive_frame/responsive_frame.dart';

class Statistics extends StatefulWidget {
  const Statistics({super.key});

  @override
  State<Statistics> createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  void setSelectedPowerState(PowerStatsEnum value) {
    SuperHeroData.of(context).setSelectedPowerStat(value);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final state = SuperHeroData.of(context).data;

    return Column(
      children: [
        const Chart(),
        StatsTile(
          value: PowerStatsEnum.intelligence,
          groupValue: state.selectedPowerStat,
          onTap: setSelectedPowerState,
          title: Text(PowerStatsEnum.intelligence.label),
          leadingPath: 'assets/images/intelligence.png',
          leadingColor: theme.colorScheme.tertiary,
          trailing: Text(state.selectedHero.powerstats.intelligence.toString()),
        ),
        StatsTile(
          onTap: setSelectedPowerState,
          groupValue: state.selectedPowerStat,
          value: PowerStatsEnum.strength,
          title: Text(PowerStatsEnum.strength.label),
          leadingPath: 'assets/images/strength.png',
          leadingColor: theme.colorScheme.primary,
          trailing: Text(state.selectedHero.powerstats.strength.toString()),
        ),
        StatsTile(
          onTap: setSelectedPowerState,
          groupValue: state.selectedPowerStat,
          value: PowerStatsEnum.speed,
          title: Text(PowerStatsEnum.speed.name),
          leadingPath: 'assets/images/speed.png',
          leadingColor: theme.colorScheme.tertiaryContainer,
          trailing: Text(state.selectedHero.powerstats.speed.toString()),
        ),
        StatsTile(
          onTap: setSelectedPowerState,
          groupValue: state.selectedPowerStat,
          value: PowerStatsEnum.durability,
          title: Text(PowerStatsEnum.durability.label),
          leadingPath: 'assets/images/durability.png',
          leadingColor: theme.colorScheme.secondary,
          trailing: Text(state.selectedHero.powerstats.durability.toString()),
        ),
        StatsTile(
          onTap: setSelectedPowerState,
          groupValue: state.selectedPowerStat,
          value: PowerStatsEnum.power,
          title: Text(PowerStatsEnum.power.label),
          leadingPath: 'assets/images/power.png',
          leadingColor: theme.colorScheme.secondaryContainer,
          trailing: Text(state.selectedHero.powerstats.power.toString()),
        ),
        StatsTile(
          onTap: setSelectedPowerState,
          groupValue: state.selectedPowerStat,
          value: PowerStatsEnum.combat,
          title: Text(PowerStatsEnum.combat.label),
          leadingPath: 'assets/images/combat.png',
          leadingColor: theme.colorScheme.primaryContainer,
          trailing: Text(state.selectedHero.powerstats.combat.toString()),
        ),
      ],
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
  final PowerStatsEnum value;
  final PowerStatsEnum groupValue;
  final String leadingPath;
  final Color leadingColor;
  final Widget trailing;

  final void Function(PowerStatsEnum value) onTap;
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

  Color _color() {
    return theme.brightness == Brightness.dark
        ? leadingColor.lighten(30)
        : leadingColor.darken(30);
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: ClipRRect(
          borderRadius: kDefaultBorderRadius,
          child: ColoredBox(
            color: theme.colorScheme.surface.withOpacity(0.5),
            child: Align(
              child: ImageIcon(AssetImage(leadingPath), color: _color()),
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
    final state = SuperHeroData.of(context).data.selectedPowerStat;
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
    final heroData = SuperHeroData.of(context);

    final theme = Theme.of(context);
    return BarChart(
      BarChartData(
        barTouchData: barTouchData(
          theme,
          heroData.setSelectedPowerStat,
        ),
        titlesData: titlesData(theme),
        borderData: borderData,
        barGroups: barGroups(
          heroData.data.selectedPowerStat,
          heroData.data.selectedHero.powerstats,
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
    void Function(PowerStatsEnum) onTouch,
  ) =>
      BarTouchData(
        touchCallback: (p0, p1) {
          final props = p1?.spot?.spot.props;
          if (props != null && props.isNotEmpty && props.first != null) {
            onTouch(PowerStatsEnum.values[(props.first! as double).toInt()]);
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
    PowerStatsEnum selectedPowerStat,
    PowerStats data,
    ThemeData theme,
  ) {
    return [
      BarChartGroupData(
        x: 0,
        barRods: [
          _BarData(
            value: PowerStatsEnum.intelligence,
            groupValue: selectedPowerStat,
            toY: data.intelligence.toDouble(),
            colorOne: theme.colorScheme.tertiary.darken(70),
            colorTwo: theme.colorScheme.tertiary.lighten(50),
          ),
        ],
        showingTooltipIndicators: [0],
      ),
      BarChartGroupData(
        x: 1,
        barRods: [
          _BarData(
            value: PowerStatsEnum.strength,
            groupValue: selectedPowerStat,
            toY: data.strength.toDouble(),
            colorOne: theme.colorScheme.primary.darken(70),
            colorTwo: theme.colorScheme.primary.lighten(),
          ),
        ],
        showingTooltipIndicators: [0],
      ),
      BarChartGroupData(
        x: 2,
        barRods: [
          _BarData(
            value: PowerStatsEnum.speed,
            groupValue: selectedPowerStat,
            toY: data.speed.toDouble(),
            colorOne: theme.colorScheme.tertiaryContainer.darken(70),
            colorTwo: theme.colorScheme.tertiaryContainer.lighten(),
          ),
        ],
        showingTooltipIndicators: [0],
      ),
      BarChartGroupData(
        x: 3,
        barRods: [
          _BarData(
            value: PowerStatsEnum.durability,
            groupValue: selectedPowerStat,
            toY: data.durability.toDouble(),
            colorOne: theme.colorScheme.secondary.darken(70),
            colorTwo: theme.colorScheme.secondary.lighten(),
          ),
        ],
        showingTooltipIndicators: [0],
      ),
      BarChartGroupData(
        x: 4,
        barRods: [
          _BarData(
            value: PowerStatsEnum.power,
            groupValue: selectedPowerStat,
            toY: data.power.toDouble(),
            colorOne: theme.colorScheme.secondaryContainer.darken(70),
            colorTwo: theme.colorScheme.secondaryContainer.lighten(),
          ),
        ],
        showingTooltipIndicators: [0],
      ),
      BarChartGroupData(
        x: 5,
        barRods: [
          _BarData(
            value: PowerStatsEnum.combat,
            groupValue: selectedPowerStat,
            toY: data.combat.toDouble(),
            colorOne: theme.colorScheme.surfaceVariant.darken(70),
            colorTwo: theme.colorScheme.primaryContainer.lighten(),
          ),
        ],
        showingTooltipIndicators: [0],
      ),
    ];
  }
}

class StatisticsModel {
  StatisticsModel({
    required this.name,
    required this.icon,
    required this.value,
    required this.selected,
  });
  final String name;
  final IconData icon;
  final int value;
  final bool selected;
}

class _BarData extends BarChartRodData {
  _BarData({
    required super.toY,
    required this.groupValue,
    required this.value,
    required this.colorOne,
    required this.colorTwo,
  });

  final PowerStatsEnum value;
  final PowerStatsEnum groupValue;
  final Color colorOne;
  final Color colorTwo;

  bool get selected => value == groupValue;

  @override
  BorderRadius get borderRadius => const BorderRadius.all(Radius.circular(4));

  @override
  double get width => selected ? 40 : 25;

  @override
  BorderSide get borderSide => selected
      ? const BorderSide(color: Colors.white38, width: 3)
      : BorderSide.none;

  @override
  Gradient get gradient => LinearGradient(
        colors: selected
            ? [
                colorOne,
                colorTwo,
              ]
            : [
                colorOne.withOpacity(0.6),
                colorTwo.withOpacity(0.6),
              ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );
}
