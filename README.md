DefaultMarginDisabler
=====================
This is a Xcode Plugin sets a default value of 'Constrain to margins' to disabled.

![screenshot.png](screenshot.png)

Installation
------------
You can install the plugin via [Alcatraz](http://alcatraz.io/), the plugin manager for Xcode.

### For Xcode 8 beta or later

At least, Xcode 8 beta probably refuses to load unsigned code. So you can't use this plugin as well. Not only this, but all of Xcode's plugins.
If you want to avoid this restriction, try this command in your terminal.

```sh
$ codesign --remove-signature /Applications/Xcode-beta.app
```

(Maybe You will see the following error. But it seems that we can ignore it.)

```sh
/Applications/Xcode-beta.app: invalid or unsupported format for signature
```

But, please remember [why this restriction happened](https://en.wikipedia.org/wiki/XcodeGhost). If you want to keep the security of your apps, this workaround might be not good[.](https://youtu.be/ZXsQAXx_ao0)

See more details about it from [this page](https://github.com/alcatraz/Alcatraz/issues/475).

License
-------
The plugin is a [beerware](https://en.wikipedia.org/wiki/Beerware) licensed software.