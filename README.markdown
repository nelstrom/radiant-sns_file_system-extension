SnS File System
===============

This extension works together with the [SnS][1] and [file_system][2] extensions to add easy file-based management of your Stylesheets and Javascripts.

Installation
------------

From the root of your Radiant project, run:

    git clone git://github.com/nelstrom/radiant-sns_file_system-extension.git vendor/extensions/sns_file_system

Usage
-----

The rake tasks that come with `file_system` are enhanced to include the Javascript and Stylesheet models from the SnS extension. If you have correctly installed the 3 extensions, you should be able to run:

    $ rake -T file_system
    rake file_system:to_db                   # Loads all content models from the filesystem.
    rake file_system:to_db:javascripts       # Loads all javascripts from the filesystem.
    rake file_system:to_db:stylesheets       # Loads all stylesheets from the filesystem.
    ...etc.
    rake file_system:to_files                # Saves all content models to the filesystem.
    rake file_system:to_files:javascripts    # Saves all javascripts in the database to the filesystem.
    rake file_system:to_files:stylesheets    # Saves all stylesheets in the database to the filesystem.
    ...etc.

### From database to file system

By running `rake file_system:to_db`, all Pages, Layouts, Snippets, Javascripts and Stylesheets will be saved to the file system. For the SnS models, the format of the filename is as follows:

    design/javascripts/name(.min).extension
    design/stylesheets/name(.min).extension

* `name` is the complete name of your file, as it is stored in the database. If you have a stylesheet called `typography.css`, then its name is "typography.css"
* `.min` is included in the filename if you are using the [sns_minifier][3] extension, and the current record has `minify = true`
* `.extension` will default to ".js" for javascripts and ".css" for stylesheets. If you have the [sns\_sass\_filter][4], then ".sass" will be used for sylesheets that use the sass filter

Note that if you include an extension in the name of a Stylesheet or Javascript, then it may double up when saved to the file system using the above convention. E.g. if you have the files "typography.css" and "application.js", and neither one is minified or filtered, they will be saved to the file system as "typography.css.css" and "application.js.js" respectively. Admittedly, this looks a little bit silly, but it is necessary to ensure that file names are unambiguous. The important thing is that the final extension correctly reflects the content type, so that your text editor may enter the appropriate editing mode.

The following table shows how the filename is generated for a stylesheet under various circumstances:


    name              minify    sass    filename
    ==============    ======    ====    =======================
    typography            --    --      typography.css
    typography           yes    --      typography.min.css
    typography            --    yes     typography.sass
    typography           yes    yes     typography.min.sass
    typography.css        --    --      typography.css.css
    typography.css       yes    --      typography.css.min.css
    typography.css        --    yes     typography.css.sass
    typography.css       yes    yes     typography.css.min.sass

If you decide that "typography.sass" should be minified after all, then you can rename it to "typography.min.sass". When `rake file_system:to_db` is run, the corresponding database record will have "minify" set to true. If, on the other hand, you decide that you no longer want to use the sass filter, you could rename the file to "typography.css", or "typography.min.css" if you want to minify it.

You are advised to not alter the "name" portion of a filename, after running `rake file_system:to_files`. As long as this is left intact, then running `rake file_system:to_db` should update the same database record that generated the file in the first place. If you were to alter the "name" part of the filename, then running `rake file_system:to_db` would cause the original database record to be deleted, and a new record to be created with the new name. The following scenario outlines a possible gotcha:

Say you're layout loads a stylesheet called "typography.css". It would expect to find a stylesheet called "typography.css". This could be saved to the filesystem as "typography.css.css" (if it was not minified or filtered). Now, if you decided to rename the file to "typography.css" on the file system, then the next time you run `rake file_system:to_db`, it would replace the old "typography.css" entry in the database with a new record called "typography". If your layout is still trying to load a file called "typography.css", then it won't find what it is looking for. So if you are tinkering with the "name" portion of a stylesheet on the filesystem, be sure that you update any links to the stylesheet from your layouts.

## From file system to database

To load your files from the file system back into the database, just run the command:

    rake file_system:to_db



[1]: http://github.com/SwankInnovations/radiant-sns-extension/
[2]: http://github.com/nelstrom/radiant-file-system-extension/
[3]: http://github.com/SwankInnovations/radiant-sns-minifier-extension/
[4]: http://github.com/SwankInnovations/radiant-sns-sass-filter-extension/