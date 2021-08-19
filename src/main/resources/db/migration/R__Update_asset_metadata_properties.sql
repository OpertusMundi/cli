delete from "provider".asset_metadata_property;

insert into "provider".asset_metadata_property (asset_type, "name", "type") values
  ('NETCDF', 'mbrStatic',        'PNG'),
  ('RASTER', 'mbrStatic',        'PNG'),
  ('VECTOR', 'clustersStatic',   'PNG'),
  ('VECTOR', 'convexHullStatic', 'PNG'),
  ('VECTOR', 'heatmap',          'JSON'),
  ('VECTOR', 'heatmapStatic',    'PNG'),
  ('VECTOR', 'mbrStatic',        'PNG'),
  ('VECTOR', 'samples',          'JSON'),
  ('VECTOR', 'thumbnail',        'PNG')
 ;
