# Spooffy :bird:

The friendly avian ad silencer! Spooffy monitors the Spotify application, and when it notices an ad, silences it for you. It re-enables sound when the ads are done and the next track plays.

* Displays notifications of new tracks playing or when it's silencing ads
* Written entirely in Applescript, no compiler necessary!
* Small and resource-efficient

## Who Uses Spooffy

Just me, but you could try it too and let me know what you think.

## Why Use Spooffy?
I used to use [Spotifree](https://github.com/ArtemGordinsky/SpotiFree) but it's now unsupported. I switched to [MuteSpotifyAds](https://github.com/simonmeusel/MuteSpotifyAds) but it has a bug where it doesn't unmute sometimes. Spooffy was my attempt to figure out how the Applescript Spotify API works, and it ended up working so well I named it.

## Usage

Launch Spooffy whenever you want to listen to music on Spotify and not hear the ads. And also not pay to have it ad-free. :money_with_wings:

## How to Build
You can make your own Spooffy! 
1. Open Spooffy.applescript in Script Editor (macOS defaults to this action)
2. Make any changes you want
3. Go to File -> Export
  1. Choose "File Format: Application"
  2. Check the box for "Stay open after run handler"
4. To update the icon, fix up the paths and run the following in your Terminal app:
```
# put the icon in the app
cp path/to/applet.icns path/to/Spooffy.app/Contents/Resources/
# get macOS to realize it's different
sudo touch path/to/Spooffy.app
sudo touch path/to/Spooffy.app/Contents/Info.plist
sudo killall Dock
```

## License
[Mozilla Public License 2.0](LICENSE)

### Icon
Icon courtesy of https://publicdomainvectors.org/
