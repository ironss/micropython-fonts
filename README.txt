Bitmap fonts for Micropython
############################

Peter Hinch's micropython-font-to-py utility converts fonts from TTF, OTF and
various bitmap formats into a bitmap format that is easy for use on a 
Micropython based system.

This tool automates the construction of multiple fonts using that tool. It
can be configured to generate multiple pyfont files

* various font faces
* various sizes
* various styles
* etc

The system uses freetype-py. I have found that the generated bitmaps are
pretty crude at small sites, even with fonts that are intended for use at
low resolution.

I prefer to use hand-drawn bitmap fonts. There are collection available
with suitable licenses. The Adobe X11 fonts are ideal.


Setup
=====

    git clone git@github.com:peterhinch/micropython-font-to-py.git

    git clone git@github.com:ironss/micropython-fonts.git
    cd micropython-fonts
    python3 -m venv .venv
    .venv/bin/pip install -r pip-requirements.txt


Install font sources
====================

    wget https://www.cl.cam.ac.uk/~mgk25/download/ucs-fonts-75dpi100dpi.tar.gz
    mkdir fonts/bdf
    tar -C fonts/bdf/ -xvzf ucs-fonts-75dpi100dpi.tar.gz 75dpi 100dpi


Font sources
============

* Adobe proportional X11 bitmap fonts   https://www.cl.cam.ac.uk/~mgk25/download/ucs-fonts-75dpi100dpi.tar.gz
* X11 monospaced bitmap fonts           https://www.cl.cam.ac.uk/~mgk25/download/ucs-fonts.tar.gz

Fonts to try
============

* Helvetica
* Verdana
* Tahoma
* Lucida Sans
* Calibri
* MS Sans Serif

* Segoe UI
* Inter UI

* Charter
* Fourier
* Lucida Bright

* Myriad condensed
* Workplace Sans
* PT Sans Narrow

* Unscii
* Montserrat


Icon fonts
==========

* Fontawesome
* Climacons
* EF WeatherIcons
* Iconvault Forecast Font
* Meteocons
* PE Icon Set Weather
* Typicons


Charsets
========

Assume that it is not reasonable to include the whole set of Unicode characters
as bitmap fonts. So we need to choose a suitable subset. This will be based on

* the characters that the target application needs to display
* the characters that are available in the font file

During the pre-Unicode era, fonts were restricted to 256 characters. Various 
companies and standards bodies created sets of characters suitable for
different languages, applications, etc.

In addition, various people and standards bodies have created subsets of
characters suitable for different applications.

These subsets contain a few hundred to a few thousand characters.

Some subsets are

* ASCII
* ISO-8895-x series, for different European regions
* MAC Roman, Greek and Cyrillic sets
* MES-1, MES-2, MES-3 and MES-4, a number of Multilingual European Subsets
* SECS and VSECS by Marcus Kuhn
* PalmOS
* IBM PC, including the low-range characters 01--1F.
* PETSCII


X11 Adobe font sizes
====================

Name     dpi  req  asc desc

helvR08   75   10    9    2
helvR10   75   12   11    2
helvR12   75   14   12    3
helvR14   75   16   14    3
helvR18   75   21   18    4
helvR24   75   27   24    5

helvR08  100   12   11    2
helvR10  100   16   14    3
helvR12  100   18   16    4
helvR14  100   20   18    4
helvR18  100   27   24    5
helvR24  100   35   31    7

luRS08    75    9    8    2
luRS10    75   11    9    2
luRS12    75   13   11    2
luRS14    75   15   13    2
luRS18    75   19   16    3
luRS19    75   21   18    4
luRS24    75   27   22    5

luRS08   100   13   10    2
luRS10   100   16   13    3
luRS12   100   19   16    3
luRS14   100   23   18    4
luRS18   100   29   23    5
luRS19   100   30   24    5
luRS24   100   39   32    7
