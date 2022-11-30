delete from "provider".asset_metadata_property;

insert into "provider".asset_metadata_property (asset_type, "name", "type") values
  ('NETCDF',  'mbrStatic',        'PNG'),

  ('RASTER',  'mbrStatic',        'PNG'),
  ('RASTER',  'thumbnail',        'PNG'),

  ('TABULAR', 'clustersStatic',   'PNG'),
  ('TABULAR', 'convexHullStatic', 'PNG'),
  ('TABULAR', 'heatmap',          'JSON'),
  ('TABULAR', 'heatmapStatic',    'PNG'),
  ('TABULAR', 'mbrStatic',        'PNG'),
  ('TABULAR', 'samples',          'JSON'),
  ('TABULAR', 'thumbnail',        'PNG'),

  ('VECTOR',  'clustersStatic',   'PNG'),
  ('VECTOR',  'convexHullStatic', 'PNG'),
  ('VECTOR',  'heatmap',          'JSON'),
  ('VECTOR',  'heatmapStatic',    'PNG'),
  ('VECTOR',  'mbrStatic',        'PNG'),
  ('VECTOR',  'samples',          'JSON'),
  ('VECTOR',  'thumbnail',        'PNG')
 ;
