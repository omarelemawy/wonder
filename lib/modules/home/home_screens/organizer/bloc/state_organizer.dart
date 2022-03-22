abstract class OrganizerStates{}

class InitialOrganizerStates extends OrganizerStates{}

class GetLoadingOrganizerEventsStates extends OrganizerStates{}
class GetSuccessOrganizerEventsStates extends OrganizerStates{}
class GetImageAddSponsorState extends OrganizerStates{}
class AddIteOfInformLocState extends OrganizerStates{}
class DeleteIteOfInformLocState extends OrganizerStates{}
class GetErrorOrganizerEventsStates extends OrganizerStates{
  String error;
  GetErrorOrganizerEventsStates(this.error);
}

class AddSponsorLoadingStates extends OrganizerStates{}
class AddSponsorSuccessStates extends OrganizerStates{}
class AddSponsorErrorStates extends OrganizerStates{
  String error;
  AddSponsorErrorStates(this.error);
}

class RemoveEventLoadingStates extends OrganizerStates{}
class RemoveEventSuccessStates extends OrganizerStates{}
class RemoveEventErrorStates extends OrganizerStates{
  String error;
  RemoveEventErrorStates(this.error);
}

class RemoveSponsorLoadingStates extends OrganizerStates{}
class RemoveSponsorSuccessStates extends OrganizerStates{}
class RemoveSponsorErrorStates extends OrganizerStates{
  String error;
  RemoveSponsorErrorStates(this.error);
}

class GetSponsersLoadingOrganizerStates extends OrganizerStates{}
class GetSponsersSuccessOrganizereStates extends OrganizerStates{}
class GetSponsersErrorOrganizereStates extends OrganizerStates{
  String error;
  GetSponsersErrorOrganizereStates(this.error);
}
class AddEventLoadingStates extends OrganizerStates{}
class AddEventSuccessStates extends OrganizerStates{}
class AddEventErrorStates extends OrganizerStates{
  String error;
  AddEventErrorStates(this.error);
}
class LogOutLoadingOrganizerStates extends OrganizerStates{}
class LogOutSuccessOrganizerStates extends OrganizerStates{}
class ChangeOnlineModeAddEventState extends OrganizerStates{}
class ChangeCategoriesAddEventState extends OrganizerStates{}

class ChangeSponsorAddEventState extends OrganizerStates{}


class ChangeLocationAddEventState extends OrganizerStates{}
class LogOutErrorOrganizerStates extends OrganizerStates{
  String error;
  LogOutErrorOrganizerStates(this.error);
}


class GetLoadingOrganizerCategoriesStates extends OrganizerStates{}
class GetSuccessOrganizerCategoriesStates extends OrganizerStates{}
class GetErrorOrganizerCategoriesStates extends OrganizerStates{
  String error;
  GetErrorOrganizerCategoriesStates(this.error);
}
class GetLoadingOrganizerCountriesStates extends OrganizerStates{}
class ChangeCountriesAddEventState extends OrganizerStates{}

class AllSponserListSelectedAddEventState extends OrganizerStates{}
class RemoveSponsorListSelectedAddEventState extends OrganizerStates{}

class GetSuccessOrganizerCountriesStates extends OrganizerStates{}
class GetErrorOrganizerCountriesStates extends OrganizerStates{
  String error;
  GetErrorOrganizerCountriesStates(this.error);
}