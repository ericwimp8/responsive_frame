import 'package:example/barrel.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

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
          leading: const ImageIcon(
            AssetImage('assets/images/intelligence.png'),
            color: DashboardTheme.blue,
          ),
          trailing: Text(state.selectedHero.powerstats.intelligence.toString()),
        ),
        StatsTile(
          onTap: setSelectedPowerState,
          groupValue: state.selectedPowerStat,
          value: PowerStatsEnum.strength,
          title: Text(PowerStatsEnum.strength.label),
          leading: ImageIcon(
            const AssetImage('assets/images/strength.png'),
            color: theme.colorScheme.primary,
          ),
          trailing: Text(state.selectedHero.powerstats.strength.toString()),
        ),
        StatsTile(
          onTap: setSelectedPowerState,
          groupValue: state.selectedPowerStat,
          value: PowerStatsEnum.speed,
          title: Text(PowerStatsEnum.speed.name),
          leading: const ImageIcon(
            AssetImage('assets/images/speed.png'),
            color: DashboardTheme.steelPink,
          ),
          trailing: Text(state.selectedHero.powerstats.speed.toString()),
        ),
        StatsTile(
          onTap: setSelectedPowerState,
          groupValue: state.selectedPowerStat,
          value: PowerStatsEnum.durability,
          title: Text(PowerStatsEnum.durability.label),
          leading: ImageIcon(
            const AssetImage('assets/images/durability.png'),
            color: theme.colorScheme.secondary,
          ),
          trailing: Text(state.selectedHero.powerstats.durability.toString()),
        ),
        StatsTile(
          onTap: setSelectedPowerState,
          groupValue: state.selectedPowerStat,
          value: PowerStatsEnum.power,
          title: Text(PowerStatsEnum.power.label),
          leading: const ImageIcon(
            AssetImage('assets/images/power.png'),
            color: DashboardTheme.electricPurple,
          ),
          trailing: Text(state.selectedHero.powerstats.power.toString()),
        ),
        StatsTile(
          onTap: setSelectedPowerState,
          groupValue: state.selectedPowerStat,
          value: PowerStatsEnum.combat,
          title: Text(PowerStatsEnum.combat.label),
          leading: ImageIcon(
            const AssetImage('assets/images/combat.png'),
            color: theme.colorScheme.primaryContainer,
          ),
          trailing: Text(state.selectedHero.powerstats.combat.toString()),
        ),
      ],
    );
  }
}

class StatsTile extends StatelessWidget {
  const StatsTile({
    required this.title,
    required this.leading,
    required this.trailing,
    required this.value,
    required this.groupValue,
    required this.onTap,
    super.key,
  });
  final Widget title;
  final PowerStatsEnum value;
  final PowerStatsEnum groupValue;
  final Widget leading;
  final Widget trailing;

  final void Function(PowerStatsEnum value) onTap;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final selected = value == groupValue;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: ListTile(
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
                : theme.colorScheme.secondaryContainer.withOpacity(0.1),
          ),
        ),
        leadingAndTrailingTextStyle: theme.textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w600,
        ),
        leading: leading,
        title: title,
        trailing: trailing,
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
        barTouchData: barTouchData(theme),
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
    );
  }

  BarTouchData barTouchData(ThemeData theme) => BarTouchData(
        enabled: false,
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
            colorOne: DashboardTheme.blue,
            colorTwo: Colors.blue[300]!,
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
            colorOne: theme.colorScheme.primary,
            colorTwo: Colors.yellowAccent[100]!,
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
            colorOne: DashboardTheme.steelPink,
            colorTwo: Colors.pink[200]!,
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
            colorOne: DashboardTheme.sgbusGreen,
            colorTwo: Colors.green[200]!,
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
            colorOne: DashboardTheme.electricPurple,
            colorTwo: Colors.purple[200]!,
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
            colorOne: DashboardTheme.orangePeel,
            colorTwo: Colors.orangeAccent[100]!,
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
