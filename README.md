# HDGSOM
Implementation of High Dimensional Growing Self Organizing Maps in R

(Original GSOM code from https://github.com/alexhunziker/GrowingSOM)

Mainly based on:
__Damminda Alahakoon, Saman K. Halgamuge (2000)__: Dynamic Self-Organizing Maps with Controlled Growth for Knowledge Discovery. IEEE TRANSACTIONS ON NEURAL NETWORKS, VOL. 11.

And

__R. Amarasiri, D. Alahakoon, K.A. Smith__: HDGSOM: a modified growing self-organizing map for high dimensional data clustering. Hybrid Intelligent Systems, 2004. HIS '04. Fourth International Conference on, 2004, pp. 216-221.
doi: 10.1109/ICHIS.2004.52

## Functionality

- train.gsom()
- train_xy.gsom()
- map.gsom()
- predict.gsom()
- summary.gsom()
- print.gsom()
- plot.gsom()

## Installation

Make a R Package out of the folder gsom_pkg using the command:

```bash
	R CMD build gsom-pkg
```

Windows may need a binary Package which can be obtained by:

```bash
	mkdir temp_location
	R CMD INSTALL --build -l temp_location GrowingSOM_VERSION.tar.gz
```

installation Linux (in R):
```R
	install.packages(repos=NULL,"GrowingSOM_0.1.tar.gz")
```

installation Windows (in R):
```R
	install.packages(repos=NULL, "C:/Users/hunzikal/Downloads/NetCoS_1.0.zip", type="binary")
```

## Legal

GrowingSOM is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

GrowingSOM is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with GrowingSOM.  If not, see <http://www.gnu.org/licenses/>.
