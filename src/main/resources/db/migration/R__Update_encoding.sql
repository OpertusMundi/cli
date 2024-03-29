insert into "spatial".encoding values
  ('Apple Roman'),
  ('arabic'),
  ('ASMO-708'),
  ('Big5'),
  ('Big5-ETen'),
  ('Big5-HKSCS'),
  ('CP1250'),
  ('CP1251'),
  ('CP1252'),
  ('CP1253'),
  ('CP1254'),
  ('CP1255'),
  ('CP1256'),
  ('CP1257'),
  ('CP1258'),
  ('CP819'),
  ('CP850'),
  ('CP866'),
  ('CP874'),
  ('CP936'),
  ('CP949'),
  ('CP950'),
  ('csHPRoman8'),
  ('csIBM866'),
  ('csISOLatin1'),
  ('csISOLatin2'),
  ('csISOLatin3'),
  ('csISOLatin4'),
  ('csISOLatin5'),
  ('csISOLatin6'),
  ('csISOLatinArabic'),
  ('csISOLatinCyrillic'),
  ('csISOLatinGreek'),
  ('csISOLatinHebrew'),
  ('csKOI8R'),
  ('csPC850Multilingual'),
  ('cyrillic'),
  ('ECMA-114'),
  ('ECMA-118'),
  ('EUC-JP'),
  ('EUC-KR'),
  ('GB18030'),
  ('GB2312'),
  ('GBK'),
  ('greek'),
  ('hebrew'),
  ('hp-roman8'),
  ('IBM819'),
  ('IBM850'),
  ('IBM866'),
  ('IBM874'),
  ('iscii-bng'),
  ('iscii-dev'),
  ('iscii-gjr'),
  ('iscii-knd'),
  ('iscii-mlm'),
  ('iscii-ori'),
  ('iscii-pnj'),
  ('iscii-tlg'),
  ('iscii-tml'),
  ('ISO 8859-11'),
  ('ISO 8859-8-I'),
  ('ISO-2022-JP'),
  ('ISO-8859-1'),
  ('ISO-8859-10'),
  ('ISO-8859-10:1992'),
  ('ISO-8859-13'),
  ('ISO-8859-14'),
  ('ISO-8859-15'),
  ('ISO-8859-16'),
  ('ISO-8859-2'),
  ('ISO-8859-3'),
  ('ISO-8859-4'),
  ('ISO-8859-5'),
  ('ISO-8859-6'),
  ('ISO-8859-6-I'),
  ('ISO-8859-7'),
  ('ISO-8859-8'),
  ('ISO-8859-9'),
  ('iso-celtic'),
  ('iso-ir-100'),
  ('iso-ir-101'),
  ('iso-ir-109'),
  ('iso-ir-110'),
  ('iso-ir-126'),
  ('iso-ir-127'),
  ('iso-ir-138'),
  ('iso-ir-144'),
  ('iso-ir-148'),
  ('iso-ir-157'),
  ('iso-ir-199'),
  ('iso-ir-226'),
  ('JIS7'),
  ('KOI8-R'),
  ('KOI8-RU'),
  ('KOI8-U'),
  ('latin1'),
  ('latin10'),
  ('latin2'),
  ('latin3'),
  ('latin4'),
  ('latin5'),
  ('latin6'),
  ('latin8'),
  ('latin9'),
  ('macintosh'),
  ('MacRoman'),
  ('MS936'),
  ('MS_Kanji'),
  ('roman8'),
  ('Shift_JIS'),
  ('SJIS'),
  ('System'),
  ('TIS-620'),
  ('TSCII'),
  ('UTF-16'),
  ('UTF-16BE'),
  ('UTF-16LE'),
  ('UTF-32'),
  ('UTF-32BE'),
  ('UTF-32LE'),
  ('UTF-8'),
  ('windows-1250'),
  ('windows-1251'),
  ('windows-1252'),
  ('windows-1253'),
  ('windows-1254'),
  ('windows-1255'),
  ('windows-1256'),
  ('windows-1257'),
  ('windows-1258'),
  ('windows-936'),
  ('windows-949'),
  ('WINSAMI2'),
  ('WS2');

update "spatial".encoding values set code_lower = lower(code);
