global notifications, adVolume, spotifyVolume, previousTrack, errPath

on run
	set notifications to true
	set adVolume to 0
	set spotifyVolume to 100
	set previousTrack to ""
	set errPath to (path to home folder as text) & "spooffy_error.log"
	
	tell application "Spotify"
		if it is running then
			try
				set spotifyVolume to get sound volume
			on error errMsg number errNum
				set errLog to open for access file errPath with write permission
				write "Error during initial get volume call: " & errMsg & " (" & errNum & ")\n" to errLog starting at eof
				close access errLog
			end try
			try
				set previousTrack to get spotify url of current track
			on error errMsg number errNum
				set errLog to open for access file errPath with write permission
				write "Error during initial get current track call: " & errMsg & " (" & errNum & ")\n" to errLog starting at eof
				close access errLog
			end try
		end if
	end tell
end run

on idle
	if application "Spotify" is running then
		try
			tell application "Spotify" to set {spotifyUrl, trackName, trackArtist, trackAlbum} to get {spotify url of current track, name of current track, artist of current track, album of current track}
		on error errMsg number errNum
			set errLog to open for access file errPath with write permission
			write "Error getting current track info: " & errMsg & " (" & errNum & ")\n" to errLog starting at eof
			close access errLog
			set spotifyUrl to ""
		end try
		if previousTrack is not equal to spotifyUrl then
			if spotifyUrl starts with "spotify:ad:" and previousTrack starts with "spotify:track:" then
				if notifications then
					display notification "Muting ads!" with title "Spooffy"
				end if
				try
					tell application "Spotify"
						set spotifyVolume to get sound volume
						set sound volume to adVolume
					end tell
				on error errMsg number errNum
					set errLog to open for access file errPath with write permission
					write "Error switching to ads volume: " & errMsg & " (" & errNum & ")\n" to errLog starting at eof
					close access errLog
				end try
				delay 15 # ads are 15-30 seconds long
			else if spotifyUrl starts with "spotify:track:" and previousTrack starts with "spotify:ad:" then
				if notifications then
					display notification "Artist: " & trackArtist & " | Album: " & trackAlbum with title "Spooffy" subtitle "Title: " & trackName
				end if
				try
					tell application "Spotify" to set currentVolume to get sound volume
				on error errMsg number errNum
					set errLog to open for access file errPath with write permission
					write "Error trying to get current sound volume: " & errMsg & " (" & errNum & ")\n" to errLog starting at eof
					close access errLog
				end try
				if currentVolume is equal to adVolume then
					try
						tell application "Spotify" to set sound volume to spotifyVolume
					on error errMsg number errNum
						set errLog to open for access file errPath with write permission
						write "Error trying to set sound volume back: " & errMsg & " (" & errNum & ")\n" to errLog starting at eof
						close access errLog
					end try
				end if
				delay 60 # we probably have a little time till the next wave
			else if spotifyUrl starts with "spotify:track:" then
				if notifications then
					display notification "Artist: " & trackArtist & " | Album: " & trackAlbum with title "Spooffy" subtitle "Title: " & trackName
				end if
			end if
			set previousTrack to spotifyUrl
		end if
	end if
	return 1
end idle

on quit
	continue quit
end quit