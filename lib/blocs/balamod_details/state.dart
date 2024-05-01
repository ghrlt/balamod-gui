part of 'cubit.dart';

enum Status { initial, loading, ready, error }

Directory? _dirFromJson(Map<String, dynamic>? json) => json?['path'] == null ? null : Directory(json!['path'] as String);

Map<String, dynamic> _dirToJson(Directory? dir) => {'path': dir?.path};

@JsonSerializable(explicitToJson: true)
class BalamodDetailsState extends Equatable {
  final Balatro? balatro;
  final Status status;
  final List<Release> releases;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final StreamController<String>? eventLogStreamController;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final StreamController<double>? progressStreamController;
  final Release? selectedRelease;
  final List<String> eventLogs;
  @JsonKey(fromJson: _dirFromJson, toJson: _dirToJson)
  final Directory? decompileDirectory;
  final double progress;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final ScrollController? scrollController;

  const BalamodDetailsState({
    this.balatro,
    this.releases = const [],
    this.status = Status.initial,
    this.eventLogStreamController,
    this.progressStreamController,
    this.selectedRelease,
    this.eventLogs = const [],
    this.decompileDirectory,
    this.progress = 0.0,
    this.scrollController,
  });

  bool get isLoaded => !(status == Status.initial || status == Status.loading);

  factory BalamodDetailsState.initial() => const BalamodDetailsState();

  BalamodDetailsState copyWith({
    Balatro? balatro,
    Status? status,
    List<Release>? releases,
    Release? selectedRelease,
    StreamController<String>? eventLogStreamController,
    StreamController<double>? progressStreamController,
    List<String>? eventLogs,
    Directory? decompileDirectory,
    double? progress,
    ScrollController? scrollController,
  }) {
    return BalamodDetailsState(
      balatro: balatro ?? this.balatro,
      status: status ?? this.status,
      releases: releases ?? this.releases,
      selectedRelease: selectedRelease ?? this.selectedRelease,
      eventLogStreamController:
          eventLogStreamController ?? this.eventLogStreamController,
      progressStreamController: progressStreamController ?? this.progressStreamController,
      eventLogs: eventLogs ?? this.eventLogs,
      decompileDirectory: decompileDirectory ?? this.decompileDirectory,
      progress: progress ?? this.progress,
      scrollController: scrollController ?? this.scrollController,
    );
  }

  factory BalamodDetailsState.fromJson(Map<String, dynamic> json) =>
      _$BalamodDetailsStateFromJson(json);

  Map<String, dynamic> toJson() => _$BalamodDetailsStateToJson(this);

  @override
  List<Object?> get props => [
        balatro?.version,
        releases.map((r) => r.id),
        selectedRelease,
        eventLogs,
        decompileDirectory?.path,
        progress,
      ];
}
