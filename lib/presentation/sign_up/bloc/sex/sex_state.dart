enum Sex { male, female }

abstract class SexState {}
class DisableSexState extends SexState {}

abstract class EnableSexState extends SexState{}

class EnableMaleSexState extends EnableSexState {}

class EnableFemaleSexState extends EnableSexState {}
