class Language
{
  final int id;
  final String name;
  final String flag;
  final String languageCode;

  Language(this.id, this.name, this.flag, this.languageCode);

  static List<Language> languageList()
  {
    return [
      Language(1, "English", "🇺🇸", "en-US"),
      Language(2, "Arabic", "🇪🇬", "ar-EG")
    ];
  }
}