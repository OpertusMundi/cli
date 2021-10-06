delete from "file".asset_file_type;

insert into "file".asset_file_type ("category", "format", "extensions", "allow_bundle", "bundle_extensions", "enabled", "notes") values
('VECTOR', 'ESRI Shapefile', 'shp',     true,  'zip', true, 'Must be accompanied with at least .dbf and .shx; optional other files like .prj may also be part of a shapefile'),
('VECTOR', 'CSV',            'csv,txt', false, null, true,  'Comma separated values; different separators may be used'),
('VECTOR', 'GeoJSON',        'geojson', false, null, true,  null),
('VECTOR', 'GML',            'gml',     false, null, true,  'Geography Markup Language'),
('VECTOR', 'KML',            'kml,kmz', false, null, true,  'Keyhole Markup Language'),
('VECTOR', 'XLS',            'xls',     false, null, true,  'MS Excel format'),
('VECTOR', 'XLSX',           'xlsx',    false, null, true,  'MS Office Open XML spreadsheet')
;

insert into "file".asset_file_type ("category", "format", "extensions", "allow_bundle", "bundle_extensions", "enabled", "notes") values
('RASTER', 'GTiff',          'tif,tiff,tff',  true,  null, true,  'GeoTIFF File Format; usually accompanied with a world file with extension .tfw, .tifw/.tiffw or .wld'),
('RASTER', 'COG',            'tif,tiff,tff',  true,  null, true,  'Cloud Optimized GeoTIFF generator; usually accompanied with a world file with extension .tfw, .tifw/.tiffw or .wld'),
('RASTER', 'HFA',            'img',           false, null, true,  'Erdas Imagine'),
('RASTER', 'USGSDEM',        'dem',           false, null, true,  'USGS ASCII DEM (and CDED)'),
('RASTER', 'AAIGrid',        'asc',           false, null, true,  'Arc/Info ASCII Grid'),
('RASTER', 'AIG',            'adf',           true,  null, true,  'Arc/Info Binary Grid (typically several .adf files in a common directory; possibly accompanied with .prj)'),
('RASTER', 'MrSID',          'sid',           true,  null, true,  'Multi-resolution Seamless Image Database; usually accompanied with a world file .sdw')
;

insert into "file".asset_file_type ("category", "format", "extensions", "allow_bundle", "bundle_extensions", "enabled", "notes") values
('NETCDF', 'netCDF',         'nc',      false, null, true, 'NetCDF: Network Common Data Form')
;

insert into "file".asset_file_type ("category", "format", "extensions", "allow_bundle", "bundle_extensions", "enabled", "notes") values
('TABULAR', 'CSV',            'csv,txt', false, null, true,  'Comma separated values; different separators may be used'),
('TABULAR', 'XLS',            'xls',     false, null, true,  'MS Excel format'),
('TABULAR', 'XLSX',           'xlsx',    false, null, true,  'MS Office Open XML spreadsheet')
;
