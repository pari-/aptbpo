puppet module for enhancing the apt package provider
====================================================

Often, pinning an individual package for using backports simply does not suffice, and pinning all recursive dependencies is a no-go as well.
Meanwhile, we have 'install_options' (i.e. the provider accepts options to be passed to the installer command) support in puppet, but only the windows msi provider uses it.

The goal of this module was it to get the opportunity to set the target release (among various other options) and therefor properly installing packages from backports.

Basic usage
-----------

Simply use it!:

<pre>
	package {'your_fav_software':
		ensure          => present,
		provider        => 'aptbpo',
		install_options => { '-t' => 'squeeze-backports' },
	}
</pre>

Caveats
-------

None so far.

Copyright and License
---------------------

Copyright (C) 2012 Patrick Ringl <patrick_@freenet.de>

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License along
with this program; if not, write to the Free Software Foundation, Inc.,
51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.


