class CharacterDailyVotesEntity {
  int? characterTotalDailyVotes;
  String? characterId;
  int? morningVotes;
  int? afternoonVotes;
  int? nightVotes;
  CharacterDailyVotesEntity(
      {this.afternoonVotes,
      this.characterId,
      this.characterTotalDailyVotes,
      this.morningVotes,
      this.nightVotes});
}
