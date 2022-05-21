# phstl

Convert [GDAL](http://www.gdal.org/) rasters to STL mesh. Intended to produce landscape models from GeoTIFF heightmaps.

## Example

Here's a sample [GeoTIFF heightmap](demo/example.tif):

![tif input](/demo/exampletif.png)

To create a [surface mesh](demo/example.stl) from it, type:

	phstl example.tif example.stl

![mesh output](demo/examplemesh.png)

By default, the output is scaled such that one mesh unit represents one unit of the input coordinate system. Since the
input image resolution is 46 x 38 at about 12.8 feet per pixel (thus an extent of roughly 592 x 482 feet), the output
mesh extent is about 580 x 470 units.

To scale the output to fit a certain size, use the `-x` or `-y` extent option. To exaggerate vertical relief, use
the `-z` factor option. To anchor the dataset's lowest elevation at Z = 0, use the `-c` option to automatically clip
elevation values. Here's a [second example](demo/example2.stl):

	phstl -x 100 -z 3 -c example.tif example2.stl

![customized mesh output](demo/examplemesh2.png)

The output surface mesh is not a manifold object. Use another tool to solidify the model in preparation for 3D printing.
For examples, see these brief tutorials for [Blender](demo/blender.md) or [Meshmixer](demo/meshmixer.md).

## Usage

    usage: phstl.py [-h] [-x X] [-y Y] [-z Z] [-b BASE] [-c] [-v] RASTER [STL]
    
    Convert a GDAL raster (like a GeoTIFF heightmap) to an STL terrain surface.
    
    positional arguments:
      RASTER                Input heightmap image
      STL                   Output STL path (stdout)
    
    optional arguments:
      -h, --help            show this help message and exit
      -x X                  Fit output x to extent (mm)
      -y Y                  Fit output y to extent (mm)
      -z Z                  Vertical scale factor (1)
      -b BASE, --base BASE  Base height (0)
      -c, --clip            Clip z to minimum elevation
      -v, --verbose         Print log messages
      --band BAND           Raster data band (1)
      -m MINIMUM, --minimum MINIMUM
                            Omit vertices below minimum elevation
      -M MAXIMUM, --maximum MAXIMUM
                            Omit vertices above maximum elevation

## Docker Usage

Skip installing GDAL and just use docker! Specify all the same args to `phstl_docker.sh`

```commandline
./phstl_docker.sh -v -w -90.900995 32.312693 -90.832037 32.379813 -z 2 -r EPSG:3395 USGS_13_n33w091_20171205.tiff out9.stl
```

## Personal Examples

- Vicksburg, no reproject, with Z scaled from meters to degrees

```commandline
python3 phstl.py -v -w -90.900995 32.312693 -90.832037 32.379813 -z 0.00000898311982 USGS_13_n33w091_20171205.tiff out.stl
```

- Vicksburg, reprojected to World Mercator (EPSG:3395), scaling

```commandline
 python3 phstl.py -v -w -90.900995 32.312693 -90.832037 32.379813 -r EPSG:3395 USGS_13_n33w091_20171205.tiff out.stl
```

## Prerequisites

- [GDAL/OGR in Python](http://trac.osgeo.org/gdal/wiki/GdalOgrInPython) (`sudo easy_install gdal`)

## License

This project is released under an open source MIT license.
