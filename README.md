# MySelfcare Client

A safe place to write your thoughts, and track the progress of mental health recovery.


### Software Licensing
This program is licensed under the GNU General Public License Version 3. For details consult the LICENSE file.

Some source files are special cases and licensed under more permissive licenses such as Apache Version 2. This is done where
the code is copied whole or in part from another individual who has licensed the software as such. Licenses are preserved so that authorship and rights
do not be confused, and to protect and thank those authors who made this work possible. Such special files will have a license notice at the top of each file clearly demarking them as licensed differently from GPLv3.

## Setting Up Your Development Environment

- Download latest stable nodejs from [here](https://nodejs.org/en/)
- `npm install --global yarn purescript pulp bower`
- From the project directory: `yarn install && bower install`
- Run the program in dev mode: `yarn dev`
- Addition scripts for it can be found in `package.json`'s scripts object.
- To create a new feature branch to do development, use `git checkout -b MYBRANCHNAME`
- To contribute your feature back, please simply create a pull request with a description of its intent.


## Getting oriented.
- The project uses [purescript-halogen](https://github.com/slamdata/purescript-halogen) For rendering
- It's important to note that the documentation for halogen on [pursuit](https://pursuit.purescript.org/packages/purescript-halogen/) are not up to date.
