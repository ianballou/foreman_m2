# Foreman M2

The Foreman M2 plugin introduces M2 functionality into Foreman.  This is currently in-progress.  Related: https://github.com/ianballou/smart_proxy_m2

## Pre-requirements

- TFTP & DHCP servers
- Smart-Proxy plugin that has M2 among its capabilities (see link above)
- Note: In 0.0.1 & 0.0.2, ensure that the M2 smart proxy is called "proxy_m2".  This will be addressed in the next release.
- Working M2 installation with images imported to the M2 project in use
- Currently supports M2 commit 5b93852d3d1e73deecfa162fdc0b833ae84eb5a5

## Installation

See [How_to_Install_a_Plugin](http://projects.theforeman.org/projects/foreman/wiki/How_to_Install_a_Plugin)
for how to install Foreman plugins

Be sure to run `rake db:seed` to seed the database.

## Usage

1) Create an M2 compute resource
2) Relate M2 provisioning templates to the M2 computer resource
3) Create M2 images in the M2 compute resource
**NOTE: For now, ensure that the entered image name matches the one in the drop-down menu.**
4) Create host using M2 provider  **Note: make sure to select "Network & Image Based" provisioning method.**

## TODO

- ~~Query for M2 smart proxy by some method other than its name~~
  - Fixed in 0.0.2
- Testing
- Disk management interface in Foreman

## Known issues
- SSH orchestration attempts after host creation sometimes delay the generation of PXE boot files if there aren't enough server workers
  - Try 5 workers

## Contributing

Fork and send a Pull Request. Thanks!

## Copyright

Copyright (c) 2018 Ian Ballou

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.

